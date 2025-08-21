class Message {
  bool? success;
  String? message;
  QuizResponse? data;

  Message({this.success, this.message, this.data});

  Message.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data =
        json['data'] != null ? new QuizResponse.fromJson(json['data']) : null;
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

class QuizResponse {
  num? correctCount;
  num? totalCount;

  QuizResponse({required this.correctCount, required this.totalCount});

  factory QuizResponse.fromJson(Map<String, dynamic> json) {
    return QuizResponse(
      correctCount: json['correctCount'],
      totalCount: json['totalCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'correctCount': correctCount,
      'totalCount': totalCount,
    };
  }
}
