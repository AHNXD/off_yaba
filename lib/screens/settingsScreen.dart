import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/screens/splashScreen.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return ListView(physics: const NeverScrollableScrollPhysics(), children: [
      Container(
          padding: const EdgeInsets.only(left: 32, right: 32, bottom: 16),
          margin: const EdgeInsets.only(left: 8, right: 8),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
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
              const SizedBox(
                height: 8,
              ),
            ],
          )),
      SizedBox(
        height: MediaQuery.sizeOf(context).height,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: ListView(
            primary: true,
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(lang == "ar"
                            ? "تعديل الملف الشخصي"
                            : "Edit Profile"),
                        const Icon(Icons.edit),
                      ],
                    ),
                  )),
              ElevatedButton(
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(lang == "ar" ? "المفضلة" : "Favorites"),
                        const Icon(Icons.favorite),
                      ],
                    ),
                  )),
              ElevatedButton(
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(lang == "ar" ? "الخصوصية" : "Privacy"),
                        const Icon(Icons.privacy_tip),
                      ],
                    ),
                  )),
              ElevatedButton(
                  onPressed: () {
                    lang = lang == "ar" ? "en" : "ar";
                    setState(() {});
                    Navigator.pop(context);
                    Navigator.of(context)
                        .push(goRoute(x: const SplashScreen()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(lang == "ar" ? "اللغة" : "Language"),
                        const Icon(Icons.language),
                      ],
                    ),
                  )),
              ElevatedButton(
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(lang == "ar" ? "حول التطبيق" : "About"),
                        const Icon(Icons.info),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      )
    ]);
  }
}
