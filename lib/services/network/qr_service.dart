import 'package:dio/dio.dart';
import 'package:off_yaba/models/code_scanner_model.dart';
import 'package:off_yaba/models/coupon_offers_model.dart';
import 'package:off_yaba/services/network/api_service.dart';

class QRService {
  static Future<bool> scanUserCode({required String code}) async {
    try {
      var res = await DioHelper.postAuthorized(
          path: "qr-code/user-scan", data: {"code": code});
      if (res!.data['success']) {
        return true;
      }
      return false;
    } on DioException {
      rethrow;
    }
  }

  static Future<void> scanEmployeeCode({required String code}) async {
    try {
      await DioHelper.postAuthorized(
          path: "employee/qr-code/employee-scan", data: {"code": code});
    } on DioException {
      rethrow;
    }
  }

  static Future<List<CodeScannerModel>> getUserCodes() async {
    try {
      Response? response = await DioHelper.getAuthorizedData(path: 'qr-code');
      List<dynamic> dynamicCodes = response!.data["data"];
      List<CodeScannerModel> qrCodes =
          dynamicCodes.map((e) => CodeScannerModel.fromMap(e)).toList();
      return qrCodes;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<SubscriptionModel>> getSubscriptions() async {
    try {
      Response? response =
          await DioHelper.getAuthorizedData(path: 'off-yaba-offers');
      List<dynamic> dynamicSubs = response!.data["data"];
      List<SubscriptionModel> subs = dynamicSubs
          .map(
            (e) => SubscriptionModel.fromMap(e),
          )
          .toList();
      return subs;
    } on DioException {
      rethrow;
    }
  }
}
