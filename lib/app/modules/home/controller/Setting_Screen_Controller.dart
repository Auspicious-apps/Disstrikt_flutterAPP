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
  UserResponseModel? userResponseModel;
  final LocalStorage _localStorage = LocalStorage();
  @override
  void onInit() {
    super.onInit();
  }

  logout() async {
    try {
      final response = await repository.logoutApi();

      if (response != null) {
        _localStorage.clearLoginData();
        userResponseModel = response;
        Get.snackbar(
          "Success",
          "${userResponseModel?.message}",
          backgroundColor: Colors.white.withOpacity(0.5),
        );
        Get.offAllNamed(AppRoutes.loginRoute);
      }
    } catch (e) {
      print(">>>>>>>>>>>$e");
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
