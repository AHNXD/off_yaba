import 'package:dio/dio.dart';
import 'package:off_yaba/services/cache_helper.dart';
// import 'package:off_yaba/services/cache_helper';

class DioHelper {
  static Dio? dio;
  // static String? token;
  // static String baseUrl = "https://3c5d-169-150-218-138.ngrok-free.app/api/";
  static String baseUrl = "http://5he.b12.mytemp.website/api/";
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
    headers['authorization'] = await CacheHelper.getData(key: 'token');
    headers["Accept"] = "application/json";
    return await dio?.delete(path,
        queryParameters: queryParameters, options: Options(headers: headers));
  }
}
