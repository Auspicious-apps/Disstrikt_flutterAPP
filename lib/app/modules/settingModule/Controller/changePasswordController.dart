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
import '../Models/ReponseModel/StaticModel.dart';

class Changepasswordcontroller extends GetxController {
  StatiResponseModel? staticdatamodel;
  final LocalStorage _localStorage = LocalStorage();
  final PasswordTextController = TextEditingController();
  final PasswordFocusNode = FocusNode();
  final newPasswordTextController = TextEditingController();
  final newPasswordFocusNode = FocusNode();
  final ConfiormPasswordTextController = TextEditingController();
  final ConfiormPasswordFocusNode = FocusNode();
  RxBool isLoading = false.obs;
  RxBool ShowPassword = false.obs;
  RxBool ShowNeewPassword = false.obs;
  RxBool ShowConfirmPassword = false.obs;
  UserResponseModel? userResponseModel;
  RxBool isloading = false.obs;
  final signupFormKey = GlobalKey<FormState>();
  @override
  void onInit() {
    super.onInit();
  }

  handleSubmit(var data) {
    isloading.value = true;
    isloading.refresh();
    try {
      Get.closeAllSnackbars();
      repository.ChangePasswordApiCall(dataBody: data).then((value) async {
        if (value != null) {
          userResponseModel = value;
          isloading.value = false;
          isloading.refresh();
          Get.back();
          Get.closeAllSnackbars();
          Get.snackbar(
            'Success',
            '${userResponseModel?.message}',
            backgroundColor: Colors.white.withOpacity(0.5),
          );
        }
      }).onError((er, stackTrace) {
        print("$er");
        isloading.value = false;
        isloading.refresh();
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
