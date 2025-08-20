class TaskDetailModel {
  bool? success;
  String? message;
  TaskDetailData? data;

  TaskDetailModel({this.success, this.message, this.data});

  TaskDetailModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data =
        json['data'] != null ? new TaskDetailData.fromJson(json['data']) : null;
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

class TaskDetailData {
  String? sId;
  String? taskType;
  String? answerType;

  int? taskNumber;
  int? milestone;
  String? title;
  String? description;
  String? subject;

  TaskDetailData(
      {this.sId,
      this.taskType,
      this.answerType,
      this.taskNumber,
      this.milestone,
      this.title,
      this.description,
      this.subject});

  TaskDetailData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    taskType = json['taskType'];
    answerType = json['answerType'];

    taskNumber = json['taskNumber'];
    milestone = json['milestone'];
    title = json['title'];
    description = json['description'];
    subject = json['subject'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['taskType'] = this.taskType;
    data['answerType'] = this.answerType;

    data['taskNumber'] = this.taskNumber;
    data['milestone'] = this.milestone;
    data['title'] = this.title;
    data['description'] = this.description;
    data['subject'] = this.subject;
    return data;
  }
}
