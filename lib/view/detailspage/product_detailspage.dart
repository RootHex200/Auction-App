import 'package:ebay/model/get_all_item_auction_post_model.dart';
import 'package:ebay/service/firebase_service.dart';
import 'package:ebay/view/detailspage/detailscomponent/bid_list.dart';
import 'package:ebay/view/detailspage/detailscomponent/bid_now.dart';
import 'package:ebay/view/detailspage/detailscomponent/product_view_image.dart';
import 'package:ebay/view/detailspage/detailscomponent/summary.dart';
import 'package:ebay/view/detailspage/detailscomponent/title_rating_price.dart';
import 'package:flutter/material.dart';

class AuctionDetailsPage extends StatelessWidget {
  final GetAllItemAuctionPostModel auctionAllpost;
  final int index;
  const AuctionDetailsPage(
      {super.key, required this.auctionAllpost, required this.index});

  @override
  Widget build(BuildContext context) {
    var currentDateTime =
        DateTime.parse(DateTime.now().toString().split(" ")[0]);
    var enddate = DateTime.parse(auctionAllpost.auctionenddate.toString());
    String maxbidprice = FirebaseServicess()
        .getMaxBidPrice(auctionAllpost.bidlist as List<dynamic>);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        body: Column(
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
                      product_title: auctionAllpost.productname.toString(),
                      rating: 5.toString(),
                      date: auctionAllpost.auctionenddate.toString(),
                    ),
                    const SizedBox(height: 20),
                    Visibility(
                        visible: true,
                        child: Summary(
                          description:
                              auctionAllpost.productdescription.toString(),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "All Bids",
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BidList(
                      product_index: index,
                    )
                  ],
                ),
              ),
            ),
            currentDateTime.isAfter(enddate) || enddate == currentDateTime
                ? Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: Center(
                        child: Text(
                      maxbidprice,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    )),
                  )
                : BidNow(
                    enddate: auctionAllpost.auctionenddate.toString(),
                    id: auctionAllpost.id.toString(),
                    bidlist: auctionAllpost.bidlist as List<dynamic>,
                  )
          ],
        ));
  }
}
