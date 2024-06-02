import 'package:dio/dio.dart';
import 'package:off_yaba/models/clothing_item_model.dart';
import 'package:off_yaba/services/network/api_service.dart';

class ClothingService {
  static Future<List<ClothingItemModel>> getClothingItems() async {
    try {
      Response? response =
          await DioHelper.getAuthorizedData(path: 'clothing-items');
      print(response);
      List<dynamic> dynamicItems = response!.data["data"];
      List<ClothingItemModel> items = dynamicItems
          .map(
            (e) => ClothingItemModel.fromMap(e),
          )
          .toList();
      return items;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
