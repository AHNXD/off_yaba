import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:off_yaba/services/cache_helper.dart';
// import 'package:off_yaba/services/cache_helper';

class DioHelper {
  static Dio? dio;
  // static String? token;
  // static String baseUrl = "https://3c5d-169-150-218-138.ngrok-free.app/api/";
  static String baseUrl = "http://rnw.f0d.mytemp.website/api/";
  static String token =
      "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiODI5ZDhjOWY3MTlkYjQzOGVkNTM0Mzk5YWMwY2YzOGZmODAzY2Q1YjUzNWExODBkYTJkNjFhNDAxYTcwZTQ2YjI5M2MyYzJlNDY0OTlmMGUiLCJpYXQiOjE3MjAwMzQ0NTEuNDU4NzM3LCJuYmYiOjE3MjAwMzQ0NTEuNDU4NzM5LCJleHAiOjE3NTE1NzA0NTEuNDUyODM4LCJzdWIiOiI0Iiwic2NvcGVzIjpbInVzZXIiXX0.rXJDfrBWVPu8G6PlZjmqF4N-eqD9GwmsX0UVOtcu7B6XI8_sGwJGeXC8JT6VhnaSKS-Q5USiV3w-_MIT6ORwYOTO7tWm8y4lJBWDmr_TWoEohLw7F9kp-Hfunjr4Zip2riLPGSkatwFyFrnlpEmgL-4MqG5Y_bpF3IkHx-Qw9SgPq4DIdVEIIAuuAdsXvBDAgb2UBSdA7ncxFqLMP_KPPzJU32ZC403JaE5JxyR_zFJ_spl6P6NiMCdnjIOeX2SegGsUcWleRdZTZLS51aUegQqP7Bo0vupS0mHUiWJP0AsXfL91vvMsfddoW91TvnFjkbLVekwlK4RLa5Kw5cLKTMWn5CuE22nhvLVMj_0Bpo24Ww2jTSt4MzNba5sOAMY5dXX0V5AF6MpvpjwqsUPq6vhClo4mhfut0WMFtU-vRQFJ1gebXh4-lGB02ddaRg3NSO5YCCvb-98JnC18W6FVOObmWd3umMlx9rnXwW8NcToLGJshZzwQbWC0QqYzJejU1b3ISBnQJL7UG3o4WueTFcOKriUDC_IfhbZ2cXcJuucNx42ThAbJp6wKkFuM2B1FuUGD_nXpRKsE8zKsHHTaDyrMunpuNyyqi4Vpdgw3s6LqlTQM5aB4T_XneT16rr6GIni9OVBrStElhgBPElPLxJFO8xfh1zQkh0v6sbuHHSk";
  static init() async {
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
    ));
  }

  static Future<Response?> getData(
      {required String path,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    return await dio?.get(path,
        queryParameters: queryParameters, options: Options(headers: headers));
  }

  static Future<Response?> postData(
      {required String path,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers,
      required dynamic data}) async {
    headers = {};
    headers["Accept"] = "application/json";
    return await dio?.post(path,
        queryParameters: queryParameters,
        data: data,
        options: Options(headers: headers));
  }

  static Future<Response?> patchData(
      {required String path,
      Map<String, dynamic>? queryParameters,
      required dynamic data}) async {
    return await dio?.patch(path, queryParameters: queryParameters, data: data);
  }

  static Future<Response?> deleteData({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    return await dio?.delete(path,
        queryParameters: queryParameters, options: Options(headers: headers));
  }

  static Future<Response?> getAuthorizedData(
      {required String path,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? additionalHeaders}) async {
    Map<String, dynamic> headers = {};
    if (additionalHeaders != null) {
      headers = {...additionalHeaders};
    }
    // headers['Authorization'] = await CacheHelper.getData(key: 'token');
    headers['Authorization'] = token;

    headers["Accept"] = "application/json";
    return await dio?.get(path,
        queryParameters: queryParameters, options: Options(headers: headers));
  }

  static Future<Response?> postAuthorized(
      {required String path,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? additionalHeaders,
      dynamic responseType,
      dynamic data}) async {
    Map<String, dynamic> headers = {};
    if (additionalHeaders != null) {
      headers = {...additionalHeaders};
    }
    // headers['Authorization'] = await CacheHelper.getData(key: 'token');
    headers['Authorization'] = token;
    headers["Accept"] = "application/json";

    return await dio?.post(path,
        queryParameters: queryParameters,
        data: data,
        options: Options(headers: headers, responseType: responseType));
  }

  static Future<Response?> deleteAuthorized({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? additionalHeaders,
  }) async {
    Map<String, dynamic> headers = {};
    if (additionalHeaders != null) {
      headers = {...additionalHeaders};
    }
    // headers['Authorization'] = await CacheHelper.getData(key: 'token');
    headers['Authorization'] = token;
    headers["Accept"] = "application/json";
    return await dio?.delete(path,
        queryParameters: queryParameters, options: Options(headers: headers));
  }
}
