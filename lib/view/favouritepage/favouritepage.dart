import 'package:ebay/controller/favourite_controller.dart';
import 'package:ebay/utils/colors.dart';
import 'package:ebay/view/detailspage/product_detailspage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Favourite_pages extends StatelessWidget {
  const Favourite_pages({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final favouritecontroller = Get.put(Favouritecontroller());
    favouritecontroller.getfavouritedata
        .bindStream(favouritecontroller.showFavourite());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Your Favourite",
          style: TextStyle(color: Appcolors.white),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Obx(() => favouritecontroller.getfavouritedata.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: favouritecontroller.getfavouritedata.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: UniqueKey(),
                      background: Container(
                        color: Appcolors.red.withOpacity(0.1),
                        child: const Icon(Icons.delete, color: Appcolors.black),
                      ),
                      onDismissed: (direction) {
                        favouritecontroller.deletefavouriteitme(
                            favouritecontroller.getfavouritedata[index].id!);
                      },
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AuctionDetailsPage(
                                    fromPage: "favouritepage",
                                        auctionAllpost: favouritecontroller
                                            .getfavouritedata[index],
                                        index: index,
                                      )));
                        
                        },
                        child: Container(
                          height: 140,
                          width: double.maxFinite,
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 20),
                          decoration: BoxDecoration(
                              color: Appcolors.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20)),
                          child: Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                //image of cart
                                Container(
                                    height: 110,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Appcolors.grey.withOpacity(0.1)),
                                    child: Image(
                                      height: double.maxFinite,
                                      width: double.maxFinite,
                                      image: NetworkImage(favouritecontroller
                                          .getfavouritedata[index].thumimage!),
                                    )),
                                const SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                favouritecontroller
                                                    .getfavouritedata[index]
                                                    .productname!,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 2),
                                            decoration: BoxDecoration(
                                                color: Appcolors.grey
                                                    .withOpacity(0.2),
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
                                                    favouritecontroller
                                                        .getfavouritedata[index]
                                                        .rating
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color: Appcolors
                                                            .primaryColor,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            "\$${favouritecontroller.getfavouritedata[index].minimumbidprice!.toString()}",
                                            style: const TextStyle(
                                                color: Appcolors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                          const SizedBox(
                                            width: 40,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })
              : const Center(
                  child: Text(
                    "No Favourite Item",
                    style: TextStyle(
                        color: Appcolors.black, fontWeight: FontWeight.bold),
                  ),
                )),
        ],
      ),
    );
  }
}
