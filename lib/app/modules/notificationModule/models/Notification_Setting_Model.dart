class NotificationSettingModel {
  bool? success;
  String? message;
  NotificationSettingData? data;

  NotificationSettingModel({this.success, this.message, this.data});

  NotificationSettingModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? new NotificationSettingData.fromJson(json['data'])
        : null;
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

class NotificationSettingData {
  bool? jobAlerts;
  bool? tasksPortfolioProgress;
  bool? profilePerformance;
  bool? engagementMotivation;

  NotificationSettingData(
      {this.jobAlerts,
      this.tasksPortfolioProgress,
      this.profilePerformance,
      this.engagementMotivation});

  NotificationSettingData.fromJson(Map<String, dynamic> json) {
    jobAlerts = json['jobAlerts'];
    tasksPortfolioProgress = json['tasksPortfolioProgress'];
    profilePerformance = json['profilePerformance'];
    engagementMotivation = json['engagementMotivation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jobAlerts'] = this.jobAlerts;
    data['tasksPortfolioProgress'] = this.tasksPortfolioProgress;
    data['profilePerformance'] = this.profilePerformance;
    data['engagementMotivation'] = this.engagementMotivation;
    return data;
  }
}
