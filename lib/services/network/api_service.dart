import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:off_yaba/services/cache_helper.dart';
// import 'package:off_yaba/services/cache_helper';

class DioHelper {
  static Dio? dio;
  // static String? token;
  // static String baseUrl = "https://3c5d-169-150-218-138.ngrok-free.app/api/";
  static String baseUrl = "http://rnw.f0d.mytemp.website/api/";
  // static String token =
  //     "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiYzVkOWI0MjA5NWY4NWFjNDc2ZThmZDUxMWI2MWU0ZjRhMjcyMTY4ODgxZTkzZjlmNDNlMmU3ZjFhNTU1N2UxZWY1ZTdlNjFiODA0ZWVmMjMiLCJpYXQiOjE3MTc2OTEwNDQuNDYyMDY1LCJuYmYiOjE3MTc2OTEwNDQuNDYyMDY2LCJleHAiOjE3NDkyMjcwNDQuNDU4ODUsInN1YiI6IjQiLCJzY29wZXMiOlsidXNlciJdfQ.YQRhIqC_ruIIhQEL5UbzEC0sjtPiTw-jby1SqIH_u3-wJ_RJjwTKJzwYbkYEgOIgjBRDiFJ5HslE14cuwLd1p31qOYObJVc1-fnvqchrZojht8Ptx2nxgX68_iclYqhCPO9aHbCcVTK5v0uzOvoWSCy_Fcv8ZsgORBP6uEmaQpwu-ACbMdt7vLR6-KhXe_bidyAAcDWecRreiM9Nc-7br_KQMPufDE-6kIUsyqkUjz-Y30XFIXS3dhvSrh3k6CZmn-PlTdiGLv0tV9l-B6JZWMy-KBR0AybCUIGa3YL7yeeb6a16DNgLfDfTKZ9zR3H9EYoWKNUk-MlIQwEyw0vCrpOHm33YJlkaCrwZg2sgVsb-aYGBYIaeotye2aBhX1MrCBfwbrFeUuww3mzWR-ELApc4rGymHxMpnciUknW-QTFbV6pN80WL32ITCSmDvx5oCBL_M22rElWGqECunTyn6KCtOHP_NN6wdDd_baJNqLfZSuX1emjqbl5qNvb71kMIMsuDv181-d441JCldntF-T5p6faakW3fC6Pb6ZaOoRAqBLHJAmpwM2EHejDcfCHCo-2iKLFQurvw95jx3IvzoL9z3_j0CNRmZu_m2mqHPsrN0SPWHNagTD84pw3XwrRcas50_-85rAD27Z0JClEOVl0SVS9VZQKl0OLGsJWb8uk";
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
    headers['Authorization'] = await CacheHelper.getData(key: 'token');
    // headers['Authorization'] = token;

    headers["Accept"] = "application/json";
    log(headers["Authorization"]);
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
