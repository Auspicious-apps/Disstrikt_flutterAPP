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

class SettingScreenController extends GetxController {
  Rx<UserResponseModel> userResponseModel = UserResponseModel().obs;
  var image = "".obs;
  final LocalStorage _localStorage = LocalStorage();
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    GetUserProfile();
    super.onInit();
  }

  logout() async {
    try {
      isLoading.value = true;
      final response = await repository.logoutApi();

      if (response != null) {
        _localStorage.clearLoginData();
        userResponseModel.value = response;
        image.value = userResponseModel?.value.data?.image ?? "";
        isLoading.value = false;
        Get.snackbar(
          "Success",
          "${userResponseModel?.value.message}",
          backgroundColor: Colors.white.withOpacity(0.5),
        );
        Get.offAllNamed(AppRoutes.loginRoute);
      }
    } catch (e) {
      isLoading.value = false;
      print(">>>>>>>>>>>$e");
    }
  }

  deleteUser() async {
    try {
      isLoading.value = true;
      final response = await repository.deleteAccountApi();

      if (response != null) {
        _localStorage.clearLoginData();
        userResponseModel.value = response;
        isLoading.value = false;
        Get.snackbar(
          "Success",
          "${userResponseModel?.value.message}",
          backgroundColor: Colors.white.withOpacity(0.5),
        );
        Get.offAllNamed(AppRoutes.loginRoute);
      }
    } catch (e) {
      isLoading.value = false;
      print(">>>>>>>>>>>$e");
    }
  }

  GetUserProfile() {
    try {
      isLoading.value = true;
      repository.GetProfile().then((value) async {
        if (value != null) {
          userResponseModel.value = value;
          isLoading.value = false;
        }
      }).onError((er, stackTrace) {
        print("$er");
        isLoading.value = false;
        Get.closeAllSnackbars();
        Get.snackbar(
          'Error',
          '$er',
          backgroundColor: Colors.white.withOpacity(0.5),
        );
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
