/*
<!--
  ~ @author     :Puneet Kumar
  ~ All Rights Reserved.
  ~ Proprietary and confidential :  All information contained herein is, and remains
  ~ Unauthorized copying of this file, via any medium is strictly prohibited.
  ~
-->
*/
import 'package:disstrikt/app/export.dart';
import 'package:disstrikt/app/modules/auth/models/responseModels/userResponseModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/widget/intl_phone_field/countries.dart';
import '../../../data/local/preferences/preference.dart';
import '../Models/GetAllJobsResponseModel.dart';

class JobscreenController extends GetxController {
  GetAllJobsResponse? userResponseModel;
  final LocalStorage localStorage = LocalStorage();
  RxBool loading = false.obs;
  RxBool isloading = false.obs;
  RxBool applied = false.obs;
  RxBool isLoadingMore = false.obs;
  var index = 0;
  RxBool hasMore = true.obs;
  int currentPage = 1;
  var gender = "".obs;
  var JobType = "".obs;
  TextEditingController age = TextEditingController();
  final int pageSize = 20; // Adjust based on your API
  final ScrollController scrollController = ScrollController();
  RxString sortBy = "".obs; // Reactive variable for sort option
  final List<String> sortOptions = [
    "oldToNew".tr,
    "newToOld".tr,
    "highToLowPay".tr,
    "lowToHighPay".tr
  ]; // Available sort options
  @override
  void onInit() {
    super.onInit();
    resetAndFetchJobs();
    // Add scroll listener to detect when user reaches the end of the list
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent * 0.9 &&
          !isLoadingMore.value &&
          hasMore.value) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          loadMoreJobs();
        });
      }
    });
  }

  void resetAndFetchJobs() {
    currentPage = 1;
    userResponseModel = null;
    hasMore.value = true;
    GetProfileDetail();
  }

  Future<void> GetProfileDetail() async {
    bool isInitialLoad = currentPage == 1;
    try {
      if (isInitialLoad) {
        print("Loading started: ${loading.value}");
        loading.value = true;
      }
      Get.closeAllSnackbars();
      final response = await repository.getAllJObsApiCall(query: {
        "type": applied.value ? "APPLIED" : "NEW",
        "page": currentPage,
        "limit": pageSize,
        if (gender.value.isNotEmpty)
          "gender": gender.value == "strMale".tr ? "MALE" : "FEMALE",
        if (age.text.isNotEmpty) "age": int.parse(age.text),
        if (sortBy.value.isNotEmpty)
          "sort": sortBy.value == "oldToNew".tr
              ? "oldToNew"
              : sortBy.value == "newToOld".tr
                  ? "newToOld"
                  : sortBy.value == "highToLowPay".tr
                      ? "highToLowPay"
                      : "lowToHighPay"
      });
      if (response != null) {
        if (currentPage == 1) {
          userResponseModel = response;
        } else {
          userResponseModel?.data?.data?.addAll(response.data?.data ?? []);
        }
        hasMore.value = (response.data?.data?.length ?? 0) >= pageSize;
      } else {
        hasMore.value = false;
        Get.closeAllSnackbars();
      }
    } catch (er) {
      hasMore.value = false;
      print("Error: $er");
      Get.closeAllSnackbars();
      Get.snackbar('Error', '$er');
    } finally {
      if (isInitialLoad) {
        print("Loading ended: ${loading.value}");
        loading.value = false;
      }
    }
  }

  handleSubmit(var data, int index) {
    isloading.value = true;
    isloading.refresh();
    try {
      Get.closeAllSnackbars();
      repository.jobApplyApiCall(dataBody: data).then((value) async {
        if (value != null) {
          // Get.snackbar(
          //   'Success',
          //   '${userResponseModel?.message}',
          //   backgroundColor: Colors.white.withOpacity(0.5),
          // );
          showDialog(
            context: Get.context!,
            builder: (BuildContext context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                elevation: 0,
                backgroundColor: Colors.transparent,
                child: _buildOtpModalContent(context),
              );
            },
          );
          isloading.value = false;
          GetProfileDetail();
          isloading.refresh();
        }
      }).onError((er, stackTrace) {
        print("$er");
        isloading.value = false;

        Get.closeAllSnackbars();
        Get.snackbar(
          'Error',
          '${er}',
          backgroundColor: Colors.white.withOpacity(0.5),
        );
      });
    } catch (er) {
      isloading.value = false;
      isloading.refresh();
      print("$er");
    }
  }

  Widget _buildOtpModalContent(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.37,
      padding: EdgeInsets.symmetric(vertical: 20.0),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(imagemodalbackground), fit: BoxFit.fill),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            JobModal,
            height: 80,
            width: 80,
          ),
          TextView(
            text: "strAppliedSuccessfully".tr,
            textAlign: TextAlign.center,
            textStyle: const TextStyle(
                color: AppColors.blackColor,
                fontFamily: "minorksans",
                fontSize: 18,
                fontWeight: FontWeight.w800),
            maxLines: 4,
          ).marginOnly(top: 10),
          SizedBox(height: 10.0),
          TextView(
            text: "strJobSubheading".tr,
            textAlign: TextAlign.center,
            textStyle: const TextStyle(
                color: AppColors.blackColor,
                fontFamily: "Kodchasan",
                fontSize: 12,
                fontWeight: FontWeight.w400),
            maxLines: 4,
          ),
          SizedBox(height: 20.0),
          Row(
            children: [
              Expanded(
                child: Container(
                  child: MaterialButtonWidget(
                    buttonBgColor: Colors.transparent,
                    buttonRadius: 8,
                    isOutlined: true,
                    borderColor: AppColors.clickTextColor,
                    buttonText: "strOkay".tr,
                    buttonTextStyle: TextStyle(
                        fontSize: 12,
                        color: AppColors.blackColor,
                        fontFamily: "Kodchasan",
                        fontWeight: FontWeight.w600),
                    textColor: AppColors.whiteColor,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
              ),
            ],
          ).marginSymmetric(horizontal: 15),
        ],
      ),
    );
  }

  Future<void> loadMoreJobs() async {
    if (isLoadingMore.value || !hasMore.value) return;
    isLoadingMore.value = true;
    currentPage++;
    await GetProfileDetail();
    isLoadingMore.value = false;
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
