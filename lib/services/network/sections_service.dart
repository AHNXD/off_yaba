import 'package:dio/dio.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/models/section_model.dart';
import 'package:off_yaba/services/network/api_service.dart';

class SectionsService {
  static Future<List<SectionModel>> getSections() async {
    try {
      Response? response = is_guest
          ? await DioHelper.getData(path: 'sections')
          : await DioHelper.getAuthorizedData(path: 'sections');
      List<dynamic> dynamicSections = response!.data["data"];
      List<SectionModel> sections =
          dynamicSections.map((e) => SectionModel.fromMap(e)).toList();
      return sections;
    } catch (e) {
      rethrow;
    }
  }

  static Future<SectionModel> getSectionById({required int id}) async {
    try {
      Response? response = is_guest
          ? await DioHelper.getData(path: 'sections/$id')
          : await DioHelper.getAuthorizedData(path: 'sections/$id');
      SectionModel section = SectionModel.fromMap(response!.data["data"]);
      return section;
    } catch (e) {
      rethrow;
    }
  }
}
