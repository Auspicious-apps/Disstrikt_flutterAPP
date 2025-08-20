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
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../core/widget/intl_phone_field/countries.dart';
import '../../../data/local/preferences/preference.dart';
import '../../Portfolio/models/ResponseModel/portfolio_responseModel.dart';
import '../../home/models/requestModels/buyplanRequestModel.dart';
import '../../settingModule/Models/ReponseModel/mediaUpload.dart';

class PortfolioForViewController extends GetxController {
  UserResponseModel? userResponseModel;
  RxBool isLoading = false.obs;
  RxBool loading = false.obs;
  RxBool isImages = true.obs;
  Rx<File?> pickedImage = Rx<File?>(null);
  final List<String> uploadedImageKeys = [];
  RxBool isUploading = false.obs;
  MediaUploadResponseModel? mediaUploadResponseModel;
  Rx<PortfolioResponseModel> portfolioResponseModel =
      PortfolioResponseModel().obs;
  final genders = ["catwalkVideo".tr, "introVideo".tr, "strOthers".tr];
  var isSecondDropdownOpen = false.obs;
  // Reactive variable to store the selected gender, initialized as null
  final RxString selectGender = RxString("");

  // Rx<PortfolioImageResponseModel> portfolioImageResponseModel =
  //     PortfolioImageResponseModel().obs;
  final RxList<String> imageList = <String>[].obs;
  final RxList<String> videoList = <String>[].obs;
  final RxList<String> tumbhnailList = <String>[].obs;
  final List<String> uploadedTumbhnailList = [];
  var selectedPhotoIndex = 0.obs;

  @override
  void onInit() {
    if (Get.arguments != null) {
      var Id = Get.arguments["id"];
      GetPortfolio(Id);
    }

    super.onInit();
  }

  void GetPortfolio(String? id) {
    loading.value = true;
    loading.refresh();
    try {
      Get.closeAllSnackbars();
      repository.getPublicPortfolioApiCall(id: id).then((value) async {
        portfolioResponseModel.value = value;
        portfolioResponseModel.refresh();
        loading.value = false;
        loading.refresh();
      }).onError((error, stackTrace) {
        print("Error fetching plans: $error");
        loading.value = false;
        loading.refresh();
        Get.closeAllSnackbars();
        Get.snackbar(
          'Error',
          '$error',
          backgroundColor: Colors.white.withOpacity(0.5),
        );
      });
    } catch (er) {
      print("Exception in GetModelPlans: $er");
      loading.value = false;
      loading.refresh();
      Get.snackbar(
        'Error',
        '$er',
        backgroundColor: Colors.white.withOpacity(0.5),
      );
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
