class PlansResponseModel {
  bool? success;
  String? message;
  List<PlanData>? data;

  PlansResponseModel({this.success, this.message, this.data});

  PlansResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PlanData>[];
      json['data'].forEach((v) {
        data!.add(new PlanData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlanData {
  String? name;
  String? description;
  List<String>? features;
  num? trialDays;
  num? gbpAmount;
  num? eurAmount;
  List<String>? currency;
  String? sId;

  PlanData(
      {this.name,
      this.description,
      this.features,
      this.trialDays,
      this.gbpAmount,
      this.eurAmount,
      this.currency,
      this.sId});

  PlanData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    features = json['features'].cast<String>();
    trialDays = json['trialDays'];
    gbpAmount = json['gbpAmount'];
    eurAmount = json['eurAmount'];
    currency = json['currency'].cast<String>();
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['features'] = this.features;
    data['trialDays'] = this.trialDays;
    data['gbpAmount'] = this.gbpAmount;
    data['eurAmount'] = this.eurAmount;
    data['currency'] = this.currency;
    data['_id'] = this.sId;
    return data;
  }
}
