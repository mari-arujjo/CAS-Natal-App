class LessonTopicModel {
  final String? id;
  final int order;
  final String title;
  final String textContent;

  LessonTopicModel({
    this.id,
    required this.order,
    required this.title,
    required this.textContent,
  });

  factory LessonTopicModel.fromMap(Map<String, dynamic> map) {
    return LessonTopicModel(
      id: map['id'],
      order: map['order'] ?? 0,
      title: map['title'] ?? '',
      textContent: map['textContent'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'order': order,
      'title': title,
      'textContent': textContent,
    };
  }
}

class LessonModel {
  final String? id;
  final String? lessonCode;
  final String name;
  final int order;
  final bool completed;
  final String url;
  final String content;
  final List<LessonTopicModel> topics;
  final String? courseId;

  LessonModel({
    this.id,
    this.lessonCode,
    required this.name,
    required this.order,
    required this.completed,
    required this.url,
    required this.content,
    required this.topics,
    this.courseId,
  });

  factory LessonModel.fromMap(Map<String, dynamic> map) {
    return LessonModel(
      id: map['id'] ?? '',
      lessonCode: map['lessonCode'] ?? '',
      name: map['name'] ?? '',
      order: map['order'] ?? 0,
      completed: map['completed'] ?? false,
      url: map['url'] ?? '',
      content: map['content'] ?? '',
      topics: (map['topics'] as List? ?? [])
          .map((t) => LessonTopicModel.fromMap(t))
          .toList(),
      courseId: map['courseId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'lessonCode': lessonCode,
      'name': name,
      'order': order,
      'completed': completed,
      'url': url,
      'content': content,
      'topics': topics.map((t) => t.toMap()).toList(),
      'courseId': courseId,
    };
  }
}