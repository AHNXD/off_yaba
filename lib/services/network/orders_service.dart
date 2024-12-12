
import 'package:dio/dio.dart';
import 'package:off_yaba/models/order_model.dart';
import 'package:off_yaba/services/network/api_service.dart';

class OrdersService {
  static Future<List<OrderModel>?> getUserOrders() async {
    try {
      Response? response = await DioHelper.getAuthorizedData(path: '/orders');
      List<dynamic> dynamicData = response!.data['data'];
      List<OrderModel> orders =
          dynamicData.map((e) => OrderModel.fromJson(e)).toList();

      return orders;
    } on DioException {
      rethrow;
    }
  }

  static Future<List<OrderModel>?> getStoreOrders() async {
    try {
      Response? response =
          await DioHelper.getAuthorizedData(path: "/employee/orders");
      List<dynamic> dynamicData = response!.data['data'];
      print("dynamicccccccccccccccccC: $dynamicData");
      List<OrderModel> orders =
          dynamicData.map((e) => OrderModel.fromJson(e)).toList();
      return orders;
    } catch (e, stackTrace) {
      print("errorrrrR: $stackTrace");
    }

    return null;
  }

  static Future<void> acceptOrder({required int orderId}) async {
    try {
      var response = await DioHelper.putAuthorized(
          path: "/employee/orders/$orderId/accept");
      print(response!.data);
    } on DioException catch (e, stackTrace) {
      print(stackTrace);
    }
  }

  static Future<void> cancelOrder({required int orderId}) async {
    await DioHelper.putAuthorized(path: "/employee/orders/$orderId/cancel");
  }

  static Future<void> deliverOrder({required int orderId}) async {
    await DioHelper.putAuthorized(path: "/employee/orders/$orderId/deliver");
  }
}
