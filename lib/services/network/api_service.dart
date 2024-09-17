import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:off_yaba/services/cache_helper.dart';

class DioHelper {
  static Dio? dio;

  static String baseUrl = "http://rnw.f0d.mytemp.website/api/";
  // static String baseUrl = "http://192.168.1.113:8000/api/";
  // static String token =
  //     // "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMWM1NmZkNDIzNmZkOTQyYjQzMmE0MzdmZmRiZjdiMTYxYmYzYmM0NThhODhkYzQ5MTc5NmFlNTg1ZGE0YzQ2ZThjZDczNDc3Nzg4Zjc1MzkiLCJpYXQiOjE3MjA1NTA2NTcuMTA0Mjk4LCJuYmYiOjE3MjA1NTA2NTcuMTA0MywiZXhwIjoxNzUyMDg2NjU3LjA5MzgyMSwic3ViIjoiMSIsInNjb3BlcyI6WyJlbXBsb3llZSJdfQ.uLigolosccd7o0iYKwqrHcU0oLKv0mbJ-kqagz2loCakCjVWAzVnGOiY0xJr8S0I3YfuGbqWqLmZgFDQEbjd-4FyYyELeI6qh505Jy-IChpiZQL_PtLFewLGoSVMUmsZRqx_F5NkfsNA5l8ibkOrZw9Uzz4kmDd_7HkTJ5fVdDWsIG7aosgQUPBLtG_NUSkTAbTTvapypTVnpsrrBiJgCodY0wMNXiFl55JTv5_UMzpZvzyssgbcfovH0NpD09ssKdPLwIIfvTdPwYCEKBPURz2VrmgdgV5s9vBrXJPIVaGLiIVGHF86wfKHXXy4QGlVnQRcms8X_z38wBYQou5XKr1J0sc3p7Wv2O1HJ466Gvn9ENL4AEq7VUXre1f7A51z-VU_gUrziDhUWyUB1KxZwtR1PHaIFlhrLTpzEXw-yIEuvshrREm9BwgMsabeyBQCdk08-CTSTqBPkDqFMNPLi6QWsjVSZGQ-ShOLdUtfPtaUTPFB4cZQCUr5KR1f8yhp5ECeo_WNUKpehO5DRXpPkA8o7OyjqPFCvbYadIcNUtKZscZOQq8Mw6CnSokTzbHS2cTpN46iE7hbc_ST-Qv1hlIfnNNnJ-ejHgVjE9B2kaAglfMAnBHEJdA7GGID88qR73Qqvs7X4b9tfcQn-9xUEN5-qt3xYBO5-oM9tFbTSSc";
  //     "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNzUwNmJlNTc2MTE0MTM1ODlhMjRmZjkzYzM3Y2UzNmY3NTNjYzY4MDE4YzVhYWI4MDRmNmI2ZmM3Y2M3MmYzYWQ3MmQ4ZmI3ZWRkMGVmZjUiLCJpYXQiOjE3MjIzNjQ3NjguMTQwMzE4LCJuYmYiOjE3MjIzNjQ3NjguMTQwMzE5LCJleHAiOjE3NTM5MDA3NjguMTMzMDQzLCJzdWIiOiI3Iiwic2NvcGVzIjpbInVzZXIiXX0.1v08RbUIe3nNu_rTzxKjyUnzgYYYgF5bGgFa6LZVM6oXJ5JZAuN-n4-bFNOBDkV4Yi9emy4rNeqbjEoiMf9MEqRrajuvUxHYghEBNVCkp2eZzN3TfYdsVJtmv2_8zDIq0P7fkhavPjyPbsPMVPI9NQwbFR-Gf9M7rhwS9b4FEB8gV4qKj1AC0sZRfHGnzramjyv_h05WF2xdniArnI0Aju0cFrD-RpPbLI4ftghNVs_F1a1x0c5KVc7Q8AUvQM3iPpW5ABJjy5oRl7RHaIv0wRz4SdamW97COnLIPEdin6YqE45nElkWrEViobBEz_-aFn4jRoRfxAitsbO2Fa9uC3pUeYyRBLHjCZjpalk8JH-zPGxDZXq30Nxtjr25fpgxtCbuhDkTnI3FWi13JD9uT_U_Kcp9_tDKvI6cSxESPCWOTU8pLQw8IEWbLOIkex4xcTT_V3IXNSePxqx93jWiPWgpVsOpMG19jC6-GPw0lczsH88C9JO70ZztnYX75GUdrjA-FPZgUVOybrvY4_VBHVwhsnDpC65EqJl-JEtT9lmGyWBVzCSwSFz1te5mIaTnZOcjVoWou1GqzS-81_4JbeWr7RMNk3yuDbwd9XA4G6OkQCsNQPI8q1JL_K9XT7DODbnFnS2pgBeVacPxIweNGsqM3ckH6-TxErBxdY4nzKc";
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
    log(await CacheHelper.getData(key: 'token'));
    headers['Authorization'] = await CacheHelper.getData(key: 'token');
    // headers['Authorization'] = token;

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
    headers['Authorization'] = await CacheHelper.getData(key: 'token');
    // headers['Authorization'] = token;
    headers["Accept"] = "application/json";

    return await dio?.post(path,
        queryParameters: queryParameters,
        data: data,
        options: Options(headers: headers, responseType: responseType));
  }

  static Future<Response?> putAuthorized(
      {required String path,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? additionalHeaders,
      dynamic responseType,
      dynamic data}) async {
    Map<String, dynamic> headers = {};
    if (additionalHeaders != null) {
      headers = {...additionalHeaders};
    }
    headers['Authorization'] = await CacheHelper.getData(key: 'token');
    // headers['Authorization'] = token;
    headers["Accept"] = "application/json";

    return await dio?.put(path,
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
    headers['Authorization'] = await CacheHelper.getData(key: 'token');
    // headers['Authorization'] = token;
    headers["Accept"] = "application/json";
    return await dio?.delete(path,
        queryParameters: queryParameters, options: Options(headers: headers));
  }
}
