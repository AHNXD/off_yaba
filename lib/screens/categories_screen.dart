// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:off_yaba/constant.dart';
import 'package:off_yaba/widgets/custom_appbar.dart';
import 'package:off_yaba/models/category_model.dart';
import 'package:off_yaba/models/section_model.dart';
import 'package:off_yaba/screens/clothes_section.dart';
import 'package:off_yaba/screens/show_category_screen.dart';
import 'package:off_yaba/services/network/sections_service.dart';
import 'package:off_yaba/widgets/custom_search_deleget.dart';

class CategoriesScreen extends StatefulWidget {
  static const routeName = '/category';
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: lang == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const CustomAppBar(
                backArrow: true,
              ),
              Expanded(
                child: SizedBox(
                  child: Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                      ),
                      child: FutureBuilder(
                          future: SectionsService.getSections(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<SectionModel> sections = snapshot.data!;
                              print(sections);
                              //FIXME:
                              List<String> sectionNames = [
                                "المطاعم",
                                "الصيدليات",
                                "المتاجر",
                                "الأحذية",
                                "الملابس"
                              ];
                              return GridView.builder(
                                  shrinkWrap: true,
                                  itemCount: sections.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, // Number of columns
                                    crossAxisSpacing:
                                        10.0, // Spacing between columns
                                    mainAxisSpacing:
                                        10.0, // Spacing between rows
                                    childAspectRatio:
                                        1.0, // Aspect ratio of items
                                  ),
                                  itemBuilder: (BuildContext, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        if (sectionNames[index] == "الملابس") {
                                          Navigator.of(context).pushNamed(
                                              ClothesSectionScreen.routeName);
                                          return;
                                        }
                                        Navigator.pushNamed(context,
                                            ShowCategoryScreen.routeName,
                                            arguments: {
                                              "sec_id": sections[index].id
                                            });
                                      },
                                      child: CategoryModel(
                                          sectionName: sectionNames[index]),
                                    );
                                  });
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          })),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
