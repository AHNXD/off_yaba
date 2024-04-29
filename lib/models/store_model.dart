// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:off_yaba/services/network/apiService.dart';

class StoreModel {
  int? id;
  String? name;
  String? image;
  String? address;
  int? discount;
  StoreSectionModel? section;
  double? distance;

  StoreModel({
    required this.id,
    required this.name,
    required this.image,
    required this.address,
    required this.discount,
    required this.section,
    required this.distance,
  });

  StoreModel copyWith({
    int? id,
    String? name,
    String? image,
    String? address,
    int? discount,
    StoreSectionModel? section,
    double? distance,
  }) {
    return StoreModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      address: address ?? this.address,
      discount: discount ?? this.discount,
      section: section ?? this.section,
      distance: distance ?? this.distance,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'address': address,
      'discount': discount,
      'section': section?.toMap(),
      'distance': distance,
    };
  }

  factory StoreModel.fromMap(Map<String, dynamic> map) {
    return StoreModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      image: map['image'] != null
          ? "${DioHelper.baseUrl}image?path=${map['image']}"
          : null,
      address: map['address'] != null ? map['address'] as String : null,
      discount: map['discount'] != null ? map['discount'] as int : null,
      section: map['section'] != null
          ? StoreSectionModel.fromMap(map['section'] as Map<String, dynamic>)
          : null,
      distance: map['distance'] != null ? map['distance'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory StoreModel.fromJson(String source) =>
      StoreModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StoreModel(id: $id, name: $name, image: $image, address: $address, discount: $discount, section: $section, distance: $distance)';
  }

  @override
  bool operator ==(covariant StoreModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.image == image &&
        other.address == address &&
        other.discount == discount &&
        other.section == section &&
        other.distance == distance;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        image.hashCode ^
        address.hashCode ^
        discount.hashCode ^
        section.hashCode ^
        distance.hashCode;
  }
}

class StoreSectionModel {
  int? id;
  String? name;

  StoreSectionModel({
    required this.id,
    required this.name,
  });

  StoreSectionModel copyWith({
    int? id,
    String? name,
  }) {
    return StoreSectionModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory StoreSectionModel.fromMap(Map<String, dynamic> map) {
    return StoreSectionModel(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory StoreSectionModel.fromJson(String source) =>
      StoreSectionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'StoreSectionModel(id: $id, name: $name)';

  @override
  bool operator ==(covariant StoreSectionModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
