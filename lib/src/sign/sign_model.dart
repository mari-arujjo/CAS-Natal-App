import 'dart:convert';
import 'dart:typed_data';

class SignModel {
  final String? id;
  final String? signCode;
  final String name;
  final String description;
  final String? url;
  final String category;
  final Uint8List? photo;

  SignModel({
    this.id, 
    this.signCode, 
    required this.name, 
    required this.description, 
    this.url, 
    required this.category,
    this.photo,
  });

  factory SignModel.fromMap(Map<String, dynamic> map){
    return SignModel(
      id: map['id']??'',
      signCode: map['signCode']??'',
      name: map['name']??'',
      description: map['description']??'', 
      url: map['url']??'',
      category: map['category']??'',
      photo: map['photo'] != null && map['photo'] is String ? base64Decode(map['photo']) : null,
    );
  }

  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'signCode': signCode,
      'name': name,
      'description': description,
      'url': url,
      'category': category,
      'photo': photo !=null ? base64Encode(photo!) : null,

    };
  }
}