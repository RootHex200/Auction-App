import 'package:ebay/controller/firestore_controller.dart';
import 'package:ebay/view/bottomnavigation/bottomnavigationpage.dart';
import 'package:ebay/view/hompage/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final _auth = FirebaseAuth.instance;


  void user_sign_in(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Get.to(() => BottomNavigationPage());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar("error", "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        Get.snackbar("error", 'Wrong password provided for that user.');
      }
    }
  }

  void user_sign_up(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      FirestoreController().User_info_save(email, password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Get.snackbar("error", 'The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
