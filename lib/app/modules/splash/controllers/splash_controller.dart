import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:grocery_app/app/routes/app_pages.dart';
import 'package:grocery_app/log&splash/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  late final bool? repeat;
  late SharedPreferences prefs;
  @override
  void onInit() async {
    await Future.delayed(const Duration(seconds: 2));
    initializePrefs();
    checkConnectivityAndNavigation();
    super.onInit();
  }

  // Method to initialize SharedPreferences
  void initializePrefs() async {
    prefs = await SharedPreferences.getInstance();
    repeat = prefs.getBool('repeat');
  }

  // Method to check connectivity and navigate
  void checkConnectivityAndNavigation() {
    Timer(
      Duration(seconds: 4),
      () {
        if (repeat == true) {
          FirebaseAuth.instance.authStateChanges().listen((User? user) {
            if (user != null) {
              // If user is authenticated, navigate to HomePage
              Get.offNamed(Routes.BASE);
            } else {
              // If user is not authenticated, navigate to SignInView
              Get.off(const NgamarSignInView());
            }
          });
        } else {
          Get.offNamed(Routes.WELCOME);
        }
      },
    );
  }
}
