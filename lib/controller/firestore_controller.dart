import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebay/model/bist_updated_model.dart';
import 'package:ebay/model/get_all_item_auction_post_model.dart';
import 'package:ebay/model/get_my_posted_item.dart';
import 'package:ebay/model/report_model.dart';
import 'package:ebay/model/running_bid_model.dart';
import 'package:ebay/model/userinfo_model.dart';
import 'package:ebay/service/firebase_service.dart';
import 'package:ebay/model/user_input_auction_post_model.dart';
import 'package:ebay/utils/colors.dart';
import 'package:ebay/view/bottomnavigation/bottomnavigationpage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class FirestoreController extends GetxController {
  RxList<GetAllItemAuctionPostModel> auctionpostlist =
      RxList<GetAllItemAuctionPostModel>([]);
  var runningbitcount = "".obs;
  var completedbitcount = "".obs;
  var finaltotalWinningBidprice = 0.obs;
  var finalcompletedBidprice = 0.obs;
  RxList<RunningBidModel> runingBidList = RxList<RunningBidModel>([]);
  RxList<GetMyPostedItem> myposteditem = RxList<GetMyPostedItem>([]);
  RxList<CompletedBidModel> compelteBidList = RxList<CompletedBidModel>([]);
  RxList<CompletedBidTotalValueModel> compelteBidTotalValueList =
      RxList<CompletedBidTotalValueModel>([]);
  RxList<ReportModel> reportlist = RxList<ReportModel>([]);
  var checkBIditemcheck = false.obs;
  Rx<UserInfoModel> userinfo = Rx<UserInfoModel>(
      UserInfoModel(username: "", email: "", phone: "", uid: ""));
  @override
  void onInit() {
    auctionpostlist.bindStream(getAllauctionpostToFirebase(""));
    myposteditem.bindStream(getMypostedItem());
    userinfo.bindStream(Getuser_info());
    getRunningBid();
    getCompletedBid();
    getCompletedBidValue();
    super.onInit();
  }

  User_info_save(email, password, uid, mobile, username) async {
    CollectionReference users = FirebaseFirestore.instance
        .collection('Allusers')
        .doc(uid.toString())
        .collection("userinfo");

    await users.add({
      "email": email,
      "uid": uid,
      "phone": mobile,
      "username": username
    }).then((value) {
      Get.to(() => const BottomNavigationPage());
      // ignore: avoid_print
    }).catchError((e) => print(e));
  }

  addauctionpostToFirebase(InputAuctionPostModel auctionPostModel) async {
    String currentUserId = FirebaseServicess().user_current_check().toString();

    var users = FirebaseFirestore.instance.collection("auctionpost");

    users.add({
      "phone": userinfo.value.phone,
      "rating": Random().nextInt(5).toString(),
      "userid": currentUserId.toString(),
      "productname": auctionPostModel.productname,
      "productdescription": auctionPostModel.productdescription,
      "minimumbidprice": auctionPostModel.minimumbidprice,
      "auctionenddate": auctionPostModel.auctionenddate,
      "thumimage": auctionPostModel.images[0],
      "images": auctionPostModel.images,
      "bidlist": []
    }).then((value) {
      Get.snackbar("Auction", "new post add Successfully",
          colorText: Appcolors.white, backgroundColor: Appcolors.black);
      // ignore: avoid_print
    }).catchError((e) => print(e));
  }

  Stream<List<GetAllItemAuctionPostModel>> getAllauctionpostToFirebase(
      String searchvalue) {
    CollectionReference users =
        FirebaseFirestore.instance.collection("auctionpost");
    if (searchvalue.isEmpty) {
      return users.snapshots().map((query) => query.docs
          .map((e) => GetAllItemAuctionPostModel.fromJson(e))
          .toList());
    } else {
      return users
          .where(
            "productname",
            isGreaterThanOrEqualTo: searchvalue,
          )
          .snapshots()
          .map((query) => query.docs
              .map((e) => GetAllItemAuctionPostModel.fromJson(e))
              .toList());
    }
  }

  Stream<List<GetMyPostedItem>> getMypostedItem() {
    String currentUserId = FirebaseServicess().user_current_check();
    CollectionReference users =
        FirebaseFirestore.instance.collection("auctionpost");
    return users
        .where('userid', isEqualTo: currentUserId.toString())
        .snapshots()
        .map((query) =>
            query.docs.map((e) => GetMyPostedItem.fromJson(e)).toList());
  }

  deleteMypostedItem(String docid, List url) async {
    for (int i = 0; i < url.length; i++) {
      await FirebaseStorage.instance.refFromURL(url[i]).delete();
    }
    CollectionReference users =
        FirebaseFirestore.instance.collection("auctionpost");
    users.doc(docid).delete().then((value) {
      myposteditem.bindStream(getMypostedItem());
    }).catchError((e) {});
  }

  Stream<UserInfoModel> Getuser_info() {
    String currentUserId = FirebaseServicess().user_current_check();
    CollectionReference users = FirebaseFirestore.instance
        .collection('Allusers')
        .doc(currentUserId.toString())
        .collection("userinfo");

    return users.snapshots().map((query) {
      if (query.docs.isEmpty) {
        return UserInfoModel(username: "", email: "", phone: "", uid: "");
      }
      return UserInfoModel.fromJson(query.docs[0]);
    });
  }

  void updateBidlist(String auctionid, String bidprice, String username) {
    String currentUserId = FirebaseServicess().user_current_check();

    CollectionReference users =
        FirebaseFirestore.instance.collection("auctionpost");
    users.doc(auctionid).update({
      "bidlist": FieldValue.arrayUnion([
        {"username": username, "userid": currentUserId, "bidprice": bidprice}
      ])
    });
    auctionpostlist.bindStream(getAllauctionpostToFirebase(""));
  }

  checkBidItem(userid, auctionid) {
    var checklist = [];
    for (int i = 0; i < auctionpostlist.length; i++) {
      for (int j = 0; j < auctionpostlist[i].bidlist!.length; j++) {
        if (auctionpostlist[i].bidlist![j]["userid"] == userid &&
            auctionpostlist[i].id == auctionid) {
          checklist.add(true);
        }
      }
    }
    return checklist;
  }

  void bidupdateUservalue(BitListUpdatedModel bitListUpdatedModel) {
    String currentUserId = FirebaseServicess().user_current_check();
    CollectionReference users =
        FirebaseFirestore.instance.collection("auctionpost");
    users.doc(bitListUpdatedModel.auctionid).update({
      "bidlist": FieldValue.arrayRemove([
        {
          "username": bitListUpdatedModel.username,
          "userid": currentUserId,
          "bidprice": bitListUpdatedModel.previousbidprice
        }
      ])
    });

    updateBidlist(
        bitListUpdatedModel.auctionid.toString(),
        bitListUpdatedModel.newbidprice.toString(),
        bitListUpdatedModel.username.toString());
  }

  void report(ReportModel reportModel) {
    CollectionReference users = FirebaseFirestore.instance.collection("report");
    users.add({
      "userid": reportModel.userid,
      "auctionid": reportModel.auctionid,
      "reporttype": reportModel.reporttype,
      "reportmessage": reportModel.reportmessage,
    }).then((value) {
      Get.snackbar("Report", "Reported Successfully",
          colorText: Appcolors.white, backgroundColor: Appcolors.black);
      // ignore: avoid_print
    }).catchError((e) => print(e));
  }

  Stream<List<ReportModel>> getReport(userid) {
    String currentUserId = FirebaseServicess().user_current_check();
    CollectionReference users = FirebaseFirestore.instance.collection("report");
    return users
        .where("auctionid", isEqualTo: userid.toString())
        .where("userid", isEqualTo: currentUserId)
        .snapshots()
        .map(
            (query) => query.docs.map((e) => ReportModel.fromJson(e)).toList());
  }

  // void getRuunigBid() {
  //   List<RunningBidModel> filterlist = [];
  //   var currentDateTime =
  //       DateTime.parse(DateTime.now().toString().split(" ")[0]);
  //   Stream<List<GetAllItemAuctionPostModel>> getAllbidlist =
  //       getAllauctionpostToFirebase();

  //   getAllbidlist.listen((data) {
  //     print("this is data ${data.length}");
  //     filterlist = [];
  //     for (int i = 0; i < data.length; i++) {
  //       var enddate =
  //           DateTime.parse(data[i].auctionenddate.toString().split(" ")[0]);

  //       if (currentDateTime.isBefore(enddate)) {
  //         filterlist.add(RunningBidModel(time: enddate, bidnumber: i));
  //       }
  //     }
  //     runingBidList.clear();
  //     runingBidList.addAll(filterlist);
  //     print("this is rxbidlist ${runingBidList.length}");
  //     print("this is running bid ${filterlist.length}");
  //   });
  // }

  void getRunningBid() {
    List<GetAllItemAuctionPostModel> filterlist = [];
    List<RunningBidModel> finalDataList = [];
    List<String> dateList = [];

    List<GetAllItemAuctionPostModel> bidnumer = [];

    var currentDateTime =
        DateTime.parse(DateTime.now().toString().split(" ")[0]);
    Stream<List<GetAllItemAuctionPostModel>> getAllbidlist =
        getAllauctionpostToFirebase("");

    getAllbidlist.listen((data) {
      finalDataList.clear();
      dateList.clear();
      filterlist.clear();
      bidnumer.clear();

      for (int i = 0; i < data.length; i++) {
        var enddate =
            DateTime.parse(data[i].auctionenddate.toString().split(" ")[0]);

        if (currentDateTime.isBefore(enddate)) {
          dateList.add(data[i].auctionenddate.toString());
          filterlist.add(data[i]);
        }
      }
      runningbitcount.value = filterlist.length.toString();
      dateList = dateList.toSet().toList();

      for (int i = 0; i < dateList.length; i++) {
        bidnumer.clear();
        for (int j = 0; j < filterlist.length; j++) {
          if (dateList[i] == filterlist[j].auctionenddate.toString()) {
            bidnumer.add(filterlist[j]);
          }
        }
        // print("this is bid number ${bidnumer.length} and $bidnumer");
        finalDataList.add(RunningBidModel(
            time: DateTime.parse(dateList[i]), bidnumber: bidnumer.length));
      }
      runingBidList.clear();
      runingBidList.addAll(finalDataList);
    });
  }

  void getCompletedBid() {
    List<GetAllItemAuctionPostModel> filterlist = [];
    List<CompletedBidModel> finalDataList = [];
    List<String> dateList = [];

    List<GetAllItemAuctionPostModel> bidnumer = [];

    var currentDateTime =
        DateTime.parse(DateTime.now().toString().split(" ")[0]);
    Stream<List<GetAllItemAuctionPostModel>> getAllbidlist =
        getAllauctionpostToFirebase("");

    getAllbidlist.listen((data) {
      finalDataList.clear();
      dateList.clear();
      filterlist.clear();
      bidnumer.clear();

      for (int i = 0; i < data.length; i++) {
        var enddate =
            DateTime.parse(data[i].auctionenddate.toString().split(" ")[0]);

        if (currentDateTime.isAfter(enddate) || enddate == currentDateTime) {
          dateList.add(data[i].auctionenddate.toString());
          filterlist.add(data[i]);
        }
      }
      completedbitcount.value = filterlist.length.toString();
      dateList = dateList.toSet().toList();

      for (int i = 0; i < dateList.length; i++) {
        bidnumer.clear();
        for (int j = 0; j < filterlist.length; j++) {
          if (dateList[i] == filterlist[j].auctionenddate.toString()) {
            bidnumer.add(filterlist[j]);
          }
        }
        // print("this is bid number ${bidnumer.length} and $bidnumer");
        finalDataList.add(CompletedBidModel(
            time: DateTime.parse(dateList[i]), bidnumber: bidnumer.length));
      }
      compelteBidList.clear();
      compelteBidList.addAll(finalDataList);
    });
  }

  void getCompletedBidValue() {
    List<GetAllItemAuctionPostModel> filterlist = [];
    List<CompletedBidTotalValueModel> finalDataList = [];
    List<String> dateList = [];
    var totalWinnderBidPrice = 0;
    List<GetAllItemAuctionPostModel> bidprice = [];

    var currentDateTime =
        DateTime.parse(DateTime.now().toString().split(" ")[0]);
    Stream<List<GetAllItemAuctionPostModel>> getAllbidlist =
        getAllauctionpostToFirebase("");

    getAllbidlist.listen((data) {
      finalDataList.clear();
      dateList.clear();
      filterlist.clear();
      bidprice.clear();
      finaltotalWinningBidprice.value = 0;
      finalcompletedBidprice.value = 0;
      for (int i = 0; i < data.length; i++) {
        var enddate =
            DateTime.parse(data[i].auctionenddate.toString().split(" ")[0]);

        if (currentDateTime.isAfter(enddate) || enddate == currentDateTime) {
          dateList.add(data[i].auctionenddate.toString());
          filterlist.add(data[i]);
        }
      }

      dateList = dateList.toSet().toList();

      for (int i = 0; i < dateList.length; i++) {
        bidprice.clear();
        for (int j = 0; j < filterlist.length; j++) {
          if (dateList[i] == filterlist[j].auctionenddate.toString()) {
            bidprice.add(filterlist[j]);
          }
        }
        totalWinnderBidPrice = 0;

        for (int k = 0; k < bidprice.length; k++) {
          var price = bidprice[k].minimumbidprice.toString();
          finalcompletedBidprice.value =
              finalcompletedBidprice.value + int.parse(price);
          // print("this is price $price and ${finalcompletedBidprice.value}");
          var winnerprice =
              getMaxBidPrice(bidprice[k].bidlist as List<dynamic>);
          totalWinnderBidPrice = totalWinnderBidPrice + winnerprice;
          finaltotalWinningBidprice.value = totalWinnderBidPrice;
          // print("this is value $winnerprice");
        }
        // print(
        //     "this is bid number ${bidprice.length} and $totalWinnderBidPrice");
        finalDataList.add(CompletedBidTotalValueModel(
            time: DateTime.parse(dateList[i]), bidpirce: totalWinnderBidPrice));
      }

      compelteBidTotalValueList.clear();
      compelteBidTotalValueList.addAll(finalDataList);
    });
  }

  int getMaxBidPrice(List<dynamic> maxBidPrice) {
    if (maxBidPrice.isEmpty) {
      return 0;
    } else {
      int max = int.parse(maxBidPrice[0]["bidprice"]);
      for (int i = 0; i < maxBidPrice.length; i++) {
        if (max < int.parse(maxBidPrice[i]["bidprice"])) {
          max = int.parse(maxBidPrice[i]["bidprice"]);
        }
      }
      return max;
    }
  }
}
