class EnrollmentModel {
  final String? id;
  final String? enrollmentCode;
  final DateTime timestamp;
  final String status;
  final int? progressPercentage;
  final String? courseId;
  final String? userId;
  final String? symbol;

  EnrollmentModel({
    this.id, 
    this.enrollmentCode, 
    required this.timestamp, 
    required this.status, 
    this.progressPercentage, 
    this.courseId, 
    this.userId,
    this.symbol,
  });

  factory EnrollmentModel.fromMap(Map<String, dynamic> map) {
    final String timestampStr = map['timestamp'] as String? ?? DateTime.now().toIso8601String();

    return EnrollmentModel(
      id: map['id'] as String?,
      enrollmentCode: map['enrollmentCode'] as String?,
      timestamp: DateTime.parse(timestampStr),
      status: map['status'] as String? ?? 'Unknown',
      progressPercentage: map['progressPercentage'] as int?,
      courseId: map['courseId'] as String?,
      userId: map['userId'] as String?,
      symbol: map['symbol'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'enrollmentCode': enrollmentCode,
      'timestamp': timestamp.toIso8601String(),
      'status': status,
      'progressPercentage': progressPercentage,
      'courseId': courseId,
      'userId': userId,
      'symbol': symbol,
    };
  }
}