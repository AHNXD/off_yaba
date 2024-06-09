import 'package:flutter/material.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/screens/all_discounts_screen.dart';
import 'package:off_yaba/screens/categories_screen.dart';
import 'package:off_yaba/screens/clothes_section.dart';
import 'package:off_yaba/screens/clothing_item_details.dart';
import 'package:off_yaba/screens/code_screen.dart';
import 'package:off_yaba/screens/offer_details_screen.dart';
import 'package:off_yaba/screens/reports_screen.dart';
import 'package:off_yaba/screens/resturant_screen.dart';
import 'package:off_yaba/screens/scanner_screen.dart';
import 'package:off_yaba/screens/search_screen.dart';
import 'package:off_yaba/screens/auth_screen.dart';
import 'package:off_yaba/screens/show_category_screen.dart';
import 'package:off_yaba/screens/signIn_screen.dart';
import 'package:off_yaba/screens/signup_screen.dart';
import 'package:off_yaba/screens/splash_screen.dart';
import 'package:off_yaba/screens/router_screen.dart';
import 'package:off_yaba/screens/subscriptions_screen.dart';
import 'package:off_yaba/services/network/api_service.dart';
import 'package:off_yaba/services/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  await CacheHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Off-Yaba',
      theme: ThemeData(
        fontFamily: 'Hacen Beirut',
        colorScheme: ColorScheme.fromSeed(seedColor: appColor),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey.shade200,

        // scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: SplashScreen.routeName,
      routes: {
        RouterScreen.routeName: (context) => const RouterScreen(),
        SearchScreen.routeName: (context) => const SearchScreen(),
        AuthScreen.routeName: (context) => const AuthScreen(),
        CategoriesScreen.routeName: (context) => const CategoriesScreen(),
        RestaurantScreen.routeName: (context) => const RestaurantScreen(),
        SplashScreen.routeName: (context) => const SplashScreen(),
        SignInScreen.routeName: (context) => const SignInScreen(),
        SignUpScreen.routeName: (context) => const SignUpScreen(),
        CodeScreen.routeName: (context) => const CodeScreen(),
        OfferDetailsScreen.routeName: (context) => const OfferDetailsScreen(),
        ShowCategoryScreen.routeName: (context) => const ShowCategoryScreen(),
        AllDiscountsScreen.routeName: (context) => const AllDiscountsScreen(),
        ReportsScreen.routeName: (context) => const ReportsScreen(),
        SubscriptionsScreen.routeName: (context) => const SubscriptionsScreen(),
        ClothesSectionScreen.routeName: (context) =>
            const ClothesSectionScreen(),
        ClothingItemDetailsScreen.routeName: (context) =>
            const ClothingItemDetailsScreen(),
        ScannerScreen.routeName: (context) => const ScannerScreen(),
      },
    );
  }
}
