import 'package:cloud_firestore/cloud_firestore.dart';

class GetAllItemAuctionPostModel {
  String? productname;
  String? productdescription;
  String? minimumbidprice;
  String? auctionenddate;
  String? thumimage;
  List? images;
  List? bidlist;
  String? id;
  GetAllItemAuctionPostModel({
    required this.productname,
    required this.productdescription,
    required this.minimumbidprice,
    required this.auctionenddate,
    required this.thumimage,
    required this.images,
    required this.bidlist,
    required this.id,
  });

  GetAllItemAuctionPostModel.fromJson(DocumentSnapshot documentSnapshot) {
    productname = documentSnapshot['productname'];
    productdescription = documentSnapshot['productdescription'];
    minimumbidprice = documentSnapshot['minimumbidprice'];
    auctionenddate = documentSnapshot['auctionenddate'];
    thumimage = documentSnapshot['thumimage'];
    images = documentSnapshot['images'];
    bidlist = documentSnapshot['bidlist'];
    id = documentSnapshot.id;
  }
}
