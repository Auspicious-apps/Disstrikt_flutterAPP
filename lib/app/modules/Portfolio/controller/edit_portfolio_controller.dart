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
import 'package:disstrikt/app/modules/Portfolio/controller/portfolio_controller.dart'
    show PortfolioController;
import 'package:disstrikt/app/modules/auth/models/responseModels/userResponseModel.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/widget/intl_phone_field/countries.dart';
import '../../../data/local/preferences/preference.dart';
import '../../auth/models/requestmodels/RequestModel.dart';
import '../../home/models/requestModels/buyplanRequestModel.dart';
import '../../settingModule/Models/ReponseModel/mediaUpload.dart';
import '../models/ResponseModel/portfolio_responseModel.dart';

class EditPortfolioController extends GetxController {
  UserResponseModel? userResponseModel;
  RxBool isLoading = false.obs;
  RxBool isUploading = false.obs;
  MediaUploadResponseModel? mediaUploadResponseModel;
  final ImagePicker _picker = ImagePicker();
  Rx<File?> pickedImage = Rx<File?>(null);
  final aboutMeController = TextEditingController();
  final aboutMeFocusNode = FocusNode();
  final instagramLinkController = TextEditingController();
  final inastagramLinkFocusNode = FocusNode();
  final YoutubeLinkController = TextEditingController();
  final YouTubeLinkFocusNode = FocusNode();
  final setCardController = TextEditingController();
  final setCardFocusNode = FocusNode();
  Rx<PortfolioResponseModel> portfolioResponseModel =
      PortfolioResponseModel().obs;
  @override
  void onInit() {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    GetPortfolio(); // Call after build phase
    // });
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
        print('No image selected');
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  Future<MediaUploadResponseModel?> callUploadMedia(File file) async {
    try {
      isLoading.value = true;
      isUploading.value = true;
      final response = await repository.mediaUploadApiCall(file);
      mediaUploadResponseModel = response;

      final setcard = response.data?.key ?? "";

      Map<String, dynamic> requestModel =
          BuyPlanRequestModel.postPortfolioRequestModel(
              setCards: [setcard],
              aboutMe: aboutMeController.text,
              links: [
                {"platform": "Instagram", "url": instagramLinkController.text},
                {"platform": "Youtube", "url": YoutubeLinkController.text},
              ]);

      postPortfolio(requestModel);
      // isLoading.value = false;
      // isUploading.value = false;

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

  void GetPortfolio() {
    isLoading.value = true;
    isLoading.refresh();
    try {
      Get.closeAllSnackbars();
      repository.getPortfolioApiCall().then((value) async {
        portfolioResponseModel.value = value;
        portfolioResponseModel.refresh();
        if (portfolioResponseModel.value.data!.setCards?.length != 0) {
          setCardController.text =
              portfolioResponseModel.value.data!.setCards![0];
        }

        aboutMeController.text = portfolioResponseModel.value.data!.aboutMe!;
        if (portfolioResponseModel.value.data!.links![0]?.platform !=
            "Youtube") {
          instagramLinkController.text =
              portfolioResponseModel.value.data!.links![0].url!;
        }
        if (portfolioResponseModel.value.data!.links![0]?.platform ==
                "Youtube" &&
            portfolioResponseModel.value.data!.links!.length == 1) {
          YoutubeLinkController.text =
              portfolioResponseModel.value.data!.links![0].url!;
        } else {
          YoutubeLinkController.text =
              portfolioResponseModel.value.data!.links![1].url!;
        }
        isLoading.value = false;
        isLoading.refresh();
        Get.put(PortfolioController()).GetPortfolio();
      }).onError((error, stackTrace) {
        print("Error fetching plans: $error");
        isLoading.value = false;
        isLoading.refresh();
        Get.closeAllSnackbars();
        // Get.snackbar(
        //   'Error',
        //   '$error',
        //   backgroundColor: Colors.white.withOpacity(0.5),
        // );
      });
    } catch (er) {
      print("Exception in GetModelPlans: $er");
      isLoading.value = false;
      isLoading.refresh();
      Get.snackbar(
        'Error',
        '$er',
        backgroundColor: Colors.white.withOpacity(0.5),
      );
    }
  }

  void postPortfolio(var data) {
    isLoading.value = true;
    isLoading.refresh();
    try {
      Get.closeAllSnackbars();
      repository.postPortfolioApiCall(dataBody: data).then((value) async {
        await Get.put(PortfolioController()).GetPortfolio();
        portfolioResponseModel.value = value;
        portfolioResponseModel.refresh();

        isLoading.value = false;
        isLoading.refresh();
        Get.back();
      }).onError((error, stackTrace) {
        print("Error fetching plans: $error");
        isLoading.value = false;
        isLoading.refresh();
        Get.closeAllSnackbars();
        Get.snackbar(
          'Error',
          '$error',
          backgroundColor: Colors.white.withOpacity(0.5),
        );
      });
    } catch (er) {
      print("Exception in GetModelPlans: $er");
      isLoading.value = false;
      isLoading.refresh();
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
