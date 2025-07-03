/*
 * @copyright : Henceforth Pvt. Ltd. <info@henceforthsolutions.com>
 * @author     : Gaurav Negi
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of Henceforth Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 *
 */

import 'package:disstrikt/app/export.dart';

class ThemeController extends GetxController {
  RxBool isDarkMode = isDarkModeTheme;

  @override
  void onInit() {
    ever(isDarkModeTheme, (isDark) {
      isDarkMode.value = isDark;
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness:
              isDarkMode.value == true ? Brightness.light : Brightness.dark));
    });
    super.onInit();
  }
}
