/*
<!--
       
  ~ @author     :Puneet Kumar
  ~ All Rights Reserved.
  ~ Proprietary and confidential :  All information contained herein is, and remains
 
  ~ Unauthorized copying of this file, via any medium is strictly prohibited.
  ~
  -->
 */

// import 'dart:ffi';

import 'package:disstrikt/app/modules/auth/models/responseModels/userResponseModel.dart';

import '../../../data/local/preferences/preference.dart';
import '../../../export.dart';

class SplashController extends GetxController {
  bool? firstLaunch;
  final LocalStorage localStorage = LocalStorage();
  UserResponseModel? userResponseModel;

  @override
  void onInit() {
    super.onInit();

    firstLaunch = localStorage.getFirstLaunch();
    print('First Launch: $firstLaunch');

    Timer(const Duration(seconds: 1), () {
      var token = localStorage.getAuthToken();
      if (token != null) {
        GetProfileDetail();
      } else {
        if (firstLaunch == true) {
          Get.offNamed(
              AppRoutes.chooseLanguage); // Navigate to onboarding screen
        }
      }
    });
  }

  GetProfileDetail() {
    try {
      Get.closeAllSnackbars();
      repository.getProfileApiCall().then((value) async {
        if (value != null) {
          userResponseModel = value;

          if (userResponseModel?.data?.isVerifiedEmail == false) {
            Get.offNamed(AppRoutes.loginRoute, arguments: {
              "email": userResponseModel?.data?.email,
              "language": userResponseModel?.data?.language
            });
          } else if (userResponseModel?.data?.isUserInfoComplete == false &&
              userResponseModel?.data?.isVerifiedEmail == true) {
            Get.offNamed(AppRoutes.UserInfo);
          } else if (userResponseModel?.data?.subscription == "canceled" ||
              userResponseModel?.data?.subscription == null) {
            Get.offNamed(AppRoutes.ChoosePlan);
          } else if (userResponseModel?.data?.subscription != "canceled" &&
              userResponseModel?.data?.subscription != null) {
            Get.offNamed(AppRoutes.StartJourney);
          }
        }
      }).onError((er, stackTrace) {
        print("$er");

        Get.closeAllSnackbars();
      });
    } catch (er) {
      print("$er");
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
