import 'package:bhaktchintamani/pages/HomeScreen.dart';
import 'package:bhaktchintamani/utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences? shredPreferences;
  @override
  void initState() {
    super.initState();
    navigateToHome();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/images/splash_bg.png"),
            fit: BoxFit.cover,
          )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                child: SizedBox(
                  height: 65,
                  child: AnimatedTextKit(
                    animatedTexts: [
                      FadeAnimatedText(
                        "ભક્તચિંતામણિ",
                        textStyle: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Gujarati-Bold",
                          color: Color(0xff9F0B1E),
                        ),
                        duration: const Duration(milliseconds: 2000),
                      ),
                    ],
                    totalRepeatCount: 1,
                    displayFullTextOnTap: false,
                    stopPauseOnTap: false,
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  height: 45,
                  child: AnimatedTextKit(
                    animatedTexts: [
                      FadeAnimatedText(
                        "રાજકોટ ગુરુકુળ",
                        textStyle: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Gujarati",
                          color: Colors.black,
                        ),
                        duration: const Duration(milliseconds: 2000),
                      )
                    ],
                    totalRepeatCount: 1,
                    displayFullTextOnTap: false,
                    stopPauseOnTap: false,
                  ),
                ),
              ),
              const SizedBox(
                height: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }

  navigateToHome() async {
    shredPreferences = await SharedPreferences.getInstance();
    shredPreferences!.setInt(Constants.defaultColor, 1);
    await Future.delayed(Duration(milliseconds: 1500), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }
}
