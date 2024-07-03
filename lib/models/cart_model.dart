import 'package:off_yaba/models/store_offer_model.dart';

class CartModel {
  int? id;
  int? userId;
  int? storeId;
  int? total;
  String? createdAt;
  String? updatedAt;
  List<Items>? items;

  CartModel(
      {this.id,
      this.userId,
      this.storeId,
      this.total,
      this.createdAt,
      this.updatedAt,
      this.items});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    storeId = json['store_id'];
    total = json['total'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['store_id'] = storeId;
    data['total'] = total;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int? id;
  int? cartId;
  int? itemId;
  int? quantity;
  String? createdAt;
  String? updatedAt;
  StoreOfferModel? item;

  Items(
      {this.id,
      this.cartId,
      this.itemId,
      this.quantity,
      this.createdAt,
      this.updatedAt,
      this.item});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cartId = json['cart_id'];
    itemId = json['item_id'];
    quantity = json['quantity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    item = json['item'] != null ? StoreOfferModel.fromMap(json['item']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cart_id'] = cartId;
    data['item_id'] = itemId;
    data['quantity'] = quantity;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (item != null) {
      data['item'] = item!.toJson();
    }
    return data;
  }
}
