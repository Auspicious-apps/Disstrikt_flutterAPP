class AuthRequestModel {
/*===================================================Register Request Model==============================================*/
  static SignupRequestModel({
    String? fullName,
    String? email,
    String? password,
    String? phone,
    String? countryCode,
    String? language,
    String? fcmToken,
    String? country,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["fullName"] = fullName;
    data["email"] = email;
    data["phone"] = phone;
    data["countryCode"] = countryCode;
    data["password"] = password;
    data["language"] = language;
    data["fcmToken"] = fcmToken;
    data["country"] = country;
    return data;
  }

  static ChangePasswordRequestModel({
    String? oldPassword,
    String? newPassword,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["oldPassword"] = oldPassword;
    data["newPassword"] = newPassword;

    return data;
  }

  static ChangeCountryRequestModel({
    String? country,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["country"] = country;
    return data;
  }

  static ChangeLanguageRequestModel({
    String? updatedLanguage,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["updatedLanguage"] = updatedLanguage;
    return data;
  }

  static EditProfileRequestModel(
      {num? heightCm,
      num? bustCm,
      num? waistCm,
      num? hipsCm,
      num? weightKg,
      num? shoeSizeUK,
      String? dob,
      String? gender,
      String? fullName,
      String? image}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["heightCm"] = heightCm;
    data["bustCm"] = bustCm;
    data["waistCm"] = waistCm;
    data["hipsCm"] = hipsCm;
    data["weightKg"] = weightKg;
    data["shoeSizeUK"] = shoeSizeUK;
    data["dob"] = dob;
    data["gender"] = gender;
    data["fullName"] = fullName;
    data["image"] = image;

    return data;
  }

  static ChangeSubscriptionRequestModel({
    String? type,
    String? planId,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["type"] = type;
    data["planId"] = planId;
    return data;
  }

  static socialloginApiRequest({
    required String authType,
    required String idToken,
    required String fcmToken,
    required String language,
    required String country,
    required String deviceType,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['authType'] = authType;
    data['idToken'] = idToken;
    data['fcmToken'] = fcmToken;
    data['language'] = language;
    data["country"] = country;
    data["deviceType"] = deviceType;

    return data;
  }

  static LoginRequestModel({
    String? email,
    String? password,
    String? language,
    String? fcmToken,
    String? country,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["email"] = email;

    data["password"] = password;
    data["language"] = language;
    data["fcmToken"] = fcmToken;
    data["country"] = country;
    return data;
  }

  static ResendRequestModel({
    String? otp,
    String? value,
    String? purpose,
    String? language,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["value"] = value;
    data["otp"] = otp;
    data["purpose"] = purpose;
    data["language"] = language;
    return data;
  }

  static moreInfoRequestModel({
    num? heightCm,
    num? bustCm,
    num? waistCm,
    num? hipsCm,
    num? weightKg,
    num? shoeSizeUK,
    String? dob,
    String? gender,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["measurements"] = {
      "heightCm": heightCm,
      "bustCm": bustCm,
      "waistCm": waistCm,
      "hipsCm": hipsCm,
      "weightKg": weightKg,
      "shoeSizeUK": shoeSizeUK,
    };
    data["dob"] = dob;
    data["gender"] = gender;
    return data;
  }
}
