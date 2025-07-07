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
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/utils/localization_service.dart';
import '../../../core/widget/intl_phone_field/countries.dart';
import '../../../data/local/preferences/preference.dart';
import '../models/responseModels/userResponseModel.dart';

class LoginController extends GetxController {
  final emailAddressController = TextEditingController();
  final emailAddressFocusNode = FocusNode();
  final PasswordTextController = TextEditingController();
  final PasswordFocusNode = FocusNode();
  RxBool rememberMe = false.obs;
  RxBool isloading = false.obs;
  var country = "".obs;
  var language = "".obs;
  RxBool ShowPassword = false.obs;
  UserResponseModel? userResponseModel;
  final signupFormKey = GlobalKey<FormState>();
  var fcmtoken = ''.obs;

  final storage = GetStorage();
  final LocalStorage localStorage = LocalStorage();
  @override
  void onInit() async {
    String? token = await FirebaseMessaging.instance.getToken();
    fcmtoken.value = token!;
    final savedEmail = storage.read('email') ?? '';
    final savedPassword = storage.read('password') ?? '';
    final remember = storage.read('rememberMe') ?? false;

    if (remember) {
      emailAddressController.text = savedEmail;
      PasswordTextController.text = savedPassword;
      rememberMe.value = true;
    }
    print(">FCM:>>>>>>>:::::>>>>>>>>>>${token}????????");
    language.value =
        LocalizationService.getLanguageName(LocalizationService.currentLocale);
    country.value = LocalizationService.currentCountry;
    super.onInit();
  }

  handleSubmit(var data) {
    isloading.value = true;
    isloading.refresh();
    try {
      Get.closeAllSnackbars();
      repository.loginApiCall(dataBody: data).then((value) async {
        if (value != null) {
          userResponseModel = value;
          Get.snackbar('Success', '${userResponseModel?.message}');
          if (rememberMe.value) {
            storage.write('email', emailAddressController.text);
            storage.write('password', PasswordTextController.text);
            storage.write('rememberMe', true);
          } else {
            storage.remove('email');
            storage.remove('password');
            storage.write('rememberMe', false);
          }

          isloading.value = false;
          if (userResponseModel?.data?.token != null) {
            localStorage.saveAuthToken(userResponseModel?.data?.token);
          }
          if (userResponseModel?.data?.isUserInfoComplete == false) {
            Get.toNamed(AppRoutes.UserInfo);
          }
          if (userResponseModel?.data?.isVerifiedEmail == true &&
              userResponseModel?.data?.subscription == "canceled" &&
              userResponseModel?.data?.subscription == null) {
            Get.toNamed(AppRoutes.ChoosePlan);
          }
          if (userResponseModel?.data?.isVerifiedEmail == true &&
              userResponseModel?.data?.subscription != "canceled" &&
              userResponseModel?.data?.subscription != null) {
            Get.toNamed(AppRoutes.StartJourney);
          } else {
            Get.toNamed(AppRoutes.OtpScreen, arguments: {
              "email": emailAddressController.text,
              "language": language.value
            });
          }

          isloading.refresh();
        }
      }).onError((er, stackTrace) {
        print("$er");
        isloading.value = false;
        isloading.refresh();
        Get.closeAllSnackbars();
        Get.snackbar('Error', '${er}');
      });
    } catch (er) {
      isloading.value = false;
      isloading.refresh();
      print("$er");
    }
  }
}
