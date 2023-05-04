import 'package:ebay/view/AddAuctionPostPage/add_auctionPost_page.dart';
import 'package:ebay/view/mypostedpage/my_posted_items.dart';
import 'package:flutter/material.dart';

class MystorePage extends StatelessWidget {
  const MystorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("My Posted Item"),
        ),
        body: const SafeArea(child: MyPostedItem()),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddAuctionPostPage()));
          },
          child: const Icon(Icons.add),
        ));
  }
}
