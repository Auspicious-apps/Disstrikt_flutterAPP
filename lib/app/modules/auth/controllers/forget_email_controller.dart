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

import '../../../core/utils/localization_service.dart';
import '../../../core/widget/intl_phone_field/countries.dart';

class ForgetEmailController extends GetxController {
  final signupFormKey = GlobalKey<FormState>();
  final emailAddressController = TextEditingController();
  final emailAddressFocusNode = FocusNode();
  UserResponseModel? userResponseModel;
  RxBool isloading = false.obs;

  handleSubmit(var data) {
    isloading.value = true;
    isloading.refresh();
    try {
      Get.closeAllSnackbars();
      repository.forgetEmailApiCall(dataBody: data).then((value) async {
        if (value != null) {
          userResponseModel = value;
          final language = LocalizationService.getLanguageName(
              LocalizationService.currentLocale);
          Get.offNamed(AppRoutes.OtpScreen, arguments: {
            "email": emailAddressController?.text,
            "language": language == "English"
                ? "en"
                : language == "Dutch"
                    ? "nl"
                    : language == "French"
                        ? "fr"
                        : "es",
          });
          isloading.value = false;

          isloading.refresh();
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
}
