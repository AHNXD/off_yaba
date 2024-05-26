import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/models/section_model.dart';
import 'package:off_yaba/screens/show_category_screen.dart';
import 'package:off_yaba/services/network/sections_service.dart';

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
              Container(
                  padding:
                      const EdgeInsets.only(left: 32, right: 32, bottom: 16),
                  margin: const EdgeInsets.only(left: 8, right: 8),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: appColor,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50))),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(children: [
                          TextSpan(
                              text: "Off ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  shadows: [])),
                          TextSpan(
                              text: "Yaba",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold))
                        ]),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 30,
                          )),
                    ],
                  )),
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
                                        Navigator.pushNamed(context,
                                            ShowCategoryScreen.routeName,
                                            arguments: {
                                              "sec_id": sections[index].id
                                            });
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 8),
                                        decoration: BoxDecoration(
                                            image: const DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/categories.jpg"),
                                              fit: BoxFit.fill,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.3),
                                                spreadRadius: 5,
                                                blurRadius: 20,
                                                offset: const Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                            color: appColor,
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color:
                                                  Colors.grey.withOpacity(0.6)),
                                          child: Center(
                                              child: Text(
                                            // sections[index].name!,
                                            sectionNames[index],
                                            style: const TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                                fontFamily:
                                                    "cocon-next-arabic"),
                                          )),
                                        ),
                                      ),
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
