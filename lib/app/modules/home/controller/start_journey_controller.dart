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

class StartJourneyController extends GetxController {
  UserResponseModel? userResponseModel;
  final LocalStorage _localStorage = LocalStorage();
  @override
  void onInit() {
    GetHomeDetail();
    super.onInit();
  }

  GetHomeDetail() {
    try {
      repository.gethomeApiCall().then((value) async {
        if (value != null) {
          userResponseModel = value;
        }
      }).onError((er, stackTrace) {
        print("$er");
        Get.closeAllSnackbars();
        Get.snackbar('Error', '$er');
      });
    } catch (er) {
      print("$er");
    }
  }

  logout() async {
    try {
      final response = await repository.logoutApi();

      if (response != null) {
        _localStorage.clearLoginData();
        userResponseModel = response;
        Get.snackbar("Success", "${userResponseModel?.message}");
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
