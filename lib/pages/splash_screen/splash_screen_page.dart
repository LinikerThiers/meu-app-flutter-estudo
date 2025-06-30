import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:trilhaapp/pages/login/login_page.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.purple,
          ],
          stops: [0.3, 0.7],
        )),
        child: Center(
          child:
              // AnimatedTextKit(
              //   animatedTexts: [
              //     TypewriterAnimatedText(
              //       'Hello world!',
              //       textStyle: const TextStyle(
              //         fontSize: 32.0,
              //         fontWeight: FontWeight.bold,
              //       ),
              //       speed: const Duration(milliseconds: 500),
              //     ),
              //   ],
              //   totalRepeatCount: 4,
              //   pause: const Duration(milliseconds: 200),
              //   displayFullTextOnTap: true,
              //   stopPauseOnTap: true,
              // ),
              SizedBox(
            width: 250.0,
            child: DefaultTextStyle(
              style: const TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              child: AnimatedTextKit(
                repeatForever: false,
                totalRepeatCount: 1,
                onFinished: () => {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (bc) => LoginPage()))
                },
                animatedTexts: [
                  FadeAnimatedText('meu APP'),
                  FadeAnimatedText('em Flutter'),
                  FadeAnimatedText('ficará TOP'),
                ],
                onTap: () {
                  print("Tap Event");
                },
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
