
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
//import 'package:trilhaapp/pages/home_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
// import 'package:trilhaapp/pages/login_page.dart';
import 'package:trilhaapp/pages/splash_screen/splash_screen_delay_page.dart';
import 'package:trilhaapp/service/dark_mode_service.dart';
// import 'package:trilhaapp/pages/splash_screen/splash_screen_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DarkModeService>(create: (_) => DarkModeService())
      ],
      child: Consumer<DarkModeService>(
              builder: (_, darkModeService, widget) {
          return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: darkModeService.darkMode ? ThemeData.dark() : ThemeData(
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
      ),
    );
  }
}
