import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebay/model/bist_updated_model.dart';
import 'package:ebay/model/get_all_item_auction_post_model.dart';
import 'package:ebay/model/get_my_posted_item.dart';
import 'package:ebay/service/firebase_service.dart';
import 'package:ebay/model/user_input_auction_post_model.dart';
import 'package:ebay/view/hompage/homepage.dart';
import 'package:get/get.dart';

class FirestoreController extends GetxController {
  RxList<GetAllItemAuctionPostModel> auctionpostlist =
      RxList<GetAllItemAuctionPostModel>([]);

  RxList<GetMyPostedItem> myposteditem = RxList<GetMyPostedItem>([]);
  @override
  void onInit() {
    auctionpostlist.bindStream(getAllauctionpostToFirebase());
    myposteditem.bindStream(getMypostedItem());
    super.onInit();
  }

  User_info_save(email, password) async {
    CollectionReference users = FirebaseFirestore.instance
        .collection('Allusers')
        .doc(email.toString())
        .collection("userinfo");

    await users.add({
      "user_email": email,
      "user_password": password,
    }).then((value) {
      Get.to(() => const Homepage());
    }).catchError((e) => print(e));
  }

  addauctionpostToFirebase(InputAuctionPostModel auctionPostModel) async {
    String currentUserEmail = FirebaseServicess().user_current_check();
    print("this is current user email $currentUserEmail");
    var users = FirebaseFirestore.instance.collection("auctionpost");

    users.add({
      "useremail": currentUserEmail.toString(),
      "productname": auctionPostModel.productname,
      "productdescription": auctionPostModel.productdescription,
      "minimumbidprice": auctionPostModel.minimumbidprice,
      "auctionenddate": auctionPostModel.auctionenddate,
      "thumimage": auctionPostModel.images[0],
      "images": auctionPostModel.images,
      "bidlist": []
    }).then((value) {
      Get.to(() => const Homepage());
    }).catchError((e) => print(e));
  }

  Stream<List<GetAllItemAuctionPostModel>> getAllauctionpostToFirebase() {
    String currentUserEmail = FirebaseServicess().user_current_check();
    CollectionReference users =
        FirebaseFirestore.instance.collection("auctionpost");
    print(users.snapshots().map((query) => query.docs
        .map((e) => GetAllItemAuctionPostModel.fromJson(e))
        .toList()));
    return users.snapshots().map((query) =>
        query.docs.map((e) => GetAllItemAuctionPostModel.fromJson(e)).toList());
  }

  Stream<List<GetMyPostedItem>> getMypostedItem() {
    String currentUserEmail = FirebaseServicess().user_current_check();
    CollectionReference users =
        FirebaseFirestore.instance.collection("auctionpost");
    return users
      .where('useremail', isEqualTo: currentUserEmail.toString())
          .snapshots()
          .map((query) =>
              query.docs.map((e) => GetMyPostedItem.fromJson(e)).toList());
    // return users.snapshots().map(
    //     (query) => query.docs.map((e) => GetMyPostedItem.fromJson(e)).toList());
  }

  void updateBidlist(String auctionid, String bidprice) {
    String currentUserEmail = FirebaseServicess().user_current_check();

    CollectionReference users =
        FirebaseFirestore.instance.collection("auctionpost");
    users.doc(auctionid).update({
      "bidlist": FieldValue.arrayUnion([
        {"useremail": currentUserEmail, "bidprice": bidprice}
      ])
    });
  }

  void bidupdateUservalue(BitListUpdatedModel bitListUpdatedModel){
    String currentUserEmail = FirebaseServicess().user_current_check();
    CollectionReference users =
        FirebaseFirestore.instance.collection("auctionpost");
    users.doc(bitListUpdatedModel.auctionid).update({
      "bidlist": FieldValue.arrayRemove([
        {"useremail": currentUserEmail, "bidprice": bitListUpdatedModel.previousbidprice}
      ])
    });

    updateBidlist(bitListUpdatedModel.auctionid.toString(), bitListUpdatedModel.newbidprice.toString());
  
  }

  


}
