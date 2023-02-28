import 'package:ebay/controller/firestore_controller.dart';
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
  var currentDateTime = DateTime.parse(DateTime.now().toString().split(" ")[0]);
  final FirestoreController firestoreController =
      Get.put(FirestoreController());
  late TextEditingController bidController;
  @override
  void initState() {
    bidController = TextEditingController();
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
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              height: 50,
              width: (MediaQuery.of(context).size.width / 2) - 20,
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(9)),
              child: const Center(
                child: Text(
                  "Add To Favorite",
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
            ),
          ), GestureDetector(
              onTap: () {
                var enddate = DateTime.parse(widget.enddate);
                if (currentDateTime.isAfter(enddate) ||
                    enddate == currentDateTime) {
                  Get.snackbar("Time Gone", "You can't bid now");
                } else {
                 
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
                                  firestoreController.updateBidlist(widget.id, bidController.text);
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Update"))
                          ],
                        );
                      });
                }
              },
              child: Container(
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                height: 50,
                width: (MediaQuery.of(context).size.width / 2) - 20,
                decoration: BoxDecoration(
                    color: Colors.green, borderRadius: BorderRadius.circular(9)),
                child: const Center(
                  child: Text(
                    "BID Now",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
              ),
            ),
          
        ],
      ),
    );
  }
}
