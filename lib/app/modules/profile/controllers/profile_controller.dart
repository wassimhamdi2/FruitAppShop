import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:grocery_app/toast.dart';

import '../../../../log&splash/login.dart';

class ProfileController extends GetxController {
  signup() {
    FirebaseAuth.instance.signOut();
    showToast(message: "Successfully signed out");
    Get.off(NgamarSignInView());
  }
}
