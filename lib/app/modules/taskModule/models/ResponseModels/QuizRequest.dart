class QuizAnswer {
  String quizId;
  String answer;

  QuizAnswer({required this.quizId, required this.answer});

  factory QuizAnswer.fromJson(Map<String, dynamic> json) {
    return QuizAnswer(
      quizId: json['quizId'],
      answer: json['answer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quizId': quizId,
      'answer': answer,
    };
  }
}

class QuizRequest {
  List<QuizAnswer> quiz;

  QuizRequest({required this.quiz});

  factory QuizRequest.fromJson(Map<String, dynamic> json) {
    return QuizRequest(
      quiz: (json['quiz'] as List<dynamic>)
          .map((e) => QuizAnswer.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quiz': quiz.map((e) => e.toJson()).toList(),
    };
  }
}
