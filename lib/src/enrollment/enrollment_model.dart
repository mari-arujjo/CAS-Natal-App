class EnrollmentModel {
  final String? id;
  final String? enrollmentCode;
  final DateTime timestamp;
  final String status;
  final int? progressPercentage;
  final String? courseId;
  final String? userId;

  EnrollmentModel({
    this.id, 
    this.enrollmentCode, 
    required this.timestamp, 
    required this.status, 
    this.progressPercentage, 
    this.courseId, 
    this.userId, 
  });

  factory EnrollmentModel.fromMap(Map<String, dynamic> map) {
    return EnrollmentModel(
      id: map['id']??'',
      enrollmentCode: map['enrollmentCode']??'',
      timestamp: DateTime.parse(map['timestamp'] as String),
      status: map['status']??'',
      progressPercentage: map['progressPercentage']??'',
      courseId: map['courseId']??'',
      userId: map['userId']??'',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'enrollmentCode': enrollmentCode,
      'timestamp': timestamp,
      'status': status,
      'progressPercentage': progressPercentage,
      'courseId': courseId,
      'userId': userId,
    };
  }
}