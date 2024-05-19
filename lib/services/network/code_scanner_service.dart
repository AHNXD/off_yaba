import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:off_yaba/models/code_scanner_model.dart';
import 'package:off_yaba/services/network/apiService.dart';

class CodeScannerService {
  static Future<void> scanUserCode({required String code}) async {
    try {
      Response? response = await DioHelper.postAuthorized(
          path: "qr-code/user-scan", data: {"code": code});
      print(response!.data);
    } on DioException catch (e) {
      print(e.response!.data);
      rethrow;
    }
  }

  static Future<void> scanEmployeeCode({required String code}) async {
    try {
      Response? response = await DioHelper.postAuthorized(
          path: "employee/qr-code/employee-scan", data: {"code": code});
      print(response!.data);
    } on DioException catch (e) {
      print("status Code ${e.response?.statusCode}");
      print(e.response?.data);
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
}
