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

  static Map<String, dynamic> postPortfolioRequestModel(
      {String? aboutMe,
      List<Map<String, String>>? links,
      List<String>? setCards}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (aboutMe != null) {
      data["aboutMe"] = aboutMe;
    }
    if (setCards != null) {
      data["setCards"] = setCards; // Include setCards in the payload
    }
    if (links != null) {
      data["links"] = links
          .map((link) => {
                "platform": link["platform"],
                "url": link["url"],
              })
          .toList();
    }
    return data;
  }

  static Map<String, dynamic> addImageRequestModel({List<String>? url}) {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (url != null) {
      data["url"] = url; // Include setCards in the payload
    }

    return data;
  }

  static Map<String, dynamic> addVideoRequestModel(
      {String? url, String? title, String? thumbnail}) {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (url != null) {
      data["url"] = url;
      data["title"] = title;
      data["thumbnail"] = thumbnail;
      // Include setCards in the payload
    }

    return data;
  }
}
