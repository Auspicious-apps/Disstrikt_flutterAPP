/*
<!--

  ~ @author     :Puneet Kumar
  ~ All Rights Reserved.
  ~ Proprietary and confidential :  All information contained herein is, and remains

  ~ Unauthorized copying of this file, via any medium is strictly prohibited.
  ~
  -->z
 */

import 'package:disstrikt/app/export.dart';
import 'package:disstrikt/app/modules/auth/models/responseModels/userResponseModel.dart';
import 'package:get/get.dart';

import '../../../core/widget/intl_phone_field/countries.dart';
import '../../../data/local/preferences/preference.dart';
import '../Models/GetJobDetailResponseModel.dart';

class JobdetailController extends GetxController {
  GetJobsDetailResponse? userResponseModel;
  var isLoading = false.obs;
  var isloading = false.obs;
  var Id = "".obs;
  final LocalStorage localStorage = LocalStorage();
  @override
  void onInit() {
    if (Get.arguments != null) {
      Id.value = Get.arguments["ID"];
      print(Id.value);
      GetJobDetail();
    }
    super.onInit();
  }

  Future<void> GetJobDetail() async {
    try {
      isLoading.value = true;

      Get.closeAllSnackbars();
      final response = await repository.getJobsDetailApiCall(ID: Id.value);
      if (response != null) {
        userResponseModel = response;
      }
    } catch (er) {
      print("Error: $er");
      Get.closeAllSnackbars();
      Get.snackbar('Error', '$er');
    } finally {
      isLoading.value = false;
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

  handleSubmit(var data) {
    isloading.value = true;
    isloading.refresh();
    try {
      Get.closeAllSnackbars();
      repository.jobApplyApiCall(dataBody: data).then((value) async {
        if (value != null) {
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
          GetJobDetail();
          isloading.value = false;
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

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
