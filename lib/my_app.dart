
import 'package:flutter/material.dart';
//import 'package:trilhaapp/pages/home_page.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:trilhaapp/pages/login_page.dart';
import 'package:trilhaapp/pages/splash_screen/splash_screen_delay_page.dart';
// import 'package:trilhaapp/pages/splash_screen/splash_screen_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
          backgroundColor: Colors.purple,
          iconTheme: IconThemeData(
            color: Colors.white,
          )
        ),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.purple,
        ),
        textTheme: GoogleFonts.robotoTextTheme(),
      ),
      home: SplashScreenDelayPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
