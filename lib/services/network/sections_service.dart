import 'package:dio/dio.dart';
import 'package:off_yaba/models/section_model.dart';
import 'package:off_yaba/services/network/apiService.dart';

class SectionsService {
  static Future<List<SectionModel>> getSections() async {
    try {
      Response? response = await DioHelper.getAuthorizedData(path: 'sections');
      List<dynamic> dynamicSections = response!.data["data"];
      List<SectionModel> sections =
          dynamicSections.map((e) => SectionModel.fromMap(e)).toList();
      return sections;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<SectionModel> getSectionById({required int id}) async {
    try {
      Response? response =
          await DioHelper.getAuthorizedData(path: 'sections/$id');
      SectionModel section = SectionModel.fromMap(response!.data["data"]);
      return section;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
