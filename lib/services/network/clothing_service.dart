import 'package:dio/dio.dart';
import 'package:off_yaba/models/clothing_item_model.dart';
import 'package:off_yaba/services/network/api_service.dart';

class ClothingService {
  static Future<List<ClothingItemModel>> getClothingItems() async {
    try {
      Response? response =
          await DioHelper.getAuthorizedData(path: 'clothing-items');
      List<dynamic> dynamicItems = response!.data["data"]["clothes"];
      List<ClothingItemModel> items = dynamicItems
          .map(
            (e) => ClothingItemModel.fromMap(e),
          )
          .toList();
      return items;
    } on DioException catch (e) {
      rethrow;
    }
  }

  static Future<List<ClothingItemModel>> getClothingItemsByStore(
      int storeId) async {
    try {
      Response? response = await DioHelper.getAuthorizedData(
          path: 'clothing-items', queryParameters: {"store_id": storeId});
      List<dynamic> dynamicItems = response!.data["data"]["clothes"];
      List<ClothingItemModel> items = dynamicItems
          .map(
            (e) => ClothingItemModel.fromMap(e),
          )
          .toList();
      return items;
    } on DioException catch (e) {
      rethrow;
    }
  }
}
