import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:off_yaba/models/store_details_model.dart';
import 'package:off_yaba/models/store_model.dart';
import 'package:off_yaba/models/store_offer_model.dart';
import 'package:off_yaba/services/location_service.dart';
import 'package:off_yaba/services/network/api_service.dart';

class StoreService {
  static Future<List<StoreModel>> getStoresByCoords({
    required int page,
    required int longitude,
    required int latitude,
  }) async {
    try {
      Position? position;
      //TODO: Move Location to splash
      if (await LocationService.checkGps()) {
        position = await LocationService.getLocation();
      }

      Response? response =
          await DioHelper.getAuthorizedData(path: 'stores', queryParameters: {
        "page": page.toString(),
        "longitude": position != null ? position.longitude : longitude,
        "latitude": position != null ? position.latitude : latitude,
      });

      List<dynamic> dynamicStores = response!.data["data"]["stores"];

      List<StoreModel> stores =
          dynamicStores.map((e) => StoreModel.fromMap(e)).toList();
      return stores;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<List<StoreModel>> getStoresBySection(
      {required int sectionId}) async {
    try {
      Response? response =
          await DioHelper.getAuthorizedData(path: 'stores', queryParameters: {
        "section_ids": sectionId,
      });

      List<dynamic> dynamicStores = response!.data["data"]["stores"];

      List<StoreModel> stores =
          dynamicStores.map((e) => StoreModel.fromMap(e)).toList();
      return stores;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<List<StoreModel>> getStoresWithBestOffers() async {
    try {
      Response? response =
          await DioHelper.getAuthorizedData(path: 'stores', queryParameters: {
        "page": 1,
        "suggestion": true,
      });
      List<dynamic> dynamicStores = response!.data["data"]["stores"];

      List<StoreModel> stores =
          dynamicStores.map((e) => StoreModel.fromMap(e)).toList();
      return stores;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<List<StoreOfferModel>> getStoreOffers(
      {required int storeId}) async {
    try {
      Response? response =
          await DioHelper.getAuthorizedData(path: 'offers/$storeId');

      List<dynamic> dynamicOffers = response!.data["data"];

      List<StoreOfferModel> offers =
          dynamicOffers.map((e) => StoreOfferModel.fromMap(e)).toList();
      return offers;
    } on DioException catch (e) {
      print(e.response!.data);
      rethrow;
    }
  }

  static Future<StoreDetailsModel> getStoreDetails(
      {required int storeId}) async {
    try {
      Position? position;
      //TODO: Move Location to splash
      if (await LocationService.checkGps()) {
        position = await LocationService.getLocation();
      }

      Response? response = await DioHelper.getAuthorizedData(
          path: 'stores/$storeId',
          queryParameters: {
            "longitude": position?.longitude,
            "latitude": position?.latitude,
          });
      return StoreDetailsModel.fromMap(response!.data["data"]);
    } on DioException catch (e) {
      rethrow;
    }
  }
}
