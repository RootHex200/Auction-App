
import 'package:ebay/view/AddAuctionPostPage/add_auctionPost_page.dart';
import 'package:ebay/view/hompage/component/gallery_item.dart';
import 'package:ebay/view/hompage/component/my_posted_items.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: AppBar(
            backgroundColor: Colors.green,
            bottom: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: "Gallery"),
                Tab(text: "My posted items"),
              ],
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            GalleryItem(),
            MyPostedItem(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
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
