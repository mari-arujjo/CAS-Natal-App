class LessonModel {
  final String? id;
  final String? lessonCode;
  final String name;
  final bool completed;
  final String url;
  final String content;
  final String? courseId;

  LessonModel({
    this.id,
    this.lessonCode,
    required this.name,
    required this.completed,
    required this.url,
    required this.content,
    this.courseId,
  });

  factory LessonModel.fromMap(Map<String, dynamic> map){
    return LessonModel(
      id: map['id']??'', 
      lessonCode: map['lessonCode']??'', 
      name: map['name']??'', 
      completed: map['completed']??'', 
      url: map['url']??'', 
      content: map['content']??'', 
      courseId: map['courseId']??'', 
    );
  }

  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'lessonCode': lessonCode,
      'name': name,
      'completed': completed,
      'url': url,
      'content': content,
      'courseId': courseId,
    };
  }
}