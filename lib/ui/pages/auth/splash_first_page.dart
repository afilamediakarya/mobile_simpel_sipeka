import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpel/shared/shared_prefrences.dart';
import 'package:simpel/shared/theme.dart';

class SplashFirstPage extends StatefulWidget {
  const SplashFirstPage({super.key});

  @override
  State<SplashFirstPage> createState() => _SplashFirstPageState();
}

class _SplashFirstPageState extends State<SplashFirstPage>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
        setState(() {
          if (controller.value == 1.0) {
            Navigator.pushNamedAndRemoveUntil(
                context, 'splash-second', (route) => false);
          } else {
            null;
          }
        });
      });
    controller.forward();
    super.initState();
    initializePreference();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> initializePreference() async {
    SharedPreference.login = await SharedPreferences.getInstance();
    SharedPreference.choosedRoleSuara = await SharedPreferences.getInstance();
    SharedPreference.idKomunitas = await SharedPreferences.getInstance();
    SharedPreference.nikDpt = await SharedPreferences.getInstance();
    SharedPreference.hdtTkpSPDpt = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/ic_logo_splash.png",
                      height: 164,
                      width: 174,
                    ),
                    const SizedBox(height: 35,),
                    Image.asset(
                      "assets/img_lokomotif.png",
                      height: 120,
                      width: 188,
                    ),
                  ],
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 81),
                  child: LoadingAnimationWidget.hexagonDots(
                    color: kPrimaryColor,
                    size: 53,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
