import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseServicess {
  user_current_check() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user != null) {
      return user.email!;
    } else {
      print('No user is currently signed in.');
    }
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

  String getMaxBidPrice(List<dynamic> maxBidPrice) {
    int max = int.parse(maxBidPrice[0]["bidprice"]);
    String maxuser = maxBidPrice[0]["useremail"];
    for (int i = 0; i < maxBidPrice.length; i++) {
      if (max < int.parse(maxBidPrice[i]["bidprice"])) {
        max = int.parse(maxBidPrice[i]["bidprice"]);
        maxuser = maxBidPrice[i]["useremail"];
      }
    }
    return 'Max Bid Price: $max, $maxuser is winner';
  }
}
