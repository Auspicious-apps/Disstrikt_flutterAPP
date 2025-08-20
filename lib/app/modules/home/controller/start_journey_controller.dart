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
import '../models/responseModels /HomePageResponseModel.dart';

class StartJourneyController extends GetxController {
  Rx<HomeResponseModel>? userResponseModel = HomeResponseModel().obs;

  final LocalStorage localStorage = LocalStorage();
  var currentpage = 1.obs;
  var isLoading = true.obs;
  @override
  void onInit() {
    GetHomeDetail();

    super.onInit();
  }

  GetHomeDetail() {
    try {
      isLoading.value = true;
      repository.gethomeApiCall(
          query: {"page": currentpage.value, "limit": 50}).then((value) async {
        if (value != null) {
          var token = localStorage.getAuthToken();
          print(token);
          userResponseModel?.value = value;
          isLoading.value = false;
        }
      }).onError((er, stackTrace) {
        print("$er");
        Get.closeAllSnackbars();
        isLoading.value = false;
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

  logout() async {
    try {
      final response = await repository.logoutApi();

      if (response != null) {
        localStorage.clearLoginData();
        userResponseModel?.value = response;
        Get.snackbar(
          "Success",
          "${userResponseModel?.value.message}",
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
