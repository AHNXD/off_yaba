import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/screens/auth_screen.dart';
import 'package:off_yaba/screens/reports_screen.dart';
import 'package:off_yaba/screens/splash_screen.dart';
import 'package:off_yaba/screens/subscriptions_screen.dart';
import 'package:off_yaba/services/network/auth_service.dart';
import 'package:off_yaba/widgets/custom_appbar.dart';
import 'package:off_yaba/widgets/settings_button.dart';
import 'package:off_yaba/widgets/user_info_card.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(physics: const NeverScrollableScrollPhysics(), children: [
      const CustomAppBar(
        isBackable: false,
      ),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InfoCard(title: "فادي"),
                  SizedBox(
                    height: 7.5,
                  ),
                  InfoCard(title: "09xxxxxxxx"),
                  SizedBox(
                    height: 7.5,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.1,
            ),
            Container(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: appColor, width: 5)),
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.18,
                backgroundColor: Colors.grey,
                child: ClipOval(
                  child: Image.asset(
                    'assets/icon.jpg',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
              SettingsButton(
                title: "تعديل الملف الشخصي",
                icon: const Icon(Icons.edit),
                onPressed: () {},
              ),
              SettingsButton(
                title: "الاشتراكات",
                icon: const Icon(Icons.attach_money),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(SubscriptionsScreen.routeName);
                },
              ),
              SettingsButton(
                title: "المفضلة",
                icon: const Icon(Icons.favorite),
                onPressed: () {},
              ),
              SettingsButton(
                title: "الخصوصية",
                icon: const Icon(Icons.privacy_tip),
                onPressed: () {},
              ),
              SettingsButton(
                title: "حول التطبيق",
                icon: const Icon(Icons.info),
                onPressed: () {},
              ),
              SettingsButton(
                title: 'الشكاوي',
                icon: const Icon(Icons.message),
                onPressed: () {
                  Navigator.of(context).pushNamed(ReportsScreen.routeName);
                },
              ),
              SettingsButton(
                title: 'تسجيل الخروج',
                icon: const Icon(Icons.logout),
                onPressed: () {
                  AuthApiService.logoutUser().then((value) =>
                      Navigator.of(context)
                          .pushReplacementNamed(AuthScreen.routeName));
                },
              ),
            ],
          ),
        ),
      )
    ]);
  }
}
