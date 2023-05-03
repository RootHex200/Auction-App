import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebay/model/favourite_model.dart';
import 'package:ebay/service/firebase_service.dart';
import 'package:get/get.dart';

class Favouritecontroller extends GetxController {
  CollectionReference favourite_instance = FirebaseFirestore.instance
      .collection("Allusers")
      .doc(FirebaseServicess().user_current_check())
      .collection("FavouriteData");

  RxList<FavouriteModel> getfavouritedata = RxList<FavouriteModel>([]);
  RxList checkfavourite = RxList([]);
  RxList<GetFavouriteData> getdata = RxList<GetFavouriteData>([]);

  addto_favourite(docid) async {
    await favourite_instance
        .add({"docid": docid})
        .then((value) => print("User Added"))
        .catchError((e) => print(e));
  }

  Future check_favourite_item(docid) {
    var nn = favourite_instance
        .where("docid", isEqualTo: docid.toString())
        .get()
        .then((query) => query.docs.map((item) => item).toList());

    return nn;
  }

  Stream<List<GetFavouriteData>> getAllfavoutiteitem() {
    return favourite_instance.snapshots().map((query) => query.docs.map((item) {
          return GetFavouriteData.fromJson(item);
        }).toList());
  }

  deletefavouriteitme(docid) {
    favourite_instance.where("docid", isEqualTo: docid).get().then((value) {
      try {
        favourite_instance
            .doc(value.docs[0].id)
            .delete()
            .then((value) => getfavouritedata.bindStream(showFavourite()))
            .catchError((error) => print("Failed to delete user: $error"));
      } catch (e) {
        print(e);
      }
    });
  }

  Stream<List<FavouriteModel>> showFavourite() {
    getdata.bindStream(getAllfavoutiteitem());
    CollectionReference favouriteitem =
        FirebaseFirestore.instance.collection("auctionpost");
    return favouriteitem.snapshots().map((query) {
      return query.docs
          .where((item) => getdata.any((event) {
                return event.docid == item.id;
              }))
          .map((item) {
        print(item.id);
        return FavouriteModel.fromJson(item);
      }).toList();
    });
  }
}
