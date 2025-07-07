class BuyPlanRequestModel {
/*===================================================Register Request Model==============================================*/
  static planRequestModel({
    String? planId,
    String? currency,
    String? paymentMethodId,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["planId"] = planId;
    data["currency"] = currency;
    data["paymentMethodId"] = paymentMethodId;

    return data;
  }
}
