class EnrollmentModel {
  final String? id;
  final String? enrollmentCode;
  final DateTime timestamp;
  final int status;
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
    const Map<String, int> statusMap = {
      'Active': 0,
      'Inactive': 1,
      'Completed': 2,
    };
    
    int? safeParseInt(dynamic value) {
      if (value == null) return null;
      if (value is int) return value;
      if (value is String) {
        final int? mappedStatus = statusMap[value.toUpperCase()];
        if (mappedStatus != null) return mappedStatus;
        return int.tryParse(value);
      }
      return null;
    }

    final rawStatus = map['status'];
    final int finalStatus = safeParseInt(rawStatus) ?? 0;

    return EnrollmentModel(
      id: map['id'] as String?,
      enrollmentCode: map['enrollmentCode'] as String?,
      timestamp: DateTime.parse(timestampStr),
      status: finalStatus,
      progressPercentage: safeParseInt(map['progressPercentage']),
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