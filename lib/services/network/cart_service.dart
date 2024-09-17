import 'package:dio/dio.dart';
import 'package:off_yaba/models/cart_model.dart';
import 'package:off_yaba/services/network/api_service.dart';

class CartService {
  static Future<CartModel> getCart() async {
    Response? response = await DioHelper.getAuthorizedData(path: 'cart');
    print("cartREsponse: ${response!.data}");
    return CartModel.fromJson(response.data['data']);
  }

  static Future<void> addItemToCart(
      {required int itemId, int itemCount = 1, String? extra_notes}) async {
    try {
      var response = await DioHelper.postAuthorized(path: '/cart/add', data: {
        "item_id": itemId,
        "quantity": itemCount,
        "extra_notes": extra_notes ?? ' ',
      });
    } on DioException catch (e) {}
  }

  static Future<void> deleteItem({required int itemId}) async {
    await DioHelper.deleteAuthorized(path: '/cart/remove/$itemId');
  }

  static Future<void> clearCart() async {
    await DioHelper.deleteAuthorized(path: '/cart/clear');
  }

  static Future<void> checkoutCart({
    required String location,
    required String phone,
  }) async {
    await DioHelper.postAuthorized(path: "/cart/checkout", data: {
      "location": location,
      "phone": phone,
    });
  }
}
