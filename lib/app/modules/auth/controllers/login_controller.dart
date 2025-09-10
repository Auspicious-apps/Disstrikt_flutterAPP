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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../firebase_options.dart';
import '../../../core/utils/localization_service.dart';
import '../../../core/widget/intl_phone_field/countries.dart';
import '../../../data/local/preferences/preference.dart';
import '../models/requestmodels/RequestModel.dart';
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

  Future<void> signInWithGoogle() async {
    try {
      Get.dialog(
        const Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(0.4), // Transparent background
      );
      final String clientId = defaultTargetPlatform == TargetPlatform.android
          ? DefaultFirebaseOptions.androidClientId
          : DefaultFirebaseOptions.iosClientId;

      print("Using Client ID: $clientId"); // Debug: Verify Client ID
      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: clientId,
      );

      // Sign out previous sessions to ensure fresh login
      await googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();

      // Start Google Sign-In flow
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        // Get.snackbar('Cancelled', 'Google Sign-In was cancelled by the user');
        print("Google Sign-In cancelled"); // Debug

        Get.back();
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      print("Google ID Token: ${googleAuth.idToken}>>>>>>>>>>>>>>>>>>>>>>>>");
      var selectedLanguage = LocalizationService.getLanguageName(
          LocalizationService.currentLocale);
      var selectedCountry = LocalizationService.currentCountry;
      Map<String, dynamic> requestModel =
          AuthRequestModel.socialloginApiRequest(
        deviceType: Platform.isAndroid ? "ANDROID" : "IOS",
        idToken: googleAuth.idToken ?? "",
        fcmToken: fcmtoken?.value ?? "",
        authType: "GOOGLE",
        language: selectedLanguage == "English"
            ? "en"
            : selectedLanguage == "Dutch"
                ? "nl"
                : selectedLanguage == "French"
                    ? "fr"
                    : "es",
        country: selectedCountry == "United Kingdom"
            ? "UK"
            : selectedCountry == "Belgium"
                ? "BE"
                : selectedCountry == "France"
                    ? "FR"
                    : selectedCountry == "Netherlands"
                        ? "NL"
                        : "ES",
      );

      final response = await repository.socialLoginApi(dataBody: requestModel);
      if (response != null) {
        userResponseModel = response;
        if (userResponseModel?.data?.token != null &&
            userResponseModel?.data?.isVerifiedEmail == true) {
          localStorage.saveAuthToken(userResponseModel?.data?.token);
          print(">>>>>>>>SaveToken ");

          if (userResponseModel?.data?.isUserInfoComplete == false) {
            Get.offNamed(AppRoutes.UserInfo);
          } else if (userResponseModel?.data?.subscription == "canceled" ||
              userResponseModel?.data?.subscription == null) {
            Get.offNamed(AppRoutes.ChoosePlan);
          } else if (userResponseModel?.data?.subscription != "canceled" &&
              userResponseModel?.data?.subscription != null) {
            Get.offNamed(AppRoutes.StartJourney);
          }
        }
      }

      //
    } catch (e) {
      print("Google Sign-In error: $e"); // Debug
      if (e.toString().contains('ApiException: 10')) {
      } else {
        // Get.snackbar('Error', 'Google Sign-In failed: $e');
      }
    }
  }

  void AppleLogin(credentials) async {
    try {
      isloading.value = true;
      var selectedLanguage = LocalizationService.getLanguageName(
          LocalizationService.currentLocale);
      var selectedCountry = LocalizationService.currentCountry;
      Map<String, dynamic> requestModel =
          AuthRequestModel.socialloginApiRequest(
        deviceType: "IOS",
        idToken: credentials ?? "",
        fcmToken: fcmtoken?.value ?? "",
        authType: "APPLE",
        language: selectedLanguage == "English"
            ? "en"
            : selectedLanguage == "Dutch"
                ? "nl"
                : selectedLanguage == "French"
                    ? "fr"
                    : "es",
        country: selectedCountry == "United Kingdom"
            ? "UK"
            : selectedCountry == "Belgium"
                ? "BE"
                : selectedCountry == "France"
                    ? "FR"
                    : selectedCountry == "Netherlands"
                        ? "NL"
                        : "ES",
      );

      final response = await repository.socialLoginApi(dataBody: requestModel);
      if (response != null) {
        userResponseModel = response;
        if (userResponseModel?.data?.token != null &&
            userResponseModel?.data?.isVerifiedEmail == true) {
          localStorage.saveAuthToken(userResponseModel?.data?.token);
          print(">>>>>>>>SaveToken ");

          if (userResponseModel?.data?.isUserInfoComplete == false) {
            Get.offNamed(AppRoutes.UserInfo);
          } else if (userResponseModel?.data?.subscription == "canceled" ||
              userResponseModel?.data?.subscription == null) {
            Get.offNamed(AppRoutes.ChoosePlan);
          } else if (userResponseModel?.data?.subscription != "canceled" &&
              userResponseModel?.data?.subscription != null) {
            Get.offNamed(AppRoutes.StartJourney);
          }
        }
      }

      //
    } catch (e) {
      isloading.value = false;
      print("Google Sign-In error: $e"); // Debug
      if (e.toString().contains('ApiException: 10')) {
      } else {
        // Get.snackbar('Error', 'Google Sign-In failed: $e');
      }
    } finally {
      Get.back(); // Close loader
    }
  }

  handleSubmit(var data) {
    isloading.value = true;
    isloading.refresh();
    try {
      Get.closeAllSnackbars();
      repository.loginApiCall(dataBody: data).then((value) async {
        if (value != null) {
          userResponseModel = value;
          Get.snackbar(
            'Success',
            '${userResponseModel?.message}',
            backgroundColor: Colors.white.withOpacity(0.5),
          );
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
          if (userResponseModel?.data?.token != null &&
              userResponseModel?.data?.isVerifiedEmail == true) {
            localStorage.saveAuthToken(userResponseModel?.data?.token);
          }
          if (userResponseModel?.data?.isUserInfoComplete == false &&
              userResponseModel?.data?.isVerifiedEmail == true) {
            Get.offNamed(AppRoutes.UserInfo);
          }
          if (userResponseModel?.data?.isVerifiedEmail == true &&
                  userResponseModel?.data?.subscription == "canceled" &&
                  userResponseModel?.data?.isUserInfoComplete == true ||
              userResponseModel?.data?.isVerifiedEmail == true &&
                  userResponseModel?.data?.subscription == null &&
                  userResponseModel?.data?.isUserInfoComplete == true) {
            Get.offNamed(AppRoutes.ChoosePlan);
          }
          if (userResponseModel?.data?.isVerifiedEmail == true &&
              userResponseModel?.data?.subscription != "canceled" &&
              userResponseModel?.data?.subscription != null) {
            Get.offNamed(AppRoutes.StartJourney);
          } else if (userResponseModel?.data?.isVerifiedEmail == false) {
            Get.offNamed(AppRoutes.OtpScreen, arguments: {
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
        Get.snackbar(
          'Error',
          '$er',
          backgroundColor: Colors.white.withOpacity(0.5),
        );
      });
    } catch (er) {
      isloading.value = false;
      isloading.refresh();
      print("$er");
      Get.snackbar(
        'Error',
        '$er',
        backgroundColor: Colors.white.withOpacity(0.5),
      );
    }
  }
}
