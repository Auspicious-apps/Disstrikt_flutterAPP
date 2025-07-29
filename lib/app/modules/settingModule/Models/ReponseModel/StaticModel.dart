class StatiResponseModel {
  bool? success;
  String? message;
  StaticData? data;

  StatiResponseModel({this.success, this.message, this.data});

  StatiResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new StaticData.fromJson(json['data']) : null;
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

class StaticData {
  TermAndCondition? termAndCondition;
  TermAndCondition? privacyPolicy;
  Support? support;
  StaticData({this.termAndCondition, this.privacyPolicy, this.support});

  StaticData.fromJson(Map<String, dynamic> json) {
    termAndCondition = json['termAndCondition'] != null
        ? new TermAndCondition.fromJson(json['termAndCondition'])
        : null;
    privacyPolicy = json['privacyPolicy'] != null
        ? new TermAndCondition.fromJson(json['privacyPolicy'])
        : null;
    support =
        json['support'] != null ? new Support.fromJson(json['support']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.termAndCondition != null) {
      data['termAndCondition'] = this.termAndCondition!.toJson();
    }
    if (this.privacyPolicy != null) {
      data['privacyPolicy'] = this.privacyPolicy!.toJson();
    }
    if (this.support != null) {
      data['support'] = this.support!.toJson();
    }
    return data;
  }
}

class Support {
  String? phone;
  String? email;
  Address? address;

  Support({this.phone, this.email, this.address});

  Support.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    email = json['email'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['email'] = this.email;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    return data;
  }
}

class Address {
  String? en;
  String? nl;
  String? fr;
  String? es;

  Address({this.en, this.nl, this.fr, this.es});

  Address.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    nl = json['nl'];
    fr = json['fr'];
    es = json['es'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en'] = this.en;
    data['nl'] = this.nl;
    data['fr'] = this.fr;
    data['es'] = this.es;
    return data;
  }
}

class TermAndCondition {
  String? en;
  String? nl;
  String? fr;
  String? es;

  TermAndCondition({this.en, this.nl, this.fr, this.es});

  TermAndCondition.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    nl = json['nl'];
    fr = json['fr'];
    es = json['es'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en'] = this.en;
    data['nl'] = this.nl;
    data['fr'] = this.fr;
    data['es'] = this.es;
    return data;
  }
}
