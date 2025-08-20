class PortfolioImageResponseModel {
  bool? success;
  String? message;
  List<String>? data;

  PortfolioImageResponseModel({this.success, this.message, this.data});

  PortfolioImageResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? List<String>.from(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data;
    }
    return data;
  }
}
