// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:off_yaba/models/store_model.dart';
import 'package:off_yaba/services/network/api_service.dart';

class ClothingItemModel {
  int? id;
  String? name;
  double? price;
  double? discount;
  StoreModel? store;
  String? image;
  String? type;
  List<String>? sizes;
  String? targetGroup;
  List<String>? colors;
  String? material;
  ClothingItemModel({
    this.id,
    this.name,
    this.price,
    this.discount,
    this.store,
    this.image,
    this.type,
    this.sizes,
    this.targetGroup,
    this.colors,
    this.material,
  });

  ClothingItemModel copyWith({
    int? id,
    String? name,
    double? price,
    double? discount,
    StoreModel? store,
    String? image,
    String? type,
    List<String>? sizes,
    String? target_group,
    List<String>? colors,
    String? material,
  }) {
    return ClothingItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      discount: discount ?? this.discount,
      store: store ?? this.store,
      image: image ?? this.image,
      type: type ?? this.type,
      sizes: sizes ?? this.sizes,
      targetGroup: target_group ?? targetGroup,
      colors: colors ?? this.colors,
      material: material ?? this.material,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
      'discount': discount,
      'store': store?.toMap(),
      'image': image,
      'type': type,
      'sizes': sizes,
      'target_group': targetGroup,
      'colors': colors,
      'material': material,
    };
  }

  factory ClothingItemModel.fromMap(Map<String, dynamic> map) {
    return ClothingItemModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      price: map['price']?.toDouble(),
      discount: map['discount'] != null ? map['discount'] as double : null,
      store: map['store'] != null
          ? StoreModel.fromMap(map['store'] as Map<String, dynamic>)
          : null,
      image: map['image'] != null
          ? "${DioHelper.baseUrl}image?path=${map['image']}"
          : null,
      type: map['type'] != null ? map['type'] as String : null,
      sizes: map['sizes'] != null
          ? (map['sizes'] as List).map((item) => item as String).toList()
          : [],
      targetGroup:
          map['target_group'] != null ? map['target_group'] as String : null,
      colors: map['colors'] != null
          ? (map['colors'] as List).map((item) => item as String).toList()
          : [],
      material: map['material'] != null ? map['material'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ClothingItemModel.fromJson(String source) =>
      ClothingItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ClothingItemModel(id: $id, name: $name, price: $price, discount: $discount, store: $store, image: $image, type: $type, sizes: $sizes, target_group: $targetGroup, colors: $colors, material: $material)';
  }

  @override
  bool operator ==(covariant ClothingItemModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.price == price &&
        other.discount == discount &&
        other.store == store &&
        other.image == image &&
        other.type == type &&
        listEquals(other.sizes, sizes) &&
        other.targetGroup == targetGroup &&
        other.colors == colors &&
        other.material == material;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        price.hashCode ^
        discount.hashCode ^
        store.hashCode ^
        image.hashCode ^
        type.hashCode ^
        sizes.hashCode ^
        targetGroup.hashCode ^
        colors.hashCode ^
        material.hashCode;
  }
}
