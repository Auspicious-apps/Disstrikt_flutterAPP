class ActivePlanResponsemodel {
  bool? success;
  String? message;
  ActivePlanData? data;

  ActivePlanResponsemodel({this.success, this.message, this.data});

  ActivePlanResponsemodel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data =
        json['data'] != null ? new ActivePlanData.fromJson(json['data']) : null;
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

class ActivePlanData {
  String? sId;
  String? userId;
  String? stripeCustomerId;
  String? stripeSubscriptionId;
  String? planId;
  String? paymentMethodId;
  String? status;
  String? trialStart;
  String? trialEnd;
  String? startDate;

  num? amount;
  String? currency;
  String? nextPlanId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ActivePlanData(
      {this.sId,
      this.userId,
      this.stripeCustomerId,
      this.stripeSubscriptionId,
      this.planId,
      this.paymentMethodId,
      this.status,
      this.trialStart,
      this.trialEnd,
      this.startDate,
      this.amount,
      this.currency,
      this.nextPlanId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  ActivePlanData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    stripeCustomerId = json['stripeCustomerId'];
    stripeSubscriptionId = json['stripeSubscriptionId'];
    planId = json['planId'];
    paymentMethodId = json['paymentMethodId'];
    status = json['status'];
    trialStart = json['trialStart'];
    trialEnd = json['trialEnd'];
    startDate = json['startDate'];

    amount = json['amount'];
    currency = json['currency'];
    nextPlanId = json['nextPlanId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['stripeCustomerId'] = this.stripeCustomerId;
    data['stripeSubscriptionId'] = this.stripeSubscriptionId;
    data['planId'] = this.planId;
    data['paymentMethodId'] = this.paymentMethodId;
    data['status'] = this.status;
    data['trialStart'] = this.trialStart;
    data['trialEnd'] = this.trialEnd;
    data['startDate'] = this.startDate;

    data['amount'] = this.amount;
    data['currency'] = this.currency;
    data['nextPlanId'] = this.nextPlanId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
