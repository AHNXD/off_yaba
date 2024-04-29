import 'dart:developer';

import 'package:dio/dio.dart';
// import 'package:off_yaba/services/cache_helper';

class DioHelper {
  static Dio? dio;
  static String? token;
  static String baseUrl = "https://medhouse40.000webhostapp.com/api/";
  static init() async {
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
    ));
    token =
        "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIyIiwianRpIjoiNjA5ZDU4NjhjOTJjZGFjN2NiOGQwODVjMDg0Y2NmMWYzMzI2NjAxOTNkZDFhZjk3YjY3OGVjZDkzYjRiZmIyYmFjMGYxYzA4OWFkYjc5ZDUiLCJpYXQiOjE3MTMxMjAxMDMuODYxNjE2LCJuYmYiOjE3MTMxMjAxMDMuODYxNjE5LCJleHAiOjE3NDQ2NTYxMDMuODQ5MDYxLCJzdWIiOiIxIiwic2NvcGVzIjpbInVzZXIiXX0.iX-izXBWrCloT61jLOiNkE7s4q41FOou-09Q9tkGRUI2A78Z0ONfl_RuVACDs3eaa3aw9k3FbqV9fmhlE1IbJxbXqUFB3NgYeMLSjrhyq3WgJSHASf0nGZJO2b1PEFJ_Z3_qVY_JB4EExA2f6r2lH3X9TLoa6Xe8Zm2SpyiOf6Hzk_jfjq8SWzDw4__mX8g3FEtQpBIPJ5Tk26pavtbQI3No4KNH4jHYz5I1i3ZQo1xps8X3eMYOm2ASikV_2v_vZDYBMZptASP9eDIWbpKZjbBGzaExAIBYlQjryxFv2l757Jixq8qBuXunukuu2zZbYLKRTjdk6XJ2usPgGmy6-qf9xrJ_8YK4z05jMR_PB83tAFCmcJdm6Nrom_VRle3HE1mYuDd4RrSydFGRcod99Lu67ZxsM7sIxIxWHeRM2MHMldO0vrsfTrpOtYVxxkAxZrTt9TN9Bkl8DR6gg8rSxt59DH7dYhs1KTExxMAQY_joyXm28F1oZsEy2NRP5YHO_-pMz84iWvWVrm8BeK5FXGO05k5G9ilRPyRai4mAE7Y4dhwgBrRJpf7wHsPMpUbW54HFnX5-J31G4traMyiYRVT6QJWOP17YEQ1HqayY05qO5Xb2Lv_PZSXY8Zzu-ukmUQIX0k5kg85ZPm4_edIeR9zzWGoHqmXM9UFN0H9Ws1k";
    // token = await CacheHelper.getData(key: 'token');
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
    headers['Authorization'] = token;
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
    headers['Authorization'] = token;

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
    headers['authorization'] = token;

    return await dio?.delete(path,
        queryParameters: queryParameters, options: Options(headers: headers));
  }
}
