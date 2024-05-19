// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ApiFailure {
  String? message;
  int? statusCode;
  ApiFailure({
    this.message,
    this.statusCode,
  });

  ApiFailure copyWith({
    String? message,
    int? statusCode,
  }) {
    return ApiFailure(
      message: message ?? this.message,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'statusCode': statusCode,
    };
  }

  factory ApiFailure.fromMap(Map<String, dynamic> map) {
    return ApiFailure(
      message: map['message'] != null ? map['message'] as String : null,
      statusCode: map['statusCode'] != null ? map['statusCode'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ApiFailure.fromJson(String source) =>
      ApiFailure.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AuthError(message: $message, statusCode: $statusCode)';

  @override
  bool operator ==(covariant ApiFailure other) {
    if (identical(this, other)) return true;

    return other.message == message && other.statusCode == statusCode;
  }

  @override
  int get hashCode => message.hashCode ^ statusCode.hashCode;
}
