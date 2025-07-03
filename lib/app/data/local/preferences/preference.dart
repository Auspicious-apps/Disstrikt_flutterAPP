


/*
 * @copyright : Henceforth Pvt. Ltd. <info@henceforthsolutions.com>
 * @author     : Gaurav Negi
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of Henceforth Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 *
 */


import '../../../export.dart';

class LocalStorage {
  static const String isFirstLaunch = "isFirstLaunch";
  static const String authToken = "authToken";
  static const String roleId = "roleId";
  static const String changeLanguage = "changeLanguage";
  static const String loginDataModel = "loginDataModel";
  static const String rememberMe = "rememberMe";
  static const String isNotificationOn = "isNotificationOn";
  static const String name1 = "isNameOn";
  static const String email1 = "isEmailOn";

  saveFirstLaunch(bool? isFirstCheck) {
    localStorage.write(isFirstLaunch, isFirstCheck);
    localStorage.read(
      isFirstLaunch,
    );
  }

  bool? getFirstLaunch(){
    return localStorage.read(isFirstLaunch);
  }

  saveAuthToken(String? token) {
    localStorage.write(authToken, token);
  }

  getAuthToken() {
    return localStorage.read(authToken);
  }
  // saveName(String? name) {
  //   localStorage.write(name1, name);
  // }
  // getNane() {
  //   return localStorage.read(name1);
  // }
  //
  // saveEmail(String? email) {
  //   localStorage.write(email1, email);
  // }
  // getEmail() {
  //   return localStorage.read(email1);
  // }
  //
  // saveRole(int? role) {
  //   localStorage.write(roleId, role);
  // }
  //
  // getRole() {
  //   return localStorage.read(roleId);
  // }

  getStatusFirstLaunch() {
    return localStorage.read(isFirstLaunch)??false;
  }

  // saveRegisterData(LoginDataModel? model) async {
  //   localStorage.write(loginDataModel, jsonEncode(model));
  // }
  // Future<void> saveRegisterData(LoginDataModel? model) async {
  //   try {
  //     await localStorage.write(loginDataModel, jsonEncode(model));
  //     debugPrint("Saved");
  //   } catch (e, stack) {
  //     debugPrint("Error saving login data: $e  $stack");
  //   }
  // }

  // getSavedLoginData() async {
  //   Map<String, dynamic>? userMap;
  //   final userStr = await localStorage.read(loginDataModel);
  //   if (userStr != null) userMap = jsonDecode(userStr) as Map<String, dynamic>;
  //   if (userMap != null) {
  //     LoginDataModel user = LoginDataModel.fromJson(userMap);
  //     return user;
  //   }
  //   return null;
  // }

  // Future<LoginDataModel?> getSavedLoginData() async {
  //   try {
  //     final userStr = await localStorage.read('loginDataModel');
  //     if (userStr != null) {
  //       Map<String, dynamic> userMap = jsonDecode(userStr);
  //       return LoginDataModel.fromJson(userMap);
  //     }
  //   } catch (e, stack) {
  //     print("Error retrieving login data: $e  $stack");
  //   }
  //   return null;
  // }


  // Future getSaveRememberData() async {
  //   Map<String, dynamic>? userMap;
  //   final userStr = await localStorage.read(rememberMe);
  //   if (userStr != null) userMap = jsonDecode(userStr) as Map<String, dynamic>;
  //   if (userMap != null) {
  //     RememberMeModel user = RememberMeModel.fromJson(userMap);
  //     return user;
  //   }
  //   return null;
  // }

  // saveRememberMeData(RememberMeModel? model) async {
  //   localStorage.write(rememberMe, jsonEncode(model));
  // }

  clearRememberMeData() {
    localStorage.remove(rememberMe);
  }

  clearLoginData() {
    localStorage.remove(loginDataModel);
    localStorage.remove(authToken);
    localStorage.remove(isNotificationOn);
  }

  saveNotification(bool? notify) {
    localStorage.write(isNotificationOn, notify);
  }

  getNotification() {
    return localStorage.read(isNotificationOn);
  }

}

