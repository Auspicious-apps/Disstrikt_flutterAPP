/*
 * @copyright : Henceforth Pvt. Ltd. <info@henceforthsolutions.com>
 * @author     : Gaurav Negi
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of Henceforth Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 *
 */

import 'package:dio/dio.dart';
import 'package:disstrikt/app/modules/taskModule/models/ResponseModels/Message.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import '../../export.dart';

import '../../modules/Portfolio/models/ResponseModel/portfolio_responseModel.dart';
import '../../modules/Portfolio/models/ResponseModel/portfolio_video.dart';
import '../../modules/Portfolio/models/ResponseModel/portfolioimages.dart';
import '../../modules/auth/models/responseModels/userResponseModel.dart';
import '../../modules/home/models/responseModels /HomePageResponseModel.dart';
import '../../modules/home/models/responseModels /plansResponseModel.dart';
import '../../modules/home/models/responseModels /setupIntentResponseModel.dart';
import '../../modules/jobs/Models/GetAllJobsResponseModel.dart';
import '../../modules/jobs/Models/GetJobDetailResponseModel.dart';
import '../../modules/jobs/Models/SearchResponseModel.dart';
import '../../modules/settingModule/Models/ReponseModel/StaticModel.dart';
import '../../modules/settingModule/Models/ReponseModel/active_plan_responseModel.dart';
import '../../modules/settingModule/Models/ReponseModel/mediaUpload.dart';
import '../../modules/taskModule/models/ResponseModels/TaskDetailResponseModel.dart';
import 'dio_client.dart';
import 'endpoint.dart';
import 'network_exceptions.dart' show NetworkExceptions;

enum UploadFileType { image, video, unknown }

class Repository {
  static late DioClient? dioClient;
  var deviceName, deviceType, deviceID, deviceVersion;

  Repository() {
    var dio = Dio();
    dioClient = DioClient(baseUrl, dio);
    getDeviceData();
  }

  getDeviceData() async {
    DeviceInfoPlugin info = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await info.androidInfo;
      deviceName = "ANDROID"; /* androidDeviceInfo.model;*/
      deviceID = androidDeviceInfo.id;
      deviceVersion = androidDeviceInfo.version.release;
      deviceType = "1";
    } else if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await info.iosInfo;
      deviceName = iosDeviceInfo.systemName;
      deviceID = iosDeviceInfo.identifierForVendor;
      deviceVersion = iosDeviceInfo.systemVersion;
      deviceType = "2";
    }
  }

  /*===================================================================== Register API Call  ==========================================================*/
  Future signupApiCall(
      {required Map<String, dynamic>? dataBody, bool showLoader = true}) async {
    try {
      final response = await dioClient!.post(signUpEndPoint,
          data: jsonEncode(dataBody), isLoading: showLoader);
      return UserResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future forgetEmailApiCall(
      {required Map<String, dynamic>? dataBody, bool showLoader = true}) async {
    try {
      final response = await dioClient!.post(ForgetemailEndPoint,
          data: jsonEncode(dataBody), isLoading: showLoader);
      return UserResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future loginApiCall(
      {required Map<String, dynamic>? dataBody, bool showLoader = true}) async {
    try {
      final response = await dioClient!.post(loginApiEndPoint,
          data: jsonEncode(dataBody), isLoading: showLoader);
      return UserResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future socialLoginApi({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!
          .post(socialLoginEndPoint, data: json.encode(dataBody!));
      return UserResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future getProfileApiCall() async {
    try {
      final response =
          await dioClient!.get(getProfileEndPoint, skipAuth: false);
      return UserResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future searchUserApiCall({query}) async {
    try {
      final response = await dioClient!
          .get(searchUserEndPoint, skipAuth: false, queryParameters: query);
      return SearchResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future getTaskDetailApiCall({String? ID}) async {
    try {
      final response =
          await dioClient!.get("${taskDetailEndPoint}/${ID}", skipAuth: false);
      return TaskDetailModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future TaskSubmitApiCall({String? ID, Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post("${taskSubmitEndPoint}/${ID}",
          skipAuth: false, data: json.encode(dataBody!));
      return Message.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future getEditProfileApiCall() async {
    try {
      final response =
          await dioClient!.get(getEditProfileEndPoint, skipAuth: false);
      return UserResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future getAllJObsApiCall({query}) async {
    try {
      final response = await dioClient!
          .get(getAllJobsEndPoint, skipAuth: false, queryParameters: query);
      return GetAllJobsResponse.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future getJobsDetailApiCall({String? ID}) async {
    try {
      final response =
          await dioClient!.get("${getAllJobsEndPoint}/${ID}", skipAuth: false);
      return GetJobsDetailResponse.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future jobApplyApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post("${getAllJobsEndPoint}",
          skipAuth: false, data: json.encode(dataBody!));
      return GetJobsDetailResponse.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  UploadFileType getFileType(String filePath) {
    final imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.bmp'];
    final videoExtensions = ['.mp4', '.avi', '.mkv', '.mov', '.wmv'];

    final ext = filePath.toLowerCase().split('.').last;

    if (imageExtensions.contains('.$ext')) {
      return UploadFileType.image;
    } else if (videoExtensions.contains('.$ext')) {
      return UploadFileType.video;
    } else {
      return UploadFileType.unknown;
    }
  }

  Future<MediaUploadResponseModel> mediaUploadApiCall(File file) async {
    try {
      final type = getFileType(
          file.path); // e.g., returns MediaTypeEnum.image or similar
      final fileExtension = file.path.split('.').last.toLowerCase();

      final multipart = await MultipartFile.fromFile(
        file.path,
        filename: file.uri.pathSegments.last,
        contentType: MediaType(type.name, fileExtension),
        // Use Dio's MediaType
      );

      final formData = FormData.fromMap({"file": multipart});

      final response = await dioClient!
          .post(mediafileUploadEndPoint, data: formData, skipAuth: false);

      return MediaUploadResponseModel.fromJson(response);
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }

  Future updateProfileApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.patch(updateProfileEndPoint,
          data: jsonEncode(dataBody), skipAuth: false);
      return UserResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future getPlansApiCall({bool showLoader = true}) async {
    try {
      final response = await dioClient!.get(getPlansEndPoint, skipAuth: false);
      return PlansResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future gethomeApiCall({bool showLoader = true, query}) async {
    try {
      final response = await dioClient!
          .get(homeEndPoint, skipAuth: false, queryParameters: query);
      return HomeResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future getSetupIntentApiCall({bool showLoader = true}) async {
    try {
      final response =
          await dioClient!.get(getSetupIntentEndPoint, skipAuth: false);
      return SetupIntentResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future getActivePlanApiCall({bool showLoader = true}) async {
    try {
      final response =
          await dioClient!.get(getActivePlanEndPoint, skipAuth: false);
      return ActivePlanResponsemodel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future getPortfolioApiCall({bool showLoader = true}) async {
    try {
      final response =
          await dioClient!.get(getPortfolioEndPoint, skipAuth: false);
      return PortfolioResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future getPublicPortfolioApiCall({String? id}) async {
    try {
      final response = await dioClient!
          .get("${getPublicPortfolioEndPoint}/${id}", skipAuth: false);
      return PortfolioResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future postPortfolioApiCall(
      {required Map<String, dynamic>? dataBody, bool showLoader = true}) async {
    try {
      final response = await dioClient!.patch(postPortfolioEndPoint,
          data: jsonEncode(dataBody), skipAuth: false);
      return PortfolioResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future addImagePortfolioApiCall(
      {required Map<String, dynamic>? dataBody, bool showLoader = true}) async {
    try {
      final response = await dioClient!.post(uploadPortfolioImageEndPoint,
          data: jsonEncode(dataBody), skipAuth: false);
      return PortfolioImageResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future addVideoPortfolioApiCall(
      {required Map<String, dynamic>? dataBody, bool showLoader = true}) async {
    try {
      final response = await dioClient!.post(uploadPortfolioVideoEndPoint,
          data: jsonEncode(dataBody), skipAuth: false);
      return PortfolioVideoResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future deleteVideoPortfolioApiCall(
      {required Map<String, dynamic>? dataBody, bool showLoader = true}) async {
    try {
      final response = await DioClient.delete(uploadPortfolioVideoEndPoint,
          data: jsonEncode(dataBody), skipAuth: false);
      return PortfolioVideoResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future deleteImagesPortfolioApiCall({
    required Map<String, dynamic>? dataBody,
    bool showLoader = true,
  }) async {
    try {
      final response = await DioClient.delete(
        uploadPortfolioImageEndPoint,
        data: jsonEncode(dataBody),
        skipAuth: false,
      );
      return PortfolioImageResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future buyPlanApiCall(
      {required Map<String, dynamic>? dataBody, bool showLoader = true}) async {
    try {
      final response = await dioClient!
          .post(BuyPlanEndPoint, data: jsonEncode(dataBody), skipAuth: false);
      return UserResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future MoreInfoApiCall({
    required Map<String, dynamic>? dataBody,
    bool showLoader = true,
  }) async {
    try {
      final response = await dioClient!.post(moreInfoEndPoint,
          data: jsonEncode(dataBody), isLoading: showLoader, skipAuth: false);
      return UserResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future ResendApiCall(
      {required Map<String, dynamic>? dataBody, bool showLoader = true}) async {
    try {
      final response = await dioClient!.post(otpResendEndPoint,
          data: jsonEncode(dataBody), isLoading: showLoader);
      return UserResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future VerifyOtpApiCall(
      {required Map<String, dynamic>? dataBody, bool showLoader = true}) async {
    try {
      final response = await dioClient!.post(otpVerifyEndPoint,
          data: jsonEncode(dataBody), isLoading: showLoader);
      return UserResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future ForgetVerifyOtpApiCall(
      {required Map<String, dynamic>? dataBody, bool showLoader = true}) async {
    try {
      final response = await dioClient!.post(ForgetOtpVerifyEndPoint,
          data: jsonEncode(dataBody), isLoading: showLoader);
      return UserResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future ResetPasswordOtpApiCall(
      {required Map<String, dynamic>? dataBody, bool showLoader = true}) async {
    try {
      final response = await dioClient!.post(resetPasswordEndPoint,
          data: jsonEncode(dataBody), isLoading: showLoader, skipAuth: false);
      return UserResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future ChangePasswordApiCall(
      {required Map<String, dynamic>? dataBody, bool showLoader = true}) async {
    try {
      final response = await dioClient!.patch(ChangePasswordEndPoint,
          data: jsonEncode(dataBody), isLoading: showLoader, skipAuth: false);
      return UserResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future ChangeLanguageApiCall(
      {required Map<String, dynamic>? dataBody, bool showLoader = true}) async {
    try {
      final response = await dioClient!.patch(ChangeLanguageEndPoint,
          data: jsonEncode(dataBody), isLoading: showLoader, skipAuth: false);
      return UserResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future ChangeSubscriptionApiCall(
      {required Map<String, dynamic>? dataBody, bool showLoader = true}) async {
    try {
      final response = await dioClient!.post(ChangeSubscriptionEndPoint,
          data: jsonEncode(dataBody), isLoading: showLoader, skipAuth: false);
      return UserResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future ChangeCountryApiCall(
      {required Map<String, dynamic>? dataBody, bool showLoader = true}) async {
    try {
      final response = await dioClient!.patch(ChangeCountryEndPoint,
          data: jsonEncode(dataBody), isLoading: showLoader, skipAuth: false);
      return UserResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future GetProfile({bool showLoader = true}) async {
    try {
      final response = await dioClient!.get(getProfile, skipAuth: false);
      return UserResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future GetStaticAPi({bool showLoader = true, query}) async {
    try {
      final response = await dioClient!
          .get(getStaticDataEndPoint, skipAuth: false, queryParameters: query);
      return StatiResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future logoutApi({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(logOutEndPoint, skipAuth: false);
      return UserResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future deleteAccountApi({Map<String, dynamic>? dataBody}) async {
    try {
      final response =
          await dioClient!.post(deleteUserEndPoint, skipAuth: false);
      return UserResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  //
  //
  //
  //
  // Future LogOutApi() async {
  //   try {
  //     final response = await dioClient!.post(logoutApiEndPoint, skipAuth: false);
  //     return UserResponseModel.fromJson(response);
  //   } catch (e) {
  //     return Future.error(NetworkExceptions.getDioException(e));
  //   }
  // }
}
