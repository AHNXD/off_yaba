import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/models/store_model.dart';

import 'package:off_yaba/services/network/stores_service.dart';
import 'package:off_yaba/widgets/store_card.dart';

class ShowCategoryScreen extends StatefulWidget {
  static const routeName = '/showCategory';
  const ShowCategoryScreen({super.key});

  @override
  State<ShowCategoryScreen> createState() => _ShowCategoryScreenState();
}

class _ShowCategoryScreenState extends State<ShowCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    int id = arguments['sec_id'];
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
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 30,
                          )),
                      const Spacer(
                        flex: 1,
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
                      const Spacer(
                        flex: 1,
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                    ],
                  )),
              Expanded(
                child: SizedBox(
                  child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: FutureBuilder(
                          future:
                              StoreService.getStoresBySection(sectionId: id),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data!.isEmpty) {
                                return const Center(
                                  child:
                                      Text("لا يوجد مشتركين بهذا القسم بعد."),
                                );
                              }
                              List<StoreModel> stores = snapshot.data!;
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: stores.length,
                                  itemBuilder: (BC, index) {
                                    return StoreCard(store: stores[index]);
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
