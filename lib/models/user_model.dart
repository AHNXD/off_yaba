// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  int? id;
  String? token;
  String? name;
  String? phoneNumber;
  UserModel({
    this.id,
    this.token,
    this.name,
    this.phoneNumber,
  });

  UserModel copyWith({
    int? id,
    String? token,
    String? name,
    String? phoneNumber,
  }) {
    return UserModel(
      id: id ?? this.id,
      token: token ?? this.token,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? phoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'token': token,
      'name': name,
      'phone_number': phoneNumber,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as int : null,
      token: map['token'] != null ? map['token'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      phoneNumber:
          map['phone_number'] != null ? map['phone_number'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, token: $token, name: $name, phone_number: $phoneNumber)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.token == token &&
        other.name == name &&
        other.phoneNumber == phoneNumber;
  }

  @override
  int get hashCode {
    return id.hashCode ^ token.hashCode ^ name.hashCode ^ phoneNumber.hashCode;
  }
}
