import 'dart:io';

import 'package:ebay/controller/firestore_controller.dart';
import 'package:ebay/model/user_input_auction_post_model.dart';
import 'package:ebay/service/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddAuctionPostPage extends StatefulWidget {
  const AddAuctionPostPage({super.key});

  @override
  State<AddAuctionPostPage> createState() => _AddAuctionPostPageState();
}

class _AddAuctionPostPageState extends State<AddAuctionPostPage> {
  final FirestoreController firestoreController =
      Get.put(FirestoreController());
  List<File> _images = [];

  final picker = ImagePicker();

  Future getImageFromGallery() async {
    // ignore: deprecated_member_use
    final pickedFiles = await picker.getMultiImage();

    setState(() {
      _images = pickedFiles != null
          ? pickedFiles.map((file) => File(file.path)).toList()
          : [];
    });
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _images.add(File(pickedFile.path));
      }
    });
  }

  late TextEditingController productnamecontroller;
  late TextEditingController productdescriptioncontroller;
  late TextEditingController minimumbidpricecontroller;
  late TextEditingController auctionenddatecontroller;
  @override
  void initState() {
    productnamecontroller = TextEditingController();
    productdescriptioncontroller = TextEditingController();
    minimumbidpricecontroller = TextEditingController();
    auctionenddatecontroller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    productnamecontroller.dispose();
    productdescriptioncontroller.dispose();
    minimumbidpricecontroller.dispose();
    auctionenddatecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 50),
              child: const Center(
                  child: Text(
                "Add Auction Post",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              )),
            ),
            const SizedBox(
              height: 100,
            ),
            Container(
              margin: const EdgeInsets.only(left: 30, right: 30),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: Form(
                  child: Column(
                children: [
                  TextFormField(
                    controller: productnamecontroller,
                    decoration: const InputDecoration(
                      hintText: "Product Name",
                    ),
                  ),
                  TextFormField(
                    controller: productdescriptioncontroller,
                    decoration: const InputDecoration(
                      hintText: "Product Description",
                    ),
                  ),
                  TextFormField(
                    controller: minimumbidpricecontroller,
                    decoration: const InputDecoration(
                      hintText: "Minimum Bid Price",
                    ),
                  ),
                  TextField(
                    controller: auctionenddatecontroller,
                    showCursor: false,
                    onTap: () {
                      getDateFormate(context);
                    },
                    onChanged: (value) {},
                    decoration: const InputDecoration(
                      hintText: "Auction End Date",
                    ),
                  ),
                ],
              )),
            ),
            const SizedBox(
              height: 20,
            ),
            _images.isEmpty
                ? const Text("No images selected")
                : Center(
                    child: Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      padding: const EdgeInsets.only(right: 20),
                      height: 100,
                      child: Row(
                          children: _images
                              .map((image) => Image.file(image))
                              .toList()),
                    ),
                  ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_images.length >= 3) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('You can only select 3 images'),
                        ),
                      );
                    } else {
                      getImageFromGallery();
                    }
                  },
                  child: const Text('Select Images from Gallery'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_images.length >= 3) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('You can only select 3 images'),
                        ),
                      );
                    } else {
                      getImageFromCamera();
                    }
                  },
                  child: const Text('Take a Picture'),
                ),
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            Container(
              margin: const EdgeInsets.only(left: 30, right: 30),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                      ),
                      onPressed: () async {
                        if (productnamecontroller.text.isEmpty ||
                            productdescriptioncontroller.text.isEmpty ||
                            minimumbidpricecontroller.text.isEmpty ||
                            auctionenddatecontroller.text.isEmpty) {
                          Get.snackbar("error", "filed is empty");
                        } else {
                          List<String> images = await FirebaseServicess()
                              .uploadImagesToFirebaseStorage(_images);
                          InputAuctionPostModel auctionPostModel =
                              InputAuctionPostModel(
                                  productname:
                                      productdescriptioncontroller.text,
                                  productdescription:
                                      productdescriptioncontroller.text,
                                  minimumbidprice:
                                      minimumbidpricecontroller.text,
                                  auctionenddate: auctionenddatecontroller.text,
                                  images: images);
                          firestoreController
                              .addauctionpostToFirebase(auctionPostModel);
                        }
                      },
                      child: const Text("Add Auction Post"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getDateFormate(context) async {
    DateTime? pikcerTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    auctionenddatecontroller.text = pikcerTime.toString().split(" ")[0];
  }
}
