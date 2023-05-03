import 'package:cloud_firestore/cloud_firestore.dart';

class FavouriteModel {
  String? phone;
  String? rating;
  String? productname;
  String? productdescription;
  String? minimumbidprice;
  String? auctionenddate;
  String? thumimage;
  List? images;
  List? bidlist;
  String? userid;
  String? id;
  FavouriteModel({
    required this.phone,
    required this.rating,
    required this.productname,
    required this.productdescription,
    required this.minimumbidprice,
    required this.auctionenddate,
    required this.thumimage,
    required this.images,
    required this.bidlist,
    required this.userid,
    required this.id,
  });

  FavouriteModel.fromJson(DocumentSnapshot documentSnapshot) {
    phone = documentSnapshot['phone'];
    rating = documentSnapshot['rating'] ?? '0';
    productname = documentSnapshot['productname'];
    productdescription = documentSnapshot['productdescription'];
    minimumbidprice = documentSnapshot['minimumbidprice'];
    auctionenddate = documentSnapshot['auctionenddate'];
    thumimage = documentSnapshot['thumimage'];
    images = documentSnapshot['images'];
    bidlist = documentSnapshot['bidlist'];
    userid = documentSnapshot['userid'];
    id = documentSnapshot.id;
  }
}

class GetFavouriteData {
  String? docid;
  String? id;

  GetFavouriteData({
    required this.docid,
    required this.id,
  });
  GetFavouriteData.fromJson(DocumentSnapshot documentSnapshot) {
    docid = documentSnapshot['docid'];
    id = documentSnapshot.id;
  }
}
