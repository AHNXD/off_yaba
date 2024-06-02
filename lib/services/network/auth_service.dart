import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:off_yaba/models/auth_error_model.dart';
import 'package:off_yaba/models/user_model.dart';
import 'package:off_yaba/services/cache_helper.dart';
import 'package:off_yaba/services/network/api_service.dart';

class AuthApiService {
  static Future<Either<void, ApiFailure>> register(
      {required String name, required String phone}) async {
    try {
      log(phone);
      Response? response =
          await DioHelper.postData(path: 'user/register', data: {
        "phone_number": "+964$phone",
        "name": name,
      });

      return const Left(null);
    } on DioException catch (e) {
      print(e);

      int statusCode = e.response!.statusCode!;
      if (e.response!.statusCode == 400) {
        return Right(ApiFailure(
            message: "هذا الحساب مسجل مسبقا", statusCode: statusCode));
      }
      if (statusCode == 422) {
        return Right(
            ApiFailure(message: "هذا الرقم غير صالح", statusCode: statusCode));
      }
      return Right(ApiFailure(
          message: "الرجاء ادخال رقم الجوال", statusCode: statusCode));
    }
  }

  static Future<Either<UserModel, ApiFailure>> verifyRegister(
      {required Map<String, dynamic> data}) async {
    try {
      Response? response =
          await DioHelper.postData(path: "user/register/verify", data: data);
      UserModel user = UserModel.fromMap(response!.data["data"]);
      await CacheHelper.setString(key: "token", value: "Bearer ${user.token!}");
      return Left(user);
    } on DioException catch (e) {
      print(e.response!.data);
      return Right(ApiFailure());
      // if (e.response!.statusCode == 400) {
      //   return Right(ApiFailure(
      //       message: "الرمز المدخل خاطء", statusCode: e.response!.statusCode));
      // }
      // return Right(ApiFailure(
      //     message: "لقد حدث خطأ ما يرجى المحاولة لاحقا", statusCode: 500));
    }
  }

  static Future<Either<void, ApiFailure>> loginUser(
      {required String phoneNumber}) async {
    try {
      log(phoneNumber);
      var response = await DioHelper.postData(path: 'user/login', data: {
        "phone_number": "+964$phoneNumber",
      });

      return const Left(null);
    } on DioException catch (e) {
      print(e.response!.data);
      return Right(ApiFailure(
          message: e.response!.data["message"],
          statusCode: e.response!.statusCode));
    }
  }

  static Future<Either<void, ApiFailure>> loginEmployee(
      {required String phoneNumber}) async {
    try {
      log(phoneNumber);
      Response? response =
          await DioHelper.postData(path: 'employee/login', data: {
        "phone_number": phoneNumber,
      });
      print(response!.data);
      return const Left(null);
    } on DioException catch (e) {
      print(e);
      return Right(ApiFailure(
          message: e.response!.data["message"],
          statusCode: e.response!.statusCode));
    }
  }

  static Future<Either<UserModel, ApiFailure>> verifyUserLogin(
      {required String code, required String phoneNumber}) async {
    try {
      Response? response =
          await DioHelper.postData(path: "user/login/verify", data: {
        "code": code,
        "phone_number": phoneNumber,
      });
      UserModel user = UserModel.fromMap(response!.data["data"]);
      await CacheHelper.setString(key: "token", value: "Bearer ${user.token!}");
      return Left(user);
    } on DioException catch (e) {
      print(e.response!.data);
      return Right(ApiFailure(
          message: e.response!.data["message"],
          statusCode: e.response!.statusCode));
    }
  }

  // TODO: Add emp model and edit the employee screen
  static Future<Either<void, ApiFailure>> verifyEmployeeLogin(
      {required String phoneNumber, required String code}) async {
    try {
      Response? response =
          await DioHelper.postData(path: "employee/login/verify", data: {
        "phone_number": phoneNumber,
        "code": code,
      });
      String token = response!.data["data"]["token"];
      await CacheHelper.setString(key: "token", value: "Bearer $token");
      return const Left(null);
    } on DioException catch (e) {
      print(e.response!.data);
      return Right(ApiFailure(
          message: e.response!.data["message"],
          statusCode: e.response!.statusCode));
    }
  }

// FIXME:
  static Future<void> logoutUser() async {
    await CacheHelper.removeData();
  }
}
