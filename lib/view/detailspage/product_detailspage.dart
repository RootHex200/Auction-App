import 'package:ebay/controller/firestore_controller.dart';
import 'package:ebay/service/firebase_service.dart';
import 'package:ebay/utils/colors.dart';
import 'package:ebay/view/detailspage/detailscomponent/bid_list.dart';
import 'package:ebay/view/detailspage/detailscomponent/bid_now.dart';
import 'package:ebay/view/detailspage/detailscomponent/product_view_image.dart';
import 'package:ebay/view/detailspage/detailscomponent/report_option.dart';
import 'package:ebay/view/detailspage/detailscomponent/summary.dart';
import 'package:ebay/view/detailspage/detailscomponent/title_rating_price.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuctionDetailsPage extends StatelessWidget {
  final fromPage;
  final auctionAllpost;
  final int index;
  const AuctionDetailsPage(
      {super.key,
      required this.auctionAllpost,
      required this.index,
      required this.fromPage});

  @override
  Widget build(BuildContext context) {
    var currentDateTime =
        DateTime.parse(DateTime.now().toString().split(" ")[0]);
    var enddate = DateTime.parse(auctionAllpost.auctionenddate.toString());
    String maxbidprice = FirebaseServicess()
        .getMaxBidPrice(auctionAllpost.bidlist as List<dynamic>);
    final FirestoreController firestoreController =
        Get.put(FirestoreController());
    firestoreController.reportlist
        .bindStream(firestoreController.getReport(auctionAllpost.id));

    if ("No bid listed" == maxbidprice) {
      maxbidprice = "No bid listed";
    } else if (maxbidprice.split(" ")[1] ==
        firestoreController.userinfo.value.uid) {
      maxbidprice =
          "You are the highest bidder amout: ${maxbidprice.split(" ")[0].toString()} to buy this product check seller detials";
    } else {
      maxbidprice =
          "Highest Bidder:${maxbidprice.split(" ")[2].toString()} amount: ${maxbidprice.split(" ")[0].toString()}";
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Details Page",
            style: TextStyle(color: Appcolors.white),
          ),
        ),
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductImageView(
                        image: auctionAllpost.images as List<dynamic>,
                        discount: 20,
                      ),
                      const SizedBox(height: 10),
                      TitleRatingPrice(
                        price: auctionAllpost.minimumbidprice.toString(),
                        producttitle: auctionAllpost.productname.toString(),
                        rating: auctionAllpost.rating.toString(),
                        date: auctionAllpost.auctionenddate.toString(),
                      ),
                      const SizedBox(height: 20),
                      Summary(
                        description:
                            auctionAllpost.productdescription.toString(),
                        sellerPhone: auctionAllpost.phone.toString(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "All Bids",
                          style: TextStyle(
                              color: Appcolors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      currentDateTime.isAfter(enddate) ||
                              enddate == currentDateTime
                          ? BidList(
                              product_index: index,
                              isOver: true,
                              fromPage: fromPage,
                            )
                          : BidList(
                              product_index: index,
                              isOver: false,
                              fromPage: fromPage,
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(
                        () => auctionAllpost.userid ==
                                firestoreController.userinfo.value.uid
                            ? const SizedBox()
                            : firestoreController.reportlist.isNotEmpty
                                ? const Center(
                                    child: Text(
                                      'Your report has already been received',
                                      style: TextStyle(
                                          color: Appcolors.textSecondaryColor),
                                    ),
                                  )
                                : Center(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ReportOption(
                                                      auctionid:
                                                          auctionAllpost.id,
                                                      userid:
                                                          firestoreController
                                                              .userinfo
                                                              .value
                                                              .uid
                                                              .toString(),
                                                    )));
                                      },
                                      child: const Text('Report Post'),
                                    ),
                                  ),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                      //report button
                    ],
                  ),
                ),
              ),
              currentDateTime.isAfter(enddate) || enddate == currentDateTime
                  ? Container(
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20),
                      child: Center(
                          child: Text(
                        maxbidprice,
                        style: const TextStyle(
                            color: Appcolors.primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )),
                    )
                  : auctionAllpost.userid ==
                          firestoreController.userinfo.value.uid
                      ? Container()
                      : BidNow(
                          enddate: auctionAllpost.auctionenddate.toString(),
                          id: auctionAllpost.id.toString(),
                          bidlist: auctionAllpost.bidlist as List<dynamic>,
                        )
            ],
          ),
        ));
  }
}
