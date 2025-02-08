
import 'package:flutter/material.dart';
//import 'package:trilhaapp/pages/home_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trilhaapp/pages/login_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.purple,
        ),
        textTheme: GoogleFonts.robotoTextTheme(),
      ),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
