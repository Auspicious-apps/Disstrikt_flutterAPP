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
import '../../auth/models/responseModels/userResponseModel.dart';

class UserInfoController extends GetxController {
  final hieghtController = TextEditingController();
  final hieghtFocusNode = FocusNode();
  final weightController = TextEditingController();
  final weightFocusNode = FocusNode();
  final hipsController = TextEditingController();
  final hipsFocusNode = FocusNode();
  final waistController = TextEditingController();
  final waistFocusNode = FocusNode();
  final bustController = TextEditingController();
  final bustFocusNode = FocusNode();

  RxBool isloading = false.obs;
  RxBool ShowPassword = false.obs;
  RxBool ShowConfirmPassword = false.obs;
  var country = "".obs;
  var language = "".obs;
  UserResponseModel? userResponseModel;
  final List<String> genders = ["Male", "Female", "Others"];
  final List<String> ShoesSize = [
    '2',
    '2.5',
    '3',
    '3.5',
    '4',
    '4.5',
    '5',
    '5.5',
    '6',
    '6.5',
    '7',
    '7.5',
    '8',
    '8.5',
    '9',
    '9.5',
    '10',
    '10.5',
    '11',
    '11.5',
    '12',
    '12.5',
    '13',
  ];
  var selectShoesSize = "".obs;
  var selectGender = "".obs;
  final signupFormKey = GlobalKey<FormState>();
  late Rx<Country> selectedCountry;
  var fcmtoken = ''.obs;
  final birthDate = ''.obs;
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
      repository.MoreInfoApiCall(dataBody: data).then((value) async {
        if (value != null) {
          isloading.value = false;
          userResponseModel = value;
          isloading.refresh();
          Get.toNamed(AppRoutes.ChoosePlan);
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
    hieghtFocusNode.dispose();
    hieghtController.dispose();
    weightFocusNode.dispose();
    weightController.dispose();
    hipsFocusNode.dispose();
    hipsController.dispose();
    waistFocusNode.dispose();
    waistController.dispose();
    bustFocusNode.dispose();
    bustController.dispose();

    super.onClose();
  }

  void _loadCountry() {
    final country = countries.firstWhere((item) => item.code == 'GB',
        orElse: () => countries.first);
    selectedCountry = country.obs;
  }
}
