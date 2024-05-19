import 'dart:convert';

class CodeScannerModel {
  String? code;
  String? expAt;
  int? numberOfUsage;
  bool? isValid;
  CodeScannerModel({
    this.code,
    this.expAt,
    this.numberOfUsage,
    this.isValid,
  });

  CodeScannerModel copyWith({
    String? code,
    String? expAt,
    int? numberOfUsage,
    bool? isValid,
  }) {
    return CodeScannerModel(
      code: code ?? this.code,
      expAt: expAt ?? this.expAt,
      numberOfUsage: numberOfUsage ?? this.numberOfUsage,
      isValid: isValid ?? this.isValid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'expiration_date': expAt,
      'number_of_usage': numberOfUsage,
      'is_valid': isValid,
    };
  }

  factory CodeScannerModel.fromMap(Map<String, dynamic> map) {
    return CodeScannerModel(
      code: map['code'] != null ? map['code'] as String : null,
      expAt: map['expiration_date'] != null
          ? map['expiration_date'] as String
          : null,
      numberOfUsage:
          map['number_of_usage'] != null ? map['number_of_usage'] as int : null,
      isValid: map['is_valid'] != null ? map['is_valid'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CodeScannerModel.fromJson(String source) =>
      CodeScannerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'QrCode(code: $code, expiration_date: $expAt, number_of_usage: $numberOfUsage, is_valid: $isValid)';
  }

  @override
  bool operator ==(covariant CodeScannerModel other) {
    if (identical(this, other)) return true;

    return other.code == code &&
        other.expAt == expAt &&
        other.numberOfUsage == numberOfUsage &&
        other.isValid == isValid;
  }

  @override
  int get hashCode {
    return code.hashCode ^
        expAt.hashCode ^
        numberOfUsage.hashCode ^
        isValid.hashCode;
  }
}
