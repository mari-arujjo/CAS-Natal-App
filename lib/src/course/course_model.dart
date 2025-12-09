import 'dart:convert';
import 'dart:typed_data';

class CourseModel{
  final String? id;
  final String? courseCode;
  final String name;
  final String symbol;
  final String description;
  final Uint8List? photo;

  CourseModel({
    this.id, 
    this.courseCode, 
    required this.name, 
    required this.symbol, 
    required this.description,
    this.photo
  });

  factory CourseModel.fromMap(Map<String, dynamic> map){
    return CourseModel(
      id: map['id']??'', 
      courseCode: map['courseCode']??'',
      name: map['name']??'',
      symbol: map['symbol']??'', 
      description: map['description']??'',
      photo: map['photo'] != null && map['photo'] is String ? base64Decode(map['photo']) : null,
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
    };
  }
}