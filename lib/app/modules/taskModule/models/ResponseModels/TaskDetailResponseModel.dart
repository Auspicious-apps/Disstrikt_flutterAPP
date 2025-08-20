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

class Quiz {
  String? sId;
  String? taskId;
  num? questionNumber;
  String? answer;
  String? question;
  String? optionA;
  String? optionB;
  String? optionC;
  String? optionD;

  Quiz(
      {this.sId,
      this.taskId,
      this.questionNumber,
      this.answer,
      this.question,
      this.optionA,
      this.optionB,
      this.optionC,
      this.optionD});

  Quiz.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    taskId = json['taskId'];
    questionNumber = json['questionNumber'];
    answer = json['answer'];
    question = json['question'];
    optionA = json['option_A'];
    optionB = json['option_B'];
    optionC = json['option_C'];
    optionD = json['option_D'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['taskId'] = this.taskId;
    data['questionNumber'] = this.questionNumber;
    data['answer'] = this.answer;
    data['question'] = this.question;
    data['option_A'] = this.optionA;
    data['option_B'] = this.optionB;
    data['option_C'] = this.optionC;
    data['option_D'] = this.optionD;
    return data;
  }
}

class TaskDetailData {
  String? sId;
  String? taskType;
  String? answerType;
  List<String>? link;
  num? taskNumber;
  num? milestone;
  String? title;
  String? description;
  String? subject;
  List<Quiz>? quiz;

  TaskDetailData(
      {this.sId,
      this.taskType,
      this.answerType,
      this.taskNumber,
      this.milestone,
      this.title,
      this.link,
      this.description,
      this.subject,
      this.quiz});

  TaskDetailData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    taskType = json['taskType'];
    answerType = json['answerType'];
    link = json['link'].cast<String>();
    taskNumber = json['taskNumber'];
    milestone = json['milestone'];
    title = json['title'];
    description = json['description'];
    subject = json['subject'];
    if (json['quiz'] != null) {
      quiz = <Quiz>[];
      json['quiz'].forEach((v) {
        quiz!.add(new Quiz.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['taskType'] = this.taskType;
    data['answerType'] = this.answerType;
    data['link'] = this.link;
    data['taskNumber'] = this.taskNumber;
    data['milestone'] = this.milestone;
    data['title'] = this.title;
    data['description'] = this.description;
    data['subject'] = this.subject;
    if (this.quiz != null) {
      data['quiz'] = this.quiz!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
