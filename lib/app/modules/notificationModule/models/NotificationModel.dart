class NotificationModel {
  bool? success;
  String? message;
  NotificationData? data;

  NotificationModel({this.success, this.message, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? new NotificationData.fromJson(json['data'])
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

class NotificationData {
  num? total;
  num? page;
  num? limit;
  num? totalPages;
  List<NotificationsListItem>? notifications;

  NotificationData(
      {this.total, this.page, this.limit, this.totalPages, this.notifications});

  NotificationData.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    page = json['page'];
    limit = json['limit'];
    totalPages = json['totalPages'];
    if (json['notifications'] != null) {
      notifications = <NotificationsListItem>[];
      json['notifications'].forEach((v) {
        notifications!.add(new NotificationsListItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['totalPages'] = this.totalPages;
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationsListItem {
  String? sId;
  String? userId;
  String? type;
  String? title;
  String? description;
  String? language;
  bool? isRead;
  String? createdAt;
  String? updatedAt;
  int? iV;

  NotificationsListItem(
      {this.sId,
      this.userId,
      this.type,
      this.title,
      this.description,
      this.language,
      this.isRead,
      this.createdAt,
      this.updatedAt,
      this.iV});

  NotificationsListItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    type = json['type'];
    title = json['title'];
    description = json['description'];
    language = json['language'];
    isRead = json['isRead'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['type'] = this.type;
    data['title'] = this.title;
    data['description'] = this.description;
    data['language'] = this.language;
    data['isRead'] = this.isRead;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
