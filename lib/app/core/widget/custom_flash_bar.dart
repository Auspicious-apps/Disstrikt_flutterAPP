

/*
<!--
       
  ~ @author     :Puneet Kumar
  ~ All Rights Reserved.
  ~ Proprietary and confidential :  All information contained herein is, and remains
 
  ~ Unauthorized copying of this file, via any medium is strictly prohibited.
  ~
  -->
 */

import 'package:disstrikt/app/export.dart';


toast(content, {seconds}) {
  Get.closeAllSnackbars();
  return Get.snackbar("Clickspert", content,
      colorText: Colors.black,
      duration: const Duration(seconds: 1),
      snackPosition: SnackPosition.TOP,
      snackStyle: SnackStyle.FLOATING,
      padding: EdgeInsets.symmetric(horizontal: margin_20, vertical: margin_15),
      margin: EdgeInsets.symmetric(horizontal: margin_15, vertical: margin_15),
      barBlur: 20.0,
      backgroundColor: AppColors.appColor.withOpacity(0.8));
}
