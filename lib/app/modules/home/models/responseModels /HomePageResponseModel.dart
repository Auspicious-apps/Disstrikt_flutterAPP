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
  List<Milestone1>? milestone1;
  List<Milestone1>? milestone2;
  List<Milestone1>? milestone3;
  List<Milestone1>? milestone4;
  List<Milestone1>? milestone5;
  List<Milestone1>? milestone6;
  List<Milestone1>? milestone7;
  List<Milestone1>? milestone8;
  Pagination? pagination;

  HomeMilestoneData(
      {this.plan,
      this.fullName,
      this.image,
      this.planName,
      this.milestone,
      this.percentage,
      this.milestone1,
      this.milestone2,
      this.milestone3,
      this.milestone4,
      this.milestone5,
      this.milestone6,
      this.milestone7,
      this.milestone8,
      this.pagination});

  HomeMilestoneData.fromJson(Map<String, dynamic> json) {
    plan = json['plan'];
    fullName = json['fullName'];
    image = json['image'];
    planName = json['planName'];
    milestone = json['milestone'];
    percentage = json['percentage'];
    if (json['milestone1'] != null) {
      milestone1 = <Milestone1>[];
      json['milestone1'].forEach((v) {
        milestone1!.add(new Milestone1.fromJson(v));
      });
    }
    if (json['milestone2'] != null) {
      milestone2 = <Milestone1>[];
      json['milestone2'].forEach((v) {
        milestone2!.add(new Milestone1.fromJson(v));
      });
    }
    if (json['milestone3'] != null) {
      milestone3 = <Milestone1>[];
      json['milestone3'].forEach((v) {
        milestone3!.add(new Milestone1.fromJson(v));
      });
    }
    if (json['milestone4'] != null) {
      milestone4 = <Milestone1>[];
      json['milestone4'].forEach((v) {
        milestone4!.add(new Milestone1.fromJson(v));
      });
    }
    if (json['milestone5'] != null) {
      milestone5 = <Milestone1>[];
      json['milestone5'].forEach((v) {
        milestone5!.add(new Milestone1.fromJson(v));
      });
    }
    if (json['milestone6'] != null) {
      milestone6 = <Milestone1>[];
      json['milestone6'].forEach((v) {
        milestone6!.add(new Milestone1.fromJson(v));
      });
    }
    if (json['milestone7'] != null) {
      milestone7 = <Milestone1>[];
      json['milestone7'].forEach((v) {
        milestone7!.add(new Milestone1.fromJson(v));
      });
    }
    if (json['milestone8'] != null) {
      milestone8 = <Milestone1>[];
      json['milestone8'].forEach((v) {
        milestone8!.add(new Milestone1.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plan'] = this.plan;
    data['fullName'] = this.fullName;
    data['image'] = this.image;
    data['planName'] = this.planName;
    data['milestone'] = this.milestone;
    data['percentage'] = this.percentage;
    if (this.milestone1 != null) {
      data['milestone1'] = this.milestone1!.map((v) => v.toJson()).toList();
    }
    if (this.milestone2 != null) {
      data['milestone2'] = this.milestone2!.map((v) => v.toJson()).toList();
    }
    if (this.milestone3 != null) {
      data['milestone3'] = this.milestone3!.map((v) => v.toJson()).toList();
    }
    if (this.milestone4 != null) {
      data['milestone4'] = this.milestone4!.map((v) => v.toJson()).toList();
    }
    if (this.milestone5 != null) {
      data['milestone5'] = this.milestone5!.map((v) => v.toJson()).toList();
    }
    if (this.milestone6 != null) {
      data['milestone6'] = this.milestone6!.map((v) => v.toJson()).toList();
    }
    if (this.milestone7 != null) {
      data['milestone7'] = this.milestone7!.map((v) => v.toJson()).toList();
    }
    if (this.milestone8 != null) {
      data['milestone8'] = this.milestone8!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
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
