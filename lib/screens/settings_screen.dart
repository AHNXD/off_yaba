import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/screens/auth_screen.dart';
import 'package:off_yaba/screens/reports_screen.dart';
import 'package:off_yaba/screens/subscriptions_screen.dart';
import 'package:off_yaba/services/network/auth_service.dart';
import 'package:off_yaba/widgets/settings_button.dart';

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
    return Container(
      color: Colors.white,
      child: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.only(bottom: 10),
            height: MediaQuery.of(context).size.height * 0.3,
            width: double.infinity,
            decoration: const BoxDecoration(
                image:
                    DecorationImage(image: AssetImage(bg), fit: BoxFit.cover),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ListTile(
                leading: const CircleAvatar(
                  radius: 45,
                  backgroundImage: NetworkImage(
                      'https://s.yimg.com/ny/api/res/1.2/HWcc_lQHdTbJeABtSI96xg--/YXBwaWQ9aGlnaGxhbmRlcjt3PTY0MDtoPTM2MA--/https://media.zenfs.com/en/Benzinga/b862dc8abb46e0aeb514ca88ec8543a2'),
                ),
                title: Text("حسن علي المنجد",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.white)),
                subtitle: Text('702381928391',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.white)),
              ),
            ),
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
              Navigator.of(context).pushNamed(SubscriptionsScreen.routeName);
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
            title: 'تسجيل الخروج',
            icon: const Icon(Icons.logout),
            onPressed: () {
              AuthApiService.logoutUser().then((value) => Navigator.of(context)
                  .pushReplacementNamed(AuthScreen.routeName));
            },
          ),
        ],
      ),
    );
  }
}

// ListView(physics: const NeverScrollableScrollPhysics(), children: [
//       const CustomAppBar(
//         isBackable: false,
//       ),
//       Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Row(
//           children: [
//             const Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   InfoCard(title: "فادي"),
//                   SizedBox(
//                     height: 7.5,
//                   ),
//                   InfoCard(title: "09xxxxxxxx"),
//                   SizedBox(
//                     height: 7.5,
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               width: MediaQuery.of(context).size.width * 0.1,
//             ),
//             Container(
//               padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
//               decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(color: appColor, width: 5)),
//               child: CircleAvatar(
//                 radius: MediaQuery.of(context).size.width * 0.18,
//                 backgroundColor: Colors.grey,
//                 child: ClipOval(
//                   child: Image.asset(
//                     'assets/icon.jpg',
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       SizedBox(
//         height: MediaQuery.sizeOf(context).height,
//         child: Padding(
//           padding: const EdgeInsets.only(left: 16, right: 16),
//           child: ListView(
//             primary: true,
//             physics: const AlwaysScrollableScrollPhysics(),
//             shrinkWrap: true,
//             children: [
              // const SizedBox(
              //   height: 16,
              // ),
              // SettingsButton(
              //   title: "تعديل الملف الشخصي",
              //   icon: const Icon(Icons.edit),
              //   onPressed: () {},
              // ),
              // SettingsButton(
              //   title: "الاشتراكات",
              //   icon: const Icon(Icons.attach_money),
              //   onPressed: () {
              //     Navigator.of(context)
              //         .pushNamed(SubscriptionsScreen.routeName);
              //   },
              // ),
              // SettingsButton(
              //   title: "المفضلة",
              //   icon: const Icon(Icons.favorite),
              //   onPressed: () {},
              // ),
              // SettingsButton(
              //   title: "الخصوصية",
              //   icon: const Icon(Icons.privacy_tip),
              //   onPressed: () {},
              // ),
              // SettingsButton(
              //   title: "حول التطبيق",
              //   icon: const Icon(Icons.info),
              //   onPressed: () {},
              // ),
              // SettingsButton(
              //   title: 'الشكاوي',
              //   icon: const Icon(Icons.message),
              //   onPressed: () {
              //     Navigator.of(context).pushNamed(ReportsScreen.routeName);
              //   },
              // ),
              // SettingsButton(
              //   title: 'تسجيل الخروج',
              //   icon: const Icon(Icons.logout),
              //   onPressed: () {
              //     AuthApiService.logoutUser().then((value) =>
              //         Navigator.of(context)
              //             .pushReplacementNamed(AuthScreen.routeName));
              //   },
              // ),
//             ],
//           ),
//         ),
//       )
//     ]);