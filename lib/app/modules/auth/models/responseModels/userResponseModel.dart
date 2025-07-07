class UserResponseModel {
  bool? success;
  String? message;
  UserData? data;

  UserResponseModel({this.success, this.message, this.data});

  UserResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new UserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UserData {
  String? fullName;
  String? email;
  String? image;
  String? subscription;
  Measurements? measurements;
  String? dob;
  String? gender;
  String? country;
  String? fcmToken;
  String? language;
  String? authType;
  String? countryCode;
  String? phone;
  bool? isVerifiedEmail;
  bool? isUserInfoComplete;
  bool? isVerifiedPhone;
  bool? isDeleted;

  String? sId;
  String? createdAt;
  String? updatedAt;
  num? iV;
  num? age;
  String? id;
  String? token;

  UserData(
      {this.fullName,
      this.email,
      this.image,
      this.measurements,
      this.subscription,
      this.dob,
      this.isUserInfoComplete,
      this.gender,
      this.country,
      this.fcmToken,
      this.language,
      this.authType,
      this.countryCode,
      this.phone,
      this.isVerifiedEmail,
      this.isVerifiedPhone,
      this.isDeleted,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.age,
      this.token,
      this.id});

  UserData.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    email = json['email'];
    image = json['image'];
    isUserInfoComplete = json['isUserInfoComplete'];
    dob = json['dob'];
    subscription = json['subscription'];
    measurements = json['measurements'] != null
        ? new Measurements.fromJson(json['measurements'])
        : null;

    gender = json['gender'];
    country = json['country'];
    fcmToken = json['fcmToken'];
    language = json['language'];
    authType = json['authType'];
    countryCode = json['countryCode'];
    phone = json['phone'];
    token = json['token'];
    isVerifiedEmail = json['isVerifiedEmail'];
    isVerifiedPhone = json['isVerifiedPhone'];
    isDeleted = json['isDeleted'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    age = json['age'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['image'] = this.image;
    data['isUserInfoComplete'] = this.isUserInfoComplete;
    data['subscription'] = this.subscription;
    if (this.measurements != null) {
      data['measurements'] = this.measurements!.toJson();
    }
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['country'] = this.country;
    data['fcmToken'] = this.fcmToken;
    data['language'] = this.language;
    data['authType'] = this.authType;
    data['countryCode'] = this.countryCode;
    data['phone'] = this.phone;
    data['isVerifiedEmail'] = this.isVerifiedEmail;
    data['isVerifiedPhone'] = this.isVerifiedPhone;
    data['isDeleted'] = this.isDeleted;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['age'] = this.age;
    data['id'] = this.id;
    data['token'] = this.token;

    return data;
  }
}

class Measurements {
  num? heightCm;
  num? bustCm;
  num? waistCm;
  num? hipsCm;
  num? weightKg;
  num? shoeSizeUK;

  Measurements(
      {this.heightCm,
      this.bustCm,
      this.waistCm,
      this.hipsCm,
      this.weightKg,
      this.shoeSizeUK});

  Measurements.fromJson(Map<String, dynamic> json) {
    heightCm = json['heightCm'];
    bustCm = json['bustCm'];
    waistCm = json['waistCm'];
    hipsCm = json['hipsCm'];
    weightKg = json['weightKg'];
    shoeSizeUK = json['shoeSizeUK'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['heightCm'] = this.heightCm;
    data['bustCm'] = this.bustCm;
    data['waistCm'] = this.waistCm;
    data['hipsCm'] = this.hipsCm;
    data['weightKg'] = this.weightKg;
    data['shoeSizeUK'] = this.shoeSizeUK;
    return data;
  }
}
