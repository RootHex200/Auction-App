import 'package:ebay/controller/favourite_controller.dart';
import 'package:ebay/controller/firestore_controller.dart';
import 'package:ebay/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BidNow extends StatefulWidget {
  final String enddate;
  final String id;
  final List<dynamic> bidlist;
  const BidNow(
      {super.key,
      required this.enddate,
      required this.id,
      required this.bidlist});

  @override
  State<BidNow> createState() => _BidNowState();
}

class _BidNowState extends State<BidNow> {
  final FirestoreController firestoreController =
      Get.put(FirestoreController());
  final Favouritecontroller favouritecontroller =
      Get.put(Favouritecontroller());
  late TextEditingController bidController;
  @override
  void initState() {
    bidController = TextEditingController();
    firestoreController
                .checkBidItem(firestoreController.userinfo.value.uid, widget.id)
                .length ==
            0
        ? firestoreController.checkBIditemcheck.value = true
        : firestoreController.checkBIditemcheck.value = false;
    super.initState();
  }

  @override
  void dispose() {
    bidController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () async {
              var check =
                  await favouritecontroller.check_favourite_item(widget.id);
              if (check.length == 0) {
                favouritecontroller.addto_favourite(widget.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    duration: Duration(milliseconds: 500),
                    content: Text('Added'),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    duration: Duration(milliseconds: 500),
                    content: Text('Already Added'),
                  ),
                );
              }
            },
            child: Container(
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              height: 50,
              width: (MediaQuery.of(context).size.width / 2) - 20,
              decoration: BoxDecoration(
                  color: Appcolors.primaryColor,
                  borderRadius: BorderRadius.circular(9)),
              child: const Center(
                child: Text(
                  "Add To Favorite",
                  style: TextStyle(color: Appcolors.white, fontSize: 17),
                ),
              ),
            ),
          ),
          Obx(
            () => firestoreController.checkBIditemcheck.value
                ? GestureDetector(
                    onTap: () {
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
                                      firestoreController.updateBidlist(
                                          widget.id,
                                          bidController.text,
                                          firestoreController
                                              .userinfo.value.username
                                              .toString());
                                      Navigator.of(context).pop();
                                      Future.delayed(const Duration(seconds: 1),
                                          () {
                                        firestoreController
                                                    .checkBidItem(
                                                        firestoreController
                                                            .userinfo.value.uid,
                                                        widget.id)
                                                    .length ==
                                                0
                                            ? firestoreController
                                                .checkBIditemcheck.value = true
                                            : firestoreController
                                                .checkBIditemcheck
                                                .value = false;
                                      });
                                    },
                                    child: const Text("Bid"))
                              ],
                            );
                          });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 10),
                      height: 50,
                      width: (MediaQuery.of(context).size.width / 2) - 20,
                      decoration: BoxDecoration(
                          color: Appcolors.primaryColor,
                          borderRadius: BorderRadius.circular(9)),
                      child: const Center(
                        child: Text(
                          "BID Now",
                          style:
                              TextStyle(color: Appcolors.white, fontSize: 17),
                        ),
                      ),
                    ),
                  )
                : Container(
                    margin:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    height: 50,
                    width: (MediaQuery.of(context).size.width / 2) - 20,
                    decoration: BoxDecoration(
                        color: Appcolors.primaryColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(9)),
                    child: const Center(
                      child: Text(
                        "BID Now",
                        style: TextStyle(color: Appcolors.white, fontSize: 17),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
