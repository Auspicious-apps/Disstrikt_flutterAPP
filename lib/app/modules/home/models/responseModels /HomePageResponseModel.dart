class HomeResponseModel {
  bool? success;
  String? message;
  HomeMilestoneData? data;

  HomeResponseModel({this.success, this.message, this.data});

  HomeResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? new HomeMilestoneData.fromJson(json['data'])
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

class HomeMilestoneData {
  String? plan;
  num? milestone;
  String? fullName;
  String? image;
  String? planName;
  num? percentage;
  num? unlockedTask;
  List<Milestone1>? milestoneData;

  HomeMilestoneData({
    this.plan,
    this.fullName,
    this.image,
    this.planName,
    this.milestone,
    this.percentage,
    this.unlockedTask,
    this.milestoneData,
  });

  HomeMilestoneData.fromJson(Map<String, dynamic> json) {
    plan = json['plan'];
    fullName = json['fullName'];
    image = json['image'];
    planName = json['planName'];
    milestone = json['milestone'];
    percentage = json['percentage'];
    unlockedTask = json['unlockedTask'];
    if (json['milestoneData'] != null) {
      milestoneData = <Milestone1>[];
      json['milestoneData'].forEach((v) {
        milestoneData!.add(new Milestone1.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plan'] = this.plan;
    data['fullName'] = this.fullName;
    data['image'] = this.image;
    data['planName'] = this.planName;
    data['milestone'] = this.milestone;
    data['percentage'] = this.percentage;
    data['unlockedTask'] = this.unlockedTask;
    if (this.milestoneData != null) {
      data['milestoneData'] =
          this.milestoneData!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Milestone1 {
  String? sId;
  String? taskType;
  String? answerType;
  num? taskNumber;
  num? milestone;
  num? rating;
  bool? attempted;
  String? title;

  Milestone1(
      {this.sId,
      this.taskType,
      this.answerType,
      this.taskNumber,
      this.milestone,
      this.rating,
      this.attempted,
      this.title});

  Milestone1.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    taskType = json['taskType'];
    answerType = json['answerType'];
    taskNumber = json['taskNumber'];
    milestone = json['milestone'];
    rating = json['rating'];
    attempted = json['attempted'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['taskType'] = this.taskType;
    data['answerType'] = this.answerType;
    data['taskNumber'] = this.taskNumber;
    data['milestone'] = this.milestone;
    data['rating'] = this.rating;
    data['attempted'] = this.attempted;
    data['title'] = this.title;
    return data;
  }
}

class Pagination {
  num? page;
  num? limit;
  num? total;
  num? totalPages;

  Pagination({this.page, this.limit, this.total, this.totalPages});

  Pagination.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['total'] = this.total;
    data['totalPages'] = this.totalPages;
    return data;
  }
}
