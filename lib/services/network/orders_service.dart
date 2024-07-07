import 'package:dio/dio.dart';
import 'package:off_yaba/models/order_model.dart';
import 'package:off_yaba/services/network/api_service.dart';

class OrdersService {
  static Future<List<OrderModel>?> getUserOrders() async {
    Response? response = await DioHelper.getAuthorizedData(path: '/orders');
    List<dynamic> dynamicData = response!.data['data'];
    List<OrderModel> orders =
        dynamicData.map((e) => OrderModel.fromJson(e)).toList();

    return orders;
  }

  static Future<List<OrderModel>?> getStoreOrders() async {
    try {
      Response? response =
          await DioHelper.getAuthorizedData(path: "/employee/orders");
      List<dynamic> dynamicData = response!.data['data'];
      print(dynamicData);
      List<OrderModel> orders =
          dynamicData.map((e) => OrderModel.fromJson(e)).toList();
      print(orders);
      return orders;
    } on DioException catch (e) {
      print(e.response!.data);
    }
    return null;
  }

  static Future<void> acceptOrder({required int orderId}) async {
    try {
      await DioHelper.postAuthorized(path: "/employee/orders/$orderId/accept");
    } on DioException catch (e) {
      print(e.response!.data);
    }
  }

  static Future<void> cancelOrder({required int orderId}) async {
    await DioHelper.postAuthorized(path: "/employee/orders/$orderId/cancel");
  }

  static Future<void> deliverOrder({required int orderId}) async {
    await DioHelper.postAuthorized(path: "/employee/orders/$orderId/deliver");
  }
}
