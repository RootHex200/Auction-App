import 'package:ebay/controller/firestore_controller.dart';
import 'package:ebay/model/bist_updated_model.dart';
import 'package:ebay/service/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class BidList extends StatefulWidget {
  final int product_index;
  const BidList({super.key, required this.product_index});

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
    String currentUserEmail = FirebaseServicess().user_current_check();
    return Obx(
      () => ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: firestoreController
              .auctionpostlist[widget.product_index].bidlist?.length,
          itemBuilder: (context, index) {
            return Container(
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          firestoreController
                              .auctionpostlist[widget.product_index]
                              .bidlist![index]["useremail"]
                              .toString(),
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        Text(
                          "${firestoreController.auctionpostlist[widget.product_index].bidlist![index]["bidprice"].toString()}\$",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    firestoreController.auctionpostlist[widget.product_index]
                                .bidlist![index]["useremail"] ==
                            currentUserEmail
                        ? Center(
                            child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text('BId Amount'),
                                          content: TextField(
                                            controller: bidController,
                                            decoration: const InputDecoration(
                                              hintText: "Enter Bid Amount",
                                            ),
                                          ),
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("Cancel")),
                                            ElevatedButton(
                                                onPressed: () {
                                                  String auctionid =
                                                      firestoreController
                                                          .auctionpostlist[widget
                                                              .product_index]
                                                          .id
                                                          .toString();
                                                  BitListUpdatedModel
                                                      bitListUpdatedModel =
                                                      BitListUpdatedModel(
                                                          previousbidprice:
                                                              firestoreController
                                                                  .auctionpostlist[
                                                                      widget
                                                                          .product_index]
                                                                  .bidlist![
                                                                      index][
                                                                      "bidprice"]
                                                                  .toString(),
                                                          newbidprice: bidController.text,
                                                          auctionid: auctionid);

                                                  firestoreController
                                                      .bidupdateUservalue(
                                                          bitListUpdatedModel);
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("Update"))
                                          ],
                                        );
                                      });
                                },
                                child: Text(
                                  "Update",
                                  style: TextStyle(color: Colors.yellow),
                                )))
                        : Text("")
                  ],
                ));
          }),
    );
  }
}
