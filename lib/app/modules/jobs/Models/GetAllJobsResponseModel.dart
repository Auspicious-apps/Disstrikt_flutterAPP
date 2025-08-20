class GetAllJobsResponse {
  bool? success;
  String? message;
  JobResponseData? data;

  GetAllJobsResponse({this.success, this.message, this.data});

  GetAllJobsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'] as bool?;
    message = json['message'] as String?;
    data = json['data'] != null ? JobResponseData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class JobResponseData {
  List<JobData>? data;

  JobResponseData({this.data});

  JobResponseData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <JobData>[];
      json['data'].forEach((v) {
        data!.add(JobData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class JobData {
  String? sId;
  num? minAge;
  num? maxAge;
  String? date;
  num? time;
  num? pay;
  String? currency;
  String? countryCode;
  List<String>? appliedUsers;
  bool? isActive;
  num? iV;
  String? title;
  String? branch;
  String? description;
  String? companyName;
  String? location;
  String? city;
  String? country;
  String? gender;
  String? status;
  num? minHeightInCm;
  String? type;

  JobData({
    this.sId,
    this.minAge,
    this.maxAge,
    this.date,
    this.time,
    this.pay,
    this.currency,
    this.countryCode,
    this.appliedUsers,
    this.isActive,
    this.iV,
    this.title,
    this.branch,
    this.description,
    this.companyName,
    this.location,
    this.city,
    this.country,
    this.gender,
    this.status,
    this.minHeightInCm,
    this.type,
  });

  JobData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] as String?;
    minAge = json['minAge'] as int?;
    maxAge = json['maxAge'] as int?;
    date = json['date'] as String?;
    time = json['time'] as int?;
    pay = json['pay'] as int?;
    currency = json['currency'] as String?;
    countryCode = json['countryCode'] as String?;
    appliedUsers = (json['appliedUsers'] as List<dynamic>?)?.cast<String>();
    isActive = json['isActive'] as bool?;
    iV = json['__v'] as int?;
    title = json['title'] as String?;
    branch = json['branch'] as String?;
    description = json['description'] as String?;
    companyName = json['companyName'] as String?;
    location = json['location'] as String?;
    city = json['city'] as String?;
    country = json['country'] as String?;
    gender = json['gender'] as String?;
    status = json['status'] as String?;
    minHeightInCm = json['minHeightInCm'] as int?;
    type = json['type'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['minAge'] = minAge;
    data['maxAge'] = maxAge;
    data['date'] = date;
    data['time'] = time;
    data['pay'] = pay;
    data['currency'] = currency;
    data['countryCode'] = countryCode;
    data['appliedUsers'] = appliedUsers;
    data['isActive'] = isActive;
    data['__v'] = iV;
    data['title'] = title;
    data['branch'] = branch;
    data['description'] = description;
    data['companyName'] = companyName;
    data['location'] = location;
    data['city'] = city;
    data['country'] = country;
    data['gender'] = gender;
    data['status'] = status;
    data['minHeightInCm'] = minHeightInCm;
    data['type'] = type;
    return data;
  }
}
