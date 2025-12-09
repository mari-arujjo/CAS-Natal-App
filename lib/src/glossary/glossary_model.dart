class GlossaryModel {
  final String? id;
  final String? glossaryCode;
  final String sign;
  final String description;
  final String? url;
  final String category;

  GlossaryModel({
    this.id, 
    this.glossaryCode, 
    required this.sign, 
    required this.description, 
    this.url, 
    required this.category,
  });

  factory GlossaryModel.fromMap(Map<String, dynamic> map){
    return GlossaryModel(
      id: map['id']??'',
      glossaryCode: map['glossaryCode']??'',
      sign: map['sign']??'',
      description: map['description']??'', 
      url: map['url']??'',
      category: map['category']??''
    );
  }

  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'glossaryCode': glossaryCode,
      'sign': sign,
      'description': description,
      'url': url,
      'category': category
    };
  }
}