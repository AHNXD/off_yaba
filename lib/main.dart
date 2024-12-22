import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:off_yaba/constant.dart';
import 'package:off_yaba/firebase_options.dart';
import 'package:off_yaba/screens/all_discounts_screen.dart';
import 'package:off_yaba/screens/categories_screen.dart';
import 'package:off_yaba/screens/clothes_section.dart';
import 'package:off_yaba/screens/clothing_item_details.dart';
import 'package:off_yaba/screens/code_screen.dart';
import 'package:off_yaba/screens/confirm_order_screen.dart';
import 'package:off_yaba/screens/employe/order_details_screen.dart';
import 'package:off_yaba/screens/employe/show_map.dart';
import 'package:off_yaba/screens/employe/store_orders_screen.dart';
import 'package:off_yaba/screens/offer_details_screen.dart';
import 'package:off_yaba/screens/order_item_details_screen.dart';
import 'package:off_yaba/screens/reports_screen.dart';
import 'package:off_yaba/screens/resturant_screen.dart';
import 'package:off_yaba/screens/scanner_screen.dart';
import 'package:off_yaba/screens/search_screen.dart';
import 'package:off_yaba/screens/auth_screen.dart';
import 'package:off_yaba/screens/show_category_screen.dart';
import 'package:off_yaba/screens/signin_screen.dart';
import 'package:off_yaba/screens/signup_screen.dart';
import 'package:off_yaba/screens/splash_screen.dart';
import 'package:off_yaba/screens/router_screen.dart';
import 'package:off_yaba/screens/subscriptions_screen.dart';
import 'package:off_yaba/screens/update_user_info_screen.dart';
import 'package:off_yaba/services/network/api_service.dart';
import 'package:off_yaba/services/cache_helper.dart';
import 'package:off_yaba/services/network/firebase_api_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheHelper.init();
  await DioHelper.init();
  await FirebaseApi().initNotifications();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: lang == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Off-Yaba',
        theme: ThemeData(
          fontFamily: GoogleFonts.cairo.call().fontFamily,
          colorScheme: ColorScheme.fromSeed(seedColor: appColor),
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.grey.shade200,
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
          SubscriptionsScreen.routeName: (context) =>
              const SubscriptionsScreen(),
          ClothesSectionScreen.routeName: (context) =>
              const ClothesSectionScreen(),
          ClothingItemDetailsScreen.routeName: (context) =>
              const ClothingItemDetailsScreen(),
          ScannerScreen.routeName: (context) => const ScannerScreen(),
          OrderItemDeatils.routeName: (context) => const OrderItemDeatils(),
          ConfirmOrderScreen.routeName: (context) => const ConfirmOrderScreen(),
          StoreOrdersScreen.routeName: (context) => const StoreOrdersScreen(),
          OrderDetailsScreen.routeName: (context) => OrderDetailsScreen(),
          UpdateUserInfoScreen.routeName: (ctx) => const UpdateUserInfoScreen(),
          ShowMapScreen.routeName: (context) => const ShowMapScreen()
        },
      ),
    );
  }
}
