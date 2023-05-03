import 'package:ebay/controller/firestore_controller.dart';
import 'package:ebay/utils/colors.dart';
import 'package:ebay/view/favouritepage/favouritepage.dart';
import 'package:ebay/view/hompage/component/gallery_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final FirestoreController auctionAllpost = Get.put(FirestoreController());
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          // appbar
          Container(
            margin: const EdgeInsets.only(left: 20, right: 30, top: 10),
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onSubmitted: (value) {
                      auctionAllpost.auctionpostlist.bindStream(
                          auctionAllpost.getAllauctionpostToFirebase(value));
                    },
                    cursorColor: Appcolors.grey,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Appcolors.grey,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      // enabledBorder: OutlineInputBorder(
                      //     borderSide: BorderSide(color: Appcolors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Appcolors.grey)),
                      border: OutlineInputBorder(),
                      hintText: 'Search',
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Favourite_pages()));
                  },
                  child: const Icon(
                    Icons.shop_rounded,
                    color: Appcolors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const GalleryItem(),
        ],
      ),
    ));
  }
}
