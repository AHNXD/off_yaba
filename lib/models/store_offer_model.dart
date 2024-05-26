import 'dart:convert';

import 'package:off_yaba/services/network/api_service.dart';

class StoreOfferModel {
  int? discount;
  String? image;
  StoreOfferModel({
    this.discount,
    this.image,
  });

  StoreOfferModel copyWith({
    int? discount,
    String? image,
  }) {
    return StoreOfferModel(
      discount: discount ?? this.discount,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'discount': discount,
      'image': image,
    };
  }

  factory StoreOfferModel.fromMap(Map<String, dynamic> map) {
    return StoreOfferModel(
      discount: map['discount'] != null ? map['discount'] as int : null,
      image: map['image'] != null
          ? "${DioHelper.baseUrl}image?path=${map['image']}"
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory StoreOfferModel.fromJson(String source) =>
      StoreOfferModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'StoreOfferModel(discount: $discount, image: $image)';

  @override
  bool operator ==(covariant StoreOfferModel other) {
    if (identical(this, other)) return true;

    return other.discount == discount && other.image == image;
  }

  @override
  int get hashCode => discount.hashCode ^ image.hashCode;
}
