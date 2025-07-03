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

import '../../../core/widget/intl_phone_field/countries.dart';
import '../models/responseModels/userResponseModel.dart';

class Signupcontroller extends GetxController {
  final fullNameController = TextEditingController();
  final fullNameFocusNode = FocusNode();
  final emailAddressController = TextEditingController();
  final emailAddressFocusNode = FocusNode();
  final PasswordTextController = TextEditingController();
  final PasswordFocusNode = FocusNode();
  final ConfirmPasswordTextController = TextEditingController();
  final ConfirmPasswordFocusNode = FocusNode();
  final mobileNumberTextController = TextEditingController();
  final mobileNumberFocusNode = FocusNode();
  RxBool isloading = false.obs;
  RxBool ShowPassword = false.obs;
  RxBool ShowConfirmPassword = false.obs;
  var country = "".obs;
  var language = "".obs;
  UserResponseModel? userResponseModel;
  final signupFormKey = GlobalKey<FormState>();
  late Rx<Country> selectedCountry;
  var fcmtoken = ''.obs;
  @override
  void onInit() async {
    _loadCountry();
    if (Get.arguments != null) {
      country.value = Get.arguments['country'];
      language.value = Get.arguments['language'];
      print(">>>>>>>>>>>${country.value}");
      print(">>>>>>>>>>>${language.value}");
      String? token = await FirebaseMessaging.instance.getToken();
      fcmtoken.value = token!;
      print(">FCM:>>>>>>>:::::>>>>>>>>>>${token}????????");
    }
    super.onInit();
  }

  handleSubmit(var data) {
    isloading.value = true;
    isloading.refresh();
    try {
      Get.closeAllSnackbars();
      repository.signupApiCall(dataBody: data).then((value) async {
        if (value != null) {
          userResponseModel = value;
          Get.toNamed(AppRoutes.OtpScreen, arguments: {
            "email": emailAddressController?.text,
            "language": language.value
          });
          isloading.value = false;

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

  @override
  void onClose() {
    fullNameController.dispose();
    fullNameFocusNode.dispose();
    emailAddressController.dispose();
    emailAddressFocusNode.dispose();
    PasswordFocusNode.dispose();
    ConfirmPasswordFocusNode.dispose();
    mobileNumberFocusNode.dispose();
    PasswordTextController.dispose();
    ConfirmPasswordTextController.dispose();
    mobileNumberTextController.dispose();
    super.onClose();
  }

  void _loadCountry() {
    final country = countries.firstWhere((item) => item.code == 'GB',
        orElse: () => countries.first);
    selectedCountry = country.obs;
  }
}
