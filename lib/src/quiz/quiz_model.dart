class QuizOptionModel {
  final String id;
  final String optionText;
  final bool isCorrect;

  QuizOptionModel({
    required this.id,
    required this.optionText,
    required this.isCorrect,
  });

  factory QuizOptionModel.fromMap(Map<String, dynamic> map) {
    return QuizOptionModel(
      id: map['id'] as String,
      optionText: map['optionText'] as String,
      isCorrect: map['isCorrect'] as bool,
    );
  }
}

class QuizQuestionModel {
  final String id;
  final String lessonId;
  final String questionText;
  final String feedback;
  final int order;
  final List<QuizOptionModel> quizOptions;

  QuizQuestionModel({
    required this.id,
    required this.lessonId,
    required this.questionText,
    required this.feedback,
    required this.order,
    required this.quizOptions,
  });

  factory QuizQuestionModel.fromMap(Map<String, dynamic> map) {
    final optionsList = map['quizOptions'] as List<dynamic>? ?? [];
    return QuizQuestionModel(
      id: map['id'] as String,
      lessonId: map['lessonId'] as String,
      questionText: map['questionText'] as String,
      feedback: map['feedback'] as String,
      order: map['order'] ?? 0,
      quizOptions: optionsList.map((e) => QuizOptionModel.fromMap(e as Map<String, dynamic>)).toList(),
    );
  }
}