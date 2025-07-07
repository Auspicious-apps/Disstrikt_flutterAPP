class SetupIntentResponseModel {
  bool? success;
  String? message;
  IntentData? data;

  SetupIntentResponseModel({this.success, this.message, this.data});

  SetupIntentResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new IntentData.fromJson(json['data']) : null;
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

class IntentData {
  bool? alreadySetup;
  String? customerId;
  String? clientSecret;
  String? paymentMethodId;

  IntentData(
      {this.alreadySetup,
      this.customerId,
      this.clientSecret,
      this.paymentMethodId});

  IntentData.fromJson(Map<String, dynamic> json) {
    alreadySetup = json['alreadySetup'];
    customerId = json['customerId'];
    clientSecret = json['clientSecret'];
    paymentMethodId = json['paymentMethodId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['alreadySetup'] = this.alreadySetup;
    data['customerId'] = this.customerId;
    data['clientSecret'] = this.clientSecret;
    data['paymentMethodId'] = this.paymentMethodId;
    return data;
  }
}
