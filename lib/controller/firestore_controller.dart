import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';

class FirestoreController extends GetxController {
  User_info_save(email, password) async {
    CollectionReference users = FirebaseFirestore.instance
        .collection('Allusers')
        .doc(email.toString())
        .collection("userinfo");

    await users.add({
      "user_email": email,
      "user_password": password,
    }).then((value) {
      
   //TODO: navigate to home page

    }).catchError((e) => print(e));
  }
}
