import 'package:ebay/controller/favourite_controller.dart';
import 'package:ebay/controller/firestore_controller.dart';
import 'package:ebay/model/bist_updated_model.dart';
import 'package:ebay/service/firebase_service.dart';
import 'package:ebay/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BidList extends StatefulWidget {
  final fromPage;
  final int product_index;
  final bool isOver;
  const BidList(
      {super.key,
      required this.product_index,
      required this.isOver,
      required this.fromPage});

  @override
  State<BidList> createState() => _BidListState();
}

class _BidListState extends State<BidList> {
  final TextEditingController bidController = TextEditingController();
  @override
  void dispose() {
    bidController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FirestoreController firestoreController =
        Get.put(FirestoreController());
    final Favouritecontroller favouritecontroller =
        Get.put(Favouritecontroller());
    String currentUserId = FirebaseServicess().user_current_check();

    return Obx(
      () {
        var detailsPageData;
        switch (widget.fromPage) {
          case "homepage":
            detailsPageData =
                firestoreController.auctionpostlist[widget.product_index];
            break;
          case "favouritepage":
            detailsPageData =
                favouritecontroller.getfavouritedata[widget.product_index];
            break;
        }
        return detailsPageData.bidlist!.isEmpty
            ? const Center(
                child: Text(
                  "user bid not found",
                  style: TextStyle(color: Appcolors.textSecondaryColor),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: detailsPageData.bidlist?.length,
                itemBuilder: (context, index) {
                  return Container(
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Appcolors.primaryColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                detailsPageData.bidlist![index]["username"]
                                    .toString(),
                                style: const TextStyle(
                                    color: Appcolors.black, fontSize: 18),
                              ),
                              Text(
                                "${detailsPageData.bidlist![index]["bidprice"].toString()}\৳",
                                style: const TextStyle(
                                    color: Appcolors.black, fontSize: 18),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          detailsPageData.bidlist![index]["userid"] ==
                                  currentUserId
                              ? widget.isOver
                                  ? const SizedBox()
                                  : Center(
                                      child: TextButton(
                                          style: TextButton.styleFrom(
                                            backgroundColor:
                                                Appcolors.secondaryColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'Update Bid Amount'),
                                                    content: TextField(
                                                      controller: bidController,
                                                      decoration:
                                                          const InputDecoration(
                                                        hintText:
                                                            "Enter Bid Amount",
                                                      ),
                                                    ),
                                                    actions: [
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: const Text(
                                                              "Cancel")),
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            String auctionid =
                                                                detailsPageData
                                                                    .id
                                                                    .toString();
                                                            BitListUpdatedModel bitListUpdatedModel = BitListUpdatedModel(
                                                                previousbidprice:
                                                                    detailsPageData
                                                                        .bidlist![
                                                                            index]
                                                                            [
                                                                            "bidprice"]
                                                                        .toString(),
                                                                newbidprice:
                                                                    bidController
                                                                        .text,
                                                                auctionid:
                                                                    auctionid,
                                                                username:
                                                                    firestoreController
                                                                        .userinfo
                                                                        .value
                                                                        .username);

                                                            firestoreController
                                                                .bidupdateUservalue(
                                                                    bitListUpdatedModel);
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: const Text(
                                                              "Update"))
                                                    ],
                                                  );
                                                });
                                          },
                                          child: const Text(
                                            "Update",
                                            style: TextStyle(
                                                color: Appcolors.white),
                                          )))
                              : const SizedBox(),
                        ],
                      ));
                });
      },
    );
  }
}
