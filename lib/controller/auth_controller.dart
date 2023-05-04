import 'package:ebay/controller/firestore_controller.dart';
import 'package:ebay/utils/colors.dart';
import 'package:ebay/view/bottomnavigation/bottomnavigationpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {

  final FirestoreController firestoreController =
      Get.put(FirestoreController());

  void user_sign_in(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Get.to(() => const BottomNavigationPage());
      TiggerAllitem();
      firestoreController.myposteditem
          .bindStream(firestoreController.getMypostedItem());
      firestoreController.auctionpostlist
          .bindStream(firestoreController.getAllauctionpostToFirebase(""));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar("error", "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        Get.snackbar("error", 'Wrong password provided for that user.',
            colorText: Appcolors.white, backgroundColor: Appcolors.black);
      }
    }
  }

  void user_sign_up(
      String email, String password, String phone, String username) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await FirestoreController().User_info_save(
          email, password, userCredential.user!.uid, phone, username);
      TiggerAllitem();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Get.snackbar("error", 'The account already exists for that email.',
            colorText: Appcolors.white, backgroundColor: Appcolors.black);
      }
    } catch (e) {
    }
  }

  void TiggerAllitem() {
    firestoreController.myposteditem
        .bindStream(firestoreController.getMypostedItem());
    firestoreController.auctionpostlist
        .bindStream(firestoreController.getAllauctionpostToFirebase(""));
    firestoreController.userinfo.bindStream(firestoreController.Getuser_info());
  }
}
