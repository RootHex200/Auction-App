import 'package:ebay/controller/firestore_controller.dart';
import 'package:ebay/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPostedItem extends StatelessWidget {
  const MyPostedItem({super.key});

  @override
  Widget build(BuildContext context) {
    final FirestoreController auctionmypost = Get.put(FirestoreController());
    return Obx(
      () => auctionmypost.myposteditem.isEmpty
          ? const Center(
              child: Text(
                "No Post Found",
                style: TextStyle(
                    color: Appcolors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              itemCount: auctionmypost.myposteditem.length,
              itemBuilder: (context, index) => Dismissible(
                key: UniqueKey(),
                background: Container(
                  color: Appcolors.red.withOpacity(0.1),
                  child: const Icon(Icons.delete, color: Appcolors.black),
                ),
                onDismissed: (direction) {
                 auctionmypost.deleteMypostedItem(
                      auctionmypost.myposteditem[index].id.toString(),auctionmypost.myposteditem[index].images as List<dynamic>);
                 
                },
                child: Container(
                  margin:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  decoration: BoxDecoration(
                      color: Appcolors.white,
                      boxShadow:const  [
                        BoxShadow(
                            color: Appcolors.textSecondaryColor,
                            blurRadius: 5,
                            spreadRadius: 1)
                      ],
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 150,
                          decoration: BoxDecoration(
                            color: Appcolors.primaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: NetworkImage(auctionmypost
                                    .myposteditem[index].thumimage
                                    .toString()),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              auctionmypost.myposteditem[index].productname
                                  .toString(),
                              style: const TextStyle(
                                  color: Appcolors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'End Date:${auctionmypost.myposteditem[index].auctionenddate.toString()}',
                                  style: const TextStyle(
                                      color: Appcolors.primaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Bid Price:${auctionmypost.myposteditem[index].minimumbidprice.toString()}\$',
                                  style: const TextStyle(
                                      color: Appcolors.primaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              auctionmypost
                                  .myposteditem[index].productdescription
                                  .toString(),
                              style: const TextStyle(
                                color: Appcolors.textSecondaryColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
