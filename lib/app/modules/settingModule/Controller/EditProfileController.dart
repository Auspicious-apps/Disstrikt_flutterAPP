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
import 'package:image_picker/image_picker.dart';

import '../../../core/widget/intl_phone_field/countries.dart';
import '../../../data/local/preferences/preference.dart';
import '../../auth/models/requestmodels/RequestModel.dart';
import '../Models/ReponseModel/StaticModel.dart';
import '../Models/ReponseModel/mediaUpload.dart';

class Editprofilecontroller extends GetxController {
  final LocalStorage _localStorage = LocalStorage();
  final ImagePicker _picker = ImagePicker();
  Rx<File?> pickedImage = Rx<File?>(null);
  RxBool isLoading = false.obs;
  RxString profilePicUrl = ''.obs;
  final fullNameController = TextEditingController();
  final fullNameFocusNode = FocusNode();
  final emailAddressController = TextEditingController();
  final emailAddressFocusNode = FocusNode();
  final mobileNumberTextController = TextEditingController();
  final mobileNumberFocusNode = FocusNode();
  late Rx<Country> selectedCountry;
  final List<String> genders = ["strMale".tr, "strFemale".tr];
  var selectGender = "".obs;
  RxBool isloading = false.obs;
  var isSecondDropdownOpen = false.obs;
  var isDropdownOpen = false.obs;
  final hipsController = TextEditingController();
  final hipsFocusNode = FocusNode();
  final hieghtController = TextEditingController();
  final hieghtFocusNode = FocusNode();
  final weightController = TextEditingController();
  final weightFocusNode = FocusNode();
  final waistController = TextEditingController();
  final waistFocusNode = FocusNode();
  RxBool isUploading = false.obs;
  final LocalStorage localStorage = LocalStorage();
  final bustController = TextEditingController();
  UserResponseModel? userResponseModel;
  final bustFocusNode = FocusNode();
  MediaUploadResponseModel? mediaUploadResponseModel;
  final birthDate = ''.obs;
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
  @override
  void onInit() {
    _loadCountry();
    GetProfileDetail();
    super.onInit();
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxHeight: 800,
        maxWidth: 800,
        imageQuality: 85,
      );
      if (image != null) {
        pickedImage.value = File(image.path);
        debugPrint(
            'Image picked: ${image.path}, size: ${await image.length()} bytes');
        // Optionally upload immediately after picking
      } else {
        Get.snackbar('Info', 'No image selected');
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      Get.snackbar('Error', 'Failed to pick image: $e');
    }
  }

  void _loadCountry() {
    final country = countries.firstWhere((item) => item.code == 'GB',
        orElse: () => countries.first);
    selectedCountry = country.obs;
  }

  GetProfileDetail() {
    try {
      isloading.value = true;
      Get.closeAllSnackbars();
      repository.getEditProfileApiCall().then((value) async {
        if (value != null) {
          userResponseModel = value;
          isloading.value = false;
          hieghtController.text =
              userResponseModel?.data?.measurements?.heightCm?.toString() ?? "";
          weightController.text =
              userResponseModel?.data?.measurements?.weightKg?.toString() ?? "";
          fullNameController.text = userResponseModel?.data?.fullName ?? '';
          emailAddressController.text = userResponseModel?.data?.email ?? '';
          mobileNumberTextController.text =
              userResponseModel?.data?.phone ?? '';
          profilePicUrl.value = userResponseModel?.data?.image ?? '';
          hipsController.text =
              userResponseModel?.data?.measurements?.hipsCm?.toString() ?? '';
          waistController.text =
              userResponseModel?.data?.measurements?.waistCm?.toString() ?? '';
          bustController.text =
              userResponseModel?.data?.measurements?.bustCm?.toString() ?? '';
          selectShoesSize.value =
              userResponseModel?.data?.measurements?.shoeSizeUK?.toString() ??
                  '';
          birthDate.value =
              userResponseModel?.data?.dob?.toString().split('T')[0] ?? "";
          selectGender.value = userResponseModel?.data?.gender == "MALE"
              ? "strMale".tr
              : userResponseModel?.data?.gender == "FEMALE"
                  ? "strFemale".tr
                  : "strOthers".tr;
          print(selectGender.value);
          profilePicUrl.value = userResponseModel?.data?.image ?? "";
        } else {
          isloading.value = false;
          Get.closeAllSnackbars();
        }
      }).onError((er, stackTrace) {
        print("$er");
        isloading.value = false;
        Get.closeAllSnackbars();
        Get.snackbar('Error', '$er');
      });
    } catch (er) {
      isloading.value = false;
      print("$er");
    }
  }

  updateProfileDetail(data) {
    try {
      isloading.value = true;
      Get.closeAllSnackbars();
      repository.updateProfileApiCall(dataBody: data).then((value) async {
        if (value != null) {
          userResponseModel = value;
          isloading.value = false;
          Get.back();
          Get.closeAllSnackbars();
          Get.snackbar('Success', '${userResponseModel?.message}');
        } else {
          isloading.value = false;
          Get.closeAllSnackbars();
          Get.snackbar('Success', '${userResponseModel?.message}');
        }
      }).onError((er, stackTrace) {
        print("$er");
        isloading.value = false;
        Get.closeAllSnackbars();
        Get.snackbar('Error', '$er');
      });
    } catch (er) {
      isloading.value = false;
      print("$er");
    }
  }

  Future<MediaUploadResponseModel?> callUploadMedia(File file) async {
    try {
      isLoading.value = true;
      isUploading.value = true;
      final response = await repository.mediaUploadApiCall(file);
      mediaUploadResponseModel = response;

      profilePicUrl.value = response.data?.key ?? ''; // Update profilePicUrl
      Map<String, dynamic> requestModel =
          AuthRequestModel.EditProfileRequestModel(
              image: response.data?.key,
              fullName: fullNameController.text,
              dob: birthDate.value,
              gender: selectGender.value?.toUpperCase(),
              hipsCm: hipsController.text.isNotEmpty
                  ? double.parse(hipsController.text)
                  : null,
              waistCm: waistController.text.isNotEmpty
                  ? double.parse(waistController.text)
                  : null,
              bustCm: bustController.text.isNotEmpty
                  ? double.parse(bustController.text)
                  : null,
              weightKg: weightController.text.isNotEmpty
                  ? double.parse(weightController.text)
                  : null,
              heightCm: hieghtController.text.isNotEmpty
                  ? double.parse(hieghtController.text)
                  : null,
              shoeSizeUK: selectShoesSize.value.isNotEmpty
                  ? double.parse(selectShoesSize.value)
                  : null);
      updateProfileDetail(requestModel);
      isLoading.value = false;
      isUploading.value = false;

      return response;
    } catch (e, stackTrace) {
      isLoading.value = false;
      isUploading.value = false;
      debugPrint('Error during media upload: $e\nStack trace: $stackTrace');
      Get.snackbar(
        'Error',
        'Failed to upload media. Please try again.',
        snackPosition: SnackPosition.TOP,
      );
      return null;
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
