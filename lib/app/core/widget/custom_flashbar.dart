

/*
<!--
       
  ~ @author     :Puneet Kumar
  ~ All Rights Reserved.
  ~ Proprietary and confidential :  All information contained herein is, and remains
 
  ~ Unauthorized copying of this file, via any medium is strictly prohibited.
  ~
  -->
 */

import '../../export.dart';

// showToast({String? message}) {
//   Fluttertoast.cancel();
//   Fluttertoast.showToast(
//     msg: message ?? "",
//     toastLength: Toast.LENGTH_SHORT,
//     gravity: ToastGravity.BOTTOM,
//     backgroundColor: AppColors.toastColor,
//     textColor: Colors.black,
//     fontSize: font_13,
//   );
//
// }
showToast({String? message}) {
  Get.closeAllSnackbars();
  Get.snackbar(
    "strApplicationName".tr,
    message??"",
    colorText: Colors.black,
  );
}