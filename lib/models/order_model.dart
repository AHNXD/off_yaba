import 'package:off_yaba/services/network/api_service.dart';
import 'order_status.dart'; // Import the enum file

class OrderModel {
  int? id;
  int? userId;
  int? storeId;
  int? total;
  String? createdAt;
  String? updatedAt;
  OrderStatus? status; // Updated to use OrderStatus enum
  String? location;
  String? phone;
  Store? store;
  List<Items>? items;

  OrderModel(
      {this.id,
      this.userId,
      this.storeId,
      this.total,
      this.createdAt,
      this.updatedAt,
      this.status,
      this.location,
      this.phone,
      this.store,
      this.items});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    storeId = json['store_id'];
    total = json['total'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'] != null
        ? getOrderStatusFromString(json['status'])
        : null; // Update fromJson
    location = json['location'];
    phone = json['phone'];
    store = json['store'] != null ? Store.fromJson(json['store']) : null;
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
    data['status'] =
        status != null ? getOrderStatusString(status!) : null; // Update toJson
    data['location'] = location;
    data['phone'] = phone;
    if (store != null) {
      data['store'] = store!.toJson();
    }
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Store {
  int? id;
  int? sectionId;
  String? name;
  String? image;
  String? address;
  String? latitude;
  String? longitude;
  int? discount;
  int? score;
  String? createdAt;
  String? updatedAt;

  Store(
      {this.id,
      this.sectionId,
      this.name,
      this.image,
      this.address,
      this.latitude,
      this.longitude,
      this.discount,
      this.score,
      this.createdAt,
      this.updatedAt});

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sectionId = json['section_id'];
    name = json['name'];
    image = "${DioHelper.baseUrl}image?path=${json['image']}";
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    discount = json['discount'];
    score = json['score'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['section_id'] = sectionId;
    data['name'] = name;
    data['image'] = image;
    data['address'] = address;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['discount'] = discount;
    data['score'] = score;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Items {
  int? id;
  int? orderId;
  int? itemId;
  int? quantity;
  int? price;
  String? createdAt;
  String? updatedAt;
  Item? item;

  Items(
      {this.id,
      this.orderId,
      this.itemId,
      this.quantity,
      this.price,
      this.createdAt,
      this.updatedAt,
      this.item});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    itemId = json['item_id'];
    quantity = json['quantity'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    item = json['item'] != null ? Item.fromJson(json['item']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    data['item_id'] = itemId;
    data['quantity'] = quantity;
    data['price'] = price;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (item != null) {
      data['item'] = item!.toJson();
    }
    return data;
  }
}

class Item {
  int? id;
  int? storeId;
  String? title;
  String? body;
  int? discount;
  String? image;
  String? createdAt;
  String? updatedAt;
  int? price;

  Item(
      {this.id,
      this.storeId,
      this.title,
      this.body,
      this.discount,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.price});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    title = json['title'];
    body = json['body'];
    discount = json['discount'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['store_id'] = storeId;
    data['title'] = title;
    data['body'] = body;
    data['discount'] = discount;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['price'] = price;
    return data;
  }
}
