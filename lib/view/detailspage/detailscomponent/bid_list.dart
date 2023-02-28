

import 'package:ebay/controller/firestore_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class BidList extends StatelessWidget {
  final int product_index;
  const BidList({super.key, required this.product_index});

  @override
  Widget build(BuildContext context) {
    final FirestoreController auctionAllpost = Get.put(FirestoreController());
    return Obx(
      () => ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount:
              auctionAllpost.auctionpostlist[product_index].bidlist?.length,
          itemBuilder: (context, index) {
            return Container(
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      auctionAllpost.auctionpostlist[product_index]
                          .bidlist![index]["useremail"]
                          .toString(),
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    Text(
                      "${auctionAllpost.auctionpostlist[product_index].bidlist![index]["bidprice"].toString()}\$",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ],
                ));
          }),
    );
  }
}
