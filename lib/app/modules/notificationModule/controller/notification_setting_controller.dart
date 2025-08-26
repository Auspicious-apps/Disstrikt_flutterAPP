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
import '../models/Notification_Setting_Model.dart';

class NotificationSettingController extends GetxController {
  RxBool isLoading = false.obs;
  Rxn<NotificationSettingModel>? notificationSettingModel =
      Rxn<NotificationSettingModel>();

  @override
  void onInit() {
    super.onInit();
    GetNotificationSettingDetail();
  }

  GetNotificationSettingDetail() {
    try {
      isLoading.value = true;
      Get.closeAllSnackbars();
      repository.getNotificationSettingApiCall().then((value) async {
        if (value != null) {
          notificationSettingModel!.value = value;
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

  NotificationSettingChange(data) {
    try {
      Get.closeAllSnackbars();

      repository
          .changeNotificationSettingApiCall(dataBody: data)
          .then((value) async {
        if (value != null) {
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

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
