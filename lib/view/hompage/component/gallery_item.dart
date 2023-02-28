import 'package:ebay/controller/firestore_controller.dart';
import 'package:ebay/view/detailspage/product_detailspage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GalleryItem extends StatelessWidget {
  const GalleryItem({super.key});
  @override
  Widget build(BuildContext context) {
    final FirestoreController auctionAllpost = Get.put(FirestoreController());
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        Obx(
          () => Expanded(
            child: GridView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: auctionAllpost.auctionpostlist.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    childAspectRatio: MediaQuery.of(context).size.width < 360
                        ? 5 / 9
                        : 5 / 7),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                   AuctionDetailsPage(auctionAllpost: auctionAllpost.auctionpostlist[index],index: index,)));
                    },
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(auctionAllpost
                                            .auctionpostlist[index].thumimage
                                            .toString())),
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.grey.withOpacity(0.3),
                                        style: BorderStyle.solid)),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: 130,
                                child: Text(
                                  auctionAllpost
                                      .auctionpostlist[index].productname
                                      .toString(),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                  " \$${auctionAllpost.auctionpostlist[index].minimumbidprice.toString()}",
                                  style: const TextStyle(color: Colors.black))
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        )
      ],
    );
  }
}
