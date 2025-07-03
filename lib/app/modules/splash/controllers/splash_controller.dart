/*
<!--
       
  ~ @author     :Puneet Kumar
  ~ All Rights Reserved.
  ~ Proprietary and confidential :  All information contained herein is, and remains
 
  ~ Unauthorized copying of this file, via any medium is strictly prohibited.
  ~
  -->
 */

import '../../../data/local/preferences/preference.dart';
import '../../../export.dart';

class SplashController extends GetxController {
  String? token;
  final LocalStorage _localStorage = LocalStorage();

  @override
  void onInit() {
    super.onInit();

    token = _localStorage.getAuthToken();
    print(token);
    // if (token != null) {
    //   Get.offAllNamed(AppRoutes.UserInfo);
    // } else {
    //   Get.offAllNamed(AppRoutes.chooseLanguage);
    // }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
