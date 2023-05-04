import 'package:ebay/controller/firestore_controller.dart';
import 'package:ebay/utils/colors.dart';
import 'package:ebay/view/detailspage/product_detailspage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GalleryItem extends StatelessWidget {
  const GalleryItem({super.key});
  @override
  Widget build(BuildContext context) {
    final FirestoreController auctionAllpost = Get.put(FirestoreController());
    return Obx(
      () => Expanded(
        child: auctionAllpost.auctionpostlist.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : GridView.builder(
                padding: const EdgeInsets.only(top: 0),
                shrinkWrap: true,
                primary: false,
                itemCount: auctionAllpost.auctionpostlist.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: MediaQuery.of(context).size.width < 360
                        ? 5 / 9
                        : 5 / 6),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AuctionDetailsPage(
                                    fromPage: "homepage",
                                    auctionAllpost:
                                        auctionAllpost.auctionpostlist[index],
                                    index: index,
                                  )));
                    },
                    child: Stack(
                      children: [
                        Container(
                          height: 200,
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          decoration:
                              const BoxDecoration(color: Appcolors.white),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 120,
                                width: 150,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(auctionAllpost
                                            .auctionpostlist[index].thumimage
                                            .toString())),
                                    color: Appcolors.white,
                                    border: Border.all(
                                        color: Appcolors.grey.withOpacity(0.3),
                                        style: BorderStyle.solid)),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                auctionAllpost
                                    .auctionpostlist[index].productname
                                    .toString(),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Appcolors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 2),
                                      decoration: BoxDecoration(
                                          color:
                                              Appcolors.grey.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 20,
                                          ),
                                          Text(
                                              auctionAllpost
                                                  .auctionpostlist[index].rating
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Appcolors.primaryColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 80,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Text(
                                            "৳${auctionAllpost.auctionpostlist[index].minimumbidprice.toString()}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Appcolors.primaryColor,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
      ),
    );
  }
}
