import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:healthylife/CRUD/page/food_manager.dart';
import 'package:healthylife/page/account/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:healthylife/page/food_calo/food_calo.dart';
import 'package:healthylife/page/home/home_page.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('vi', 'VN')
      ],
      home: SplashScreenPage(),
      // home: FoodManager(), // Mở comment này nếu muốn add dữ liệu món ăn
    );
  }
}

