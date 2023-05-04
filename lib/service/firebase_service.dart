import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseServicess {
  user_current_check() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user != null) {
      return user.uid;
    }
    return " ";
  }

  Future<List<String>> uploadImagesToFirebaseStorage(images) async {
    final List<String> imageUrls = [];

    for (int i = 0; i < images.length; i++) {
      final String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      final Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('uploads/$fileName.jpg');

      final UploadTask task = firebaseStorageRef.putFile(images[i]);

      final TaskSnapshot downloadUrl = await task;

      final String url = await downloadUrl.ref.getDownloadURL();

      imageUrls.add(url);
    }
    return imageUrls;
  }

  // //delete image from firebase storage
  // Future<void> deleteImageFromFirebaseStorage(String url) async {
  //   await FirebaseStorage.instance.refFromURL(url).delete();
  // }

  String getMaxBidPrice(List<dynamic> maxBidPrice) {
    if (maxBidPrice.isEmpty) {
      return 'No bid listed';
    } else {
      int max = int.parse(maxBidPrice[0]["bidprice"]);
      String maxid = maxBidPrice[0]["userid"];
      String maxusername = maxBidPrice[0]["username"];
      for (int i = 0; i < maxBidPrice.length; i++) {
        if (max < int.parse(maxBidPrice[i]["bidprice"])) {
          max = int.parse(maxBidPrice[i]["bidprice"]);
          maxid = maxBidPrice[i]["userid"];
          maxusername = maxBidPrice[i]["username"];
        }
      }
      return '$max $maxid $maxusername';
    }
  }

  deletedUser() async {
    await FirebaseAuth.instance.signOut();
    // FirebaseFirestore.instance
    //     .collection("Allusers")
    //     .doc(user_current_check())
    //     .delete();
    // await FirebaseAuth.instance.currentUser?.delete();
  }
}
