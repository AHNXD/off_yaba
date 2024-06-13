// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:off_yaba/services/network/api_service.dart';

class StoreOfferModel {
  int? id;
  int? discount;
  String? image;
  String? title;
  String? body;
  int itemCount;

  StoreOfferModel({
    this.id,
    this.discount,
    this.image,
    this.title,
    this.body,
    this.itemCount = 0,
  });

  StoreOfferModel copyWith({
    int? id,
    int? discount,
    String? image,
    String? title,
    String? body,
    int? itemCount,
  }) {
    return StoreOfferModel(
      id: id ?? this.id,
      discount: discount ?? this.discount,
      image: image ?? this.image,
      title: title ?? this.title,
      body: body ?? this.body,
      itemCount: itemCount ?? this.itemCount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'discount': discount,
      'image': image,
      'title': title,
      'body': body,
      'itemCount': itemCount,
    };
  }

  factory StoreOfferModel.fromMap(Map<String, dynamic> map,
      {String source = "web"}) {
    return StoreOfferModel(
      id: map['id'] != null ? map['id'] as int : null,
      discount: map['discount'] != null ? map['discount'] as int : null,
      image: source == "web"
          ? "${DioHelper.baseUrl}image?path=${map['image']}"
          : map["image"],
      title: map['title'] != null ? map['title'] as String : null,
      body: map['body'] != null ? map['body'] as String : null,
      itemCount: map['itemCount'] != null ? map['itemCount'] as int : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory StoreOfferModel.fromJson(String source) =>
      StoreOfferModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StoreOfferModel(id: $id, discount: $discount, image: $image, title: $title, body: $body, itemCount: $itemCount)';
  }

  @override
  bool operator ==(covariant StoreOfferModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.discount == discount &&
        other.image == image &&
        other.title == title &&
        other.body == body &&
        other.itemCount == itemCount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        discount.hashCode ^
        image.hashCode ^
        title.hashCode ^
        body.hashCode ^
        itemCount.hashCode;
  }
}
