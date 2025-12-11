import 'dart:convert';
import 'dart:typed_data';

import 'package:app_cas_natal/src/lesson/lesson_model.dart';

class CourseModel{
  final String? id;
  final String? courseCode;
  final String name;
  final String symbol;
  final String description;
  final Uint8List? photo;
  final List<LessonModel>? lessons;

  CourseModel({
    this.id, 
    this.courseCode, 
    required this.name, 
    required this.symbol, 
    required this.description,
    this.photo,
    this.lessons
  });

  factory CourseModel.fromMap(Map<String, dynamic> map){
    final List<dynamic>? lessonsList = map['lessons'] as List<dynamic>?;

    return CourseModel(
      id: map['id']??'', 
      courseCode: map['courseCode']??'',
      name: map['name']??'',
      symbol: map['symbol']??'', 
      description: map['description']??'',
      photo: map['photo'] != null && map['photo'] is String ? base64Decode(map['photo']) : null,
      lessons: lessonsList?.map((item) => LessonModel.fromMap(item as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'courseCode': courseCode,
      'name': name,
      'symbol': symbol,
      'description': description,
      'photo': photo != null ? base64Encode(photo!) : null,
      'lessons': lessons?.map((lesson) => lesson.toMap()).toList(),
    };
  }
}