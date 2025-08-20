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
import '../../../data/local/preferences/preference.dart';
import '../models/ResponseModels/TaskDetailResponseModel.dart';

class TaskdetailController extends GetxController {
  final LocalStorage _localStorage = LocalStorage();
  final doneWriteSectionTextController = TextEditingController();
  final doneWriteSectionFocusNode = FocusNode();

  RxBool isLoading = true.obs;
  var type = "".obs;

  final signupFormKey = GlobalKey<FormState>();

  Rx<TaskDetailModel>? taskDetailModel = TaskDetailModel().obs;

  @override
  void onInit() {
    if (Get.arguments != null) {
      var id = Get.arguments["id"];
      type.value = Get.arguments["type"];
      type.refresh();
      GetTaskDetail(id);
    }
    super.onInit();
  }

  // @override
  // void onReady() {
  //   var id = Get.arguments["id"];
  //   print(id);
  //   if (Get.arguments != null) {
  //     GetTaskDetail(id);
  //   }
  //   super.onReady();
  // }

  GetTaskDetail(String? id) {
    try {
      isLoading.value = true;
      Get.closeAllSnackbars();
      repository.getTaskDetailApiCall(ID: id).then((value) async {
        if (value != null) {
          taskDetailModel?.value = value;
          isLoading.value = false;
        } else {
          isLoading.value = false;
          Get.closeAllSnackbars();
        }
      }).onError((er, stackTrace) {
        print("$er");
        isLoading.value = false;
        Get.closeAllSnackbars();
        Get.snackbar('Error', '$er');
      });
    } catch (er) {
      isLoading.value = false;
      print("$er");
    }
  }

  submitTaskDetail(String? id, data) {
    try {
      isLoading.value = true;
      Get.closeAllSnackbars();
      repository.TaskSubmitApiCall(ID: id, dataBody: data).then((value) async {
        if (value != null) {
          taskDetailModel?.value = value;
          isLoading.value = false;
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
        } else {
          isLoading.value = false;
          Get.closeAllSnackbars();
        }
      }).onError((er, stackTrace) {
        print("$er");
        isLoading.value = false;
        Get.closeAllSnackbars();
        Get.snackbar('Error', '$er');
      });
    } catch (er) {
      isLoading.value = false;
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
            TaskSubmited,
            height: 80,
            width: 80,
          ),
          TextView(
            text: "strTaskSubmitted".tr,
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
            text: "strTaskModalSubHeading".tr,
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
                    buttonText: "strContinue".tr,
                    iconWidget: Icon(Icons.arrow_forward_sharp,
                        size: 15, color: AppColors.backgroundColor),
                    buttonTextStyle: TextStyle(
                        fontSize: 12,
                        color: AppColors.blackColor,
                        fontFamily: "Kodchasan",
                        fontWeight: FontWeight.w600),
                    textColor: AppColors.whiteColor,
                    onPressed: () {
                      Get.back();
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

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
