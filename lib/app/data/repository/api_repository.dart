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
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import '../../export.dart';

import '../../modules/auth/models/responseModels/userResponseModel.dart';
import '../../modules/home/models/responseModels /plansResponseModel.dart';
import '../../modules/home/models/responseModels /setupIntentResponseModel.dart';
import 'dio_client.dart';
import 'endpoint.dart';
import 'network_exceptions.dart' show NetworkExceptions;

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

  Future getProfileApiCall() async {
    try {
      final response =
          await dioClient!.get(getProfileEndPoint, skipAuth: false);
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

  Future gethomeApiCall({bool showLoader = true}) async {
    try {
      final response = await dioClient!.get(homeEndPoint, skipAuth: false);
      return UserResponseModel.fromJson(response);
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

  Future logoutApi({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(logOutEndPoint, skipAuth: false);
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
