import 'package:dio/dio.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/models/clothing_item_model.dart';
import 'package:off_yaba/services/network/api_service.dart';

class ClothingService {
  static Future<List<ClothingItemModel>> getClothingItems() async {
    try {
      Response? response = is_guest
          ? await DioHelper.getData(path: 'clothing-items')
          : await DioHelper.getAuthorizedData(path: 'clothing-items');
      List<dynamic> dynamicItems = response!.data["data"]["clothes"];
      List<ClothingItemModel> items = dynamicItems
          .map(
            (e) => ClothingItemModel.fromMap(e),
          )
          .toList();
      return items;
    } on DioException {
      rethrow;
    }
  }

  static Future<List<ClothingItemModel>> getClothingItemsByStore(
      int storeId) async {
    try {
      Response? response = is_guest
          ? await DioHelper.getData(
              path: 'clothing-items', queryParameters: {"store_id": storeId})
          : await DioHelper.getAuthorizedData(
              path: 'clothing-items', queryParameters: {"store_id": storeId});
      List<dynamic> dynamicItems = response!.data["data"]["clothes"];
      List<ClothingItemModel> items = dynamicItems
          .map(
            (e) => ClothingItemModel.fromMap(e),
          )
          .toList();
      return items;
    } on DioException {
      rethrow;
    }
  }
}
