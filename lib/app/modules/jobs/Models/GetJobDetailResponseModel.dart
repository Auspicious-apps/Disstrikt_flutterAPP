import 'GetAllJobsResponseModel.dart';

class GetJobsDetailResponse {
  bool? success;
  String? message;
  JobData? data;

  GetJobsDetailResponse({this.success, this.message, this.data});

  GetJobsDetailResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new JobData.fromJson(json['data']) : null;
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
