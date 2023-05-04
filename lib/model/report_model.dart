import 'package:cloud_firestore/cloud_firestore.dart';

class ReportModel {
  String? auctionid;
  String? userid;
  String? reporttype;
  String? reportmessage;
  ReportModel({
   required this.auctionid,
   required this.userid,
   required this.reporttype,
   required this.reportmessage,
  });

  ReportModel.fromJson(DocumentSnapshot documentSnapshot){
    auctionid = documentSnapshot['auctionid'];
    userid = documentSnapshot['userid'];
    reporttype = documentSnapshot['reporttype'];
    reportmessage = documentSnapshot['reportmessage'];
  }
}
