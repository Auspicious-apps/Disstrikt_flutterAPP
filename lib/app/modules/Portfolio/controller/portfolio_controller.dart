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
import '../../home/models/requestModels/buyplanRequestModel.dart';
import '../../settingModule/Models/ReponseModel/mediaUpload.dart';
import '../models/ResponseModel/portfolio_responseModel.dart';
import '../models/ResponseModel/portfolioimages.dart';

class PortfolioController extends GetxController {
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
// Add image
  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null && imageList.length < 4) {
      imageList.add(picked.path);
    }
  }

  void pickThumbImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      pickedImage.value = File(picked.path);
      debugPrint(
          'Image picked: ${picked.path}, size: ${await picked.length()} bytes');
      // Optionally upload immediately after picking
    } else {
      print('No image selected');
    }
  }

  Future<String?> generateThumbnail(String videoPath) async {
    try {
      final thumbnailPath = await VideoThumbnail.thumbnailFile(
        video: videoPath,
        thumbnailPath: (await Directory.systemTemp.createTemp()).path,
        imageFormat: ImageFormat.JPEG,
        maxHeight: 200,
        quality: 100,
      );
      return thumbnailPath;
    } catch (e) {
      print('Error generating thumbnail: $e');
      return null;
    }
  }

  void pickVideo() async {
    final ImagePicker picker = ImagePicker();
    final XFile? picked = await picker.pickVideo(source: ImageSource.gallery);

    if (picked != null && videoList.length < 1) {
      // Fixed: Check videoList.length < 1 assuming single video per upload
      // Validate file extension
      final String extension = picked.path.split('.').last.toLowerCase();
      if (['mp4', 'mov', 'avi'].contains(extension)) {
        videoList.add(picked.path);
      } else {
        Get.snackbar('Invalid Format',
            'Please select a video in MP4, MOV, or AVI format');
      }
    } else if (videoList.length >= 1) {
      Get.snackbar('Limit Reached', 'Only one video can be uploaded at a time');
    }
  }

  Future<void> uploadAllImages() async {
    uploadedImageKeys.clear();
    isLoading.value = true;
    for (final path in imageList) {
      final file = File(path);
      final key = await callUploadMedia(file);
      if (key != null) {
        uploadedImageKeys.add(key);
      } else {
        Get.snackbar('Upload Failed', 'One of the images failed to upload');
        isLoading.value = false;
        return;
      }
    }
    Map<String, dynamic> requestModel =
        BuyPlanRequestModel.addImageRequestModel(url: uploadedImageKeys);
    await addImagePortfolio(requestModel);
    isLoading.value = false;
    imageList.clear();
    GetPortfolio(); // Added: Refresh full portfolio data after upload
  }

  Future<void> uploadAllVideos() async {
    uploadedImageKeys.clear();
    isLoading.value = true;

    // Fixed: Assuming single video upload; loop for one item only
    if (videoList.isNotEmpty) {
      final path = videoList[0];
      final file = File(path);
      final key = await callUploadMedia(file);
      if (key == null) {
        Get.snackbar('Upload Failed', 'Video upload failed');
        isLoading.value = false;
        return;
      }
      uploadedImageKeys.add(key);
      await generateAllThumbnails();
      Map<String, dynamic> requestModel =
          BuyPlanRequestModel.addVideoRequestModel(
              url: uploadedImageKeys[0] ?? "",
              thumbnail: uploadedTumbhnailList.isNotEmpty
                  ? uploadedTumbhnailList[0]
                  : "",
              title: selectGender.value == "catwalkVideo".tr
                  ? "catwalkVideo"
                  : selectGender.value == "introVideo".tr
                      ? "introVideo"
                      : "other");
      await addVideoPortfolio(requestModel);
    }
    isLoading.value = false;
    videoList.clear();
    selectGender.value = "";
    GetPortfolio(); // Added: Refresh full portfolio data after upload
  }

  Future<String?> callThumbnailMedia(File file) async {
    try {
      isLoading.value = true;
      isUploading.value = true;

      final response = await repository.mediaUploadApiCall(file);
      mediaUploadResponseModel = response;

      final key = response.data?.key;

      isLoading.value = false;
      isUploading.value = false;
      videoList.value.clear();

      if (key == null || key.isEmpty) {
        Get.snackbar('Upload Failed', 'Thumbnail upload failed');
        return null;
      }

      return key;
    } catch (e, stackTrace) {
      isLoading.value = false;
      isUploading.value = false;
      debugPrint('Error during thumbnail upload: $e\n$stackTrace');
      Get.snackbar('Upload Error', 'Failed to upload thumbnail');
      return null;
    }
  }

// Separate function to generate thumbnails
  Future<void> generateAllThumbnails() async {
    tumbhnailList.clear();
    uploadedTumbhnailList.clear();
    if (videoList.isNotEmpty) {
      final thumbnailPath =
          await generateThumbnail(videoList[0]); // Fixed: For single video

      if (thumbnailPath == null) {
        Get.snackbar('Thumbnail Generation Failed',
            'Failed to generate thumbnail for video');
        return;
      }

      tumbhnailList.add(thumbnailPath);
      for (final path in tumbhnailList) {
        final file = pickedImage.value != null
            ? File(pickedImage.value!.path)
            : File(path);
        final key = await callThumbnailMedia(file);
        if (key == null) {
          Get.snackbar('Upload Failed', 'Thumbnail upload failed');
          isLoading.value = false;
          return;
        }
        pickedImage.value = null;
        pickedImage.refresh();
        uploadedTumbhnailList.add(key);
      }
      print(uploadedTumbhnailList);
    }
  }

  Future<String?> callUploadMedia(File file) async {
    try {
      isLoading.value = true;
      isUploading.value = true;

      final response = await repository.mediaUploadApiCall(file);
      mediaUploadResponseModel = response;

      final key = response.data?.key ?? "";

      isUploading.value = false;

      return key.isNotEmpty ? key : null;
    } catch (e, stackTrace) {
      isLoading.value = false;
      isUploading.value = false;
      debugPrint('Error during media upload: $e\n$stackTrace');

      return null;
    }
  }

  Future<void> addImagePortfolio(var data) async {
    try {
      final response =
          await repository.addImagePortfolioApiCall(dataBody: data);
      if (response.data != null) {
        print(
            "before${portfolioResponseModel.value.data!.portfolioImages?.length}");
        // Directly update portfolioResponseModel with the list of image URLs
        if (portfolioResponseModel.value.data == null) {
          portfolioResponseModel.value.data =
              PortfolioData(portfolioImages: []);
        }
        portfolioResponseModel.value.data!.portfolioImages =
            List<String>.from(response.data);

        portfolioResponseModel.refresh();
        print(
            "after${portfolioResponseModel.value.data!.portfolioImages?.length}");
        Get.back(); // Moved Get.back() here if needed, but keep as is
      }
    } catch (e, stackTrace) {
      isLoading.value = false;
      isUploading.value = false;
      debugPrint('Error during media upload: $e\n$stackTrace');
    }
  }

  Future<void> addVideoPortfolio(var data) async {
    try {
      final response =
          await repository.addVideoPortfolioApiCall(dataBody: data);
      if (response.data != null) {
        print("before${portfolioResponseModel.value.data!.videos?.length}");
        // Directly update portfolioResponseModel with the list of image URLs
        if (portfolioResponseModel.value.data == null) {
          portfolioResponseModel.value.data = PortfolioData(videos: []);
        }
        portfolioResponseModel.value.data!.videos =
            List<Videos>.from(response.data);
        pickedImage.value = null;
        portfolioResponseModel.refresh();
        Get.back();
        print("after${portfolioResponseModel.value.data!.videos?.length}");
      }
    } catch (e, stackTrace) {
      isLoading.value = false;
      isUploading.value = false;
      debugPrint('Error during media upload: $e\n$stackTrace');
    }
  }

  Future<void> deleteVideoPortfolio(var data) async {
    try {
      isLoading.value = true;

      final response =
          await repository.deleteVideoPortfolioApiCall(dataBody: data);
      if (response.data != null) {
        isLoading.value = false;

        print("before${portfolioResponseModel.value.data!.videos?.length}");
        // Directly update portfolioResponseModel with the list of image URLs
        if (portfolioResponseModel.value.data == null) {
          portfolioResponseModel.value.data = PortfolioData(videos: []);
        }
        portfolioResponseModel.value.data!.videos =
            List<Videos>.from(response.data);

        portfolioResponseModel.refresh();
        Get.back();
        GetPortfolio(); // Added: Refresh full portfolio after delete
        print("after${portfolioResponseModel.value.data!.videos?.length}");
      }
    } catch (e, stackTrace) {
      isLoading.value = false;
      isUploading.value = false;
      debugPrint('Error during media upload: $e\n$stackTrace');
    }
  }

  Future<void> deleteImagePortfolio(var data) async {
    try {
      isLoading.value = true;

      final response =
          await repository.deleteImagesPortfolioApiCall(dataBody: data);
      if (response.data != null) {
        print(
            "before${portfolioResponseModel.value.data!.portfolioImages?.length}");
        // Directly update portfolioResponseModel with the list of image URLs
        if (portfolioResponseModel.value.data == null) {
          portfolioResponseModel.value.data =
              PortfolioData(portfolioImages: []);
        }
        portfolioResponseModel.value.data!.portfolioImages =
            List<String>.from(response.data);

        portfolioResponseModel.refresh();
        Get.back();
        GetPortfolio(); // Added: Refresh full portfolio after delete
        isLoading.value = false;
        print(
            "after${portfolioResponseModel.value.data!.portfolioImages?.length}");
      }
    } catch (e, stackTrace) {
      isLoading.value = false;
      isUploading.value = false;
      debugPrint('Error during media upload: $e\n$stackTrace');
    }
  }

  @override
  void onInit() {
    GetPortfolio();
    super.onInit();
  }

  GetPortfolio() {
    loading.value = true;
    loading.refresh();
    try {
      Get.closeAllSnackbars();
      repository.getPortfolioApiCall().then((value) async {
        portfolioResponseModel.value = value;

        portfolioResponseModel.refresh();
        update();
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
