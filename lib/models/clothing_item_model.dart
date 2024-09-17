import 'package:off_yaba/models/store_model.dart';
import 'package:off_yaba/services/network/api_service.dart';

class ClothingItemModel {
  int? id;
  String? name;
  double? price;
  int? discount;
  StoreModel? store;
  String? image;
  String? type;
  List<String>? sizes;
  String? targetGroup;
  List<String>? colors;
  String? material;
  int itemCount;
  int? itemId; // Added item_id field

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
    this.itemCount = 0,
    this.itemId, // Initialize item_id
  });

  ClothingItemModel copyWith({
    int? id,
    String? name,
    double? price,
    int? discount,
    StoreModel? store,
    String? image,
    String? type,
    List<String>? sizes,
    String? targetGroup,
    List<String>? colors,
    String? material,
    int? itemCount,
    int? itemId, // Added item_id to copyWith
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
      targetGroup: targetGroup ?? this.targetGroup,
      colors: colors ?? this.colors,
      material: material ?? this.material,
      itemCount: itemCount ?? this.itemCount,
      itemId: itemId ?? this.itemId, // Copy item_id
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
      'itemCount': itemCount,
      'item_id': itemId, // Map item_id
    };
  }

  factory ClothingItemModel.fromMap(Map<String, dynamic> map) {
    return ClothingItemModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      price: map['price']?.toDouble(),
      discount: map['discount'] != null ? map['discount'] as int : null,
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
      itemCount: map['itemCount'] != null ? map['itemCount'] as int : 0,
      itemId:
          map['item_id'] != null ? map['item_id'] as int : null, // Map item_id
    );
  }

  @override
  String toString() {
    return 'ClothingItemModel(id: $id, name: $name, price: $price, discount: $discount, store: $store, image: $image, type: $type, sizes: $sizes, target_group: $targetGroup, colors: $colors, material: $material, itemCount: $itemCount, item_id: $itemId)';
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
        other.targetGroup == targetGroup &&
        other.colors == colors &&
        other.material == material &&
        other.itemCount == itemCount &&
        other.itemId == itemId; // Compare item_id
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
        material.hashCode ^
        itemCount.hashCode ^
        itemId.hashCode; // Hash item_id
  }
}
