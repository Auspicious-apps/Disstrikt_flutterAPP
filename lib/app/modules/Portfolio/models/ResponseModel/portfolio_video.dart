import 'package:disstrikt/app/modules/Portfolio/models/ResponseModel/portfolio_responseModel.dart';

class PortfolioVideoResponseModel {
  bool? success;
  String? message;
  List<Videos>? data;

  PortfolioVideoResponseModel({this.success, this.message, this.data});

  PortfolioVideoResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] as bool?;
    message = json['message'] as String?;
    if (json['data'] != null) {
      data = (json['data'] as List)
          .map((item) => Videos.fromJson(item as Map<String, dynamic>))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((item) => item.toJson()).toList();
    }
    return data;
  }
}
