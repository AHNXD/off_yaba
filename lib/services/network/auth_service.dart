import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

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
      log("+964$phone");
      await DioHelper.postData(path: 'user/register', data: {
        "phone_number": "+964$phone",
        "name": name,
      });

      return const Left(null);
    } on DioException catch (e) {
      int statusCode = e.response!.statusCode!;
      if (statusCode == 400) {
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
      await CacheHelper.setString(
          key: "user", value: json.encode(response.data["data"]));
      return Left(user);
    } on DioException catch (e) {
      if (e.response!.statusCode == 400) {
        return Right(ApiFailure(
            message: "الرمز المدخل خاطء", statusCode: e.response!.statusCode));
      }
      return Right(ApiFailure(
          message: "لقد حدث خطأ ما يرجى المحاولة لاحقا", statusCode: 500));
    }
  }

  static Future<Either<void, ApiFailure>> loginUser(
      {required String phoneNumber}) async {
    try {
      await DioHelper.postData(path: 'user/login', data: {
        "phone_number": "+964$phoneNumber",
      });

      return const Left(null);
    } on DioException catch (e) {
      return Right(ApiFailure(
          message: e.response!.data["message"],
          statusCode: e.response!.statusCode));
    }
  }

  static Future<Either<void, ApiFailure>> loginEmployee(
      {required String phoneNumber}) async {
    try {
      await DioHelper.postData(path: 'employee/login', data: {
        "phone_number": phoneNumber,
      });
      return const Left(null);
    } on DioException catch (e) {
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
      await CacheHelper.setString(key: "userType", value: "user");
      await CacheHelper.setString(
          key: "user", value: json.encode(response.data["data"]));
      return Left(user);
    } on DioException catch (e) {
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
      await CacheHelper.setString(key: "userType", value: "emp");
      return const Left(null);
    } on DioException catch (e) {
      return Right(ApiFailure(
          message: e.response!.data["message"],
          statusCode: e.response!.statusCode));
    }
  }

  static Future<void> logoutUser() async {
    // DioHelper.postAuthorized(path: '/user/logout')
    //     .then((res) async => );
    await CacheHelper.clearData();
  }

  static Future<bool> updateUser(Map<String, dynamic> data) async {
    try {
      Response? response =
          await DioHelper.putAuthorized(path: '/user', data: data);
      if (response != null && response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      log('Failed to update user info: ${e.response}');
      return false;
    }
  }

  static Future<bool> deleteUser() async {
    try {
      Response? response =
          await DioHelper.deleteAuthorized(path: '/user/delete');
      if (response != null && response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      log('Failed to delete the user: ${e.response}');
      return false;
    }
  }

  static Future<bool> uploadUserProfileImage(MultipartFile image) async {
    try {
      FormData formData = FormData.fromMap({
        "image": image,
      });

      Response? response = await DioHelper.postAuthorized(
        path: "/image",
        data: formData,
      );
      var user = UserModel.fromJson(CacheHelper.getData(key: "user"));
      user.image = response!.data["data"];
      await CacheHelper.setString(
          key: "user", value: json.encode(user.toMap()));
      return true;
    } on DioException {
      return false;
    }
  }

  static Future<bool> deleteImage() async {
    try {
      await DioHelper.deleteAuthorized(path: "/image");

      var userJson = CacheHelper.getData(key: "user");
      if (userJson == null) {
        return false;
      }

      var user = UserModel.fromJson(userJson);
      user.image = null;

      await CacheHelper.setString(
          key: "user", value: json.encode(user.toMap()));

      return true;
    } on DioException {
      return false;
    }
  }
}
