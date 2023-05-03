// ignore: file_names
import 'package:ebay/controller/firestore_controller.dart';
import 'package:ebay/controller/image_controller.dart';
import 'package:ebay/model/user_input_auction_post_model.dart';
import 'package:ebay/service/firebase_service.dart';
import 'package:ebay/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAuctionPostPage extends StatefulWidget {
  const AddAuctionPostPage({super.key});

  @override
  State<AddAuctionPostPage> createState() => _AddAuctionPostPageState();
}

class _AddAuctionPostPageState extends State<AddAuctionPostPage> {
  final FirestoreController firestoreController =
      Get.put(FirestoreController());
  final ImageController productUpload = Get.put(ImageController());

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
      appBar: AppBar(
        title: const Text("Add Auction Post"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
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
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Appcolors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Appcolors.black),
                      ),
                      hintText: "Product Name",
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: productdescriptioncontroller,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Appcolors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Appcolors.black),
                      ),
                      hintText: "Product Description",
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: minimumbidpricecontroller,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Appcolors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Appcolors.black),
                      ),
                      hintText: "Minimum Bid Price",
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: auctionenddatecontroller,
                    showCursor: false,
                    readOnly: true,
                    onTap: () {
                      getDateFormate(context);
                    },
                    onChanged: (value) {},
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Appcolors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Appcolors.black),
                      ),
                      hintText: "Auction End Date",
                    ),
                  ),
                ],
              )),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(() => productUpload.images.isEmpty
                ? const Text("No images selected")
                : Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    padding: const EdgeInsets.only(right: 20),
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          productUpload.images.length >= 3
                              ? 3
                              : productUpload.images.length, (index) {
                        return Stack(
                          children: [
                            Image.file(productUpload.images[index]),
                            Positioned(
                                top: 0,
                                right: 0,
                                child: GestureDetector(
                                    onTap: () {
                                      productUpload.images.removeAt(index);
                                    },
                                    child: const Icon(
                                      Icons.remove_circle,
                                      color: Colors.red,
                                    ))),
                          ],
                        );
                      }),
                    ),
                  )),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (productUpload.images.length >= 3) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('You can only select 3 images'),
                        ),
                      );
                    } else {
                      productUpload.getImageFromGallery();
                    }
                  },
                  child: const Text(
                    'Select Images from Gallery',
                    style: TextStyle(color: Appcolors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (productUpload.images.length >= 3) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(milliseconds: 500),
                          content: Text('You can only select 3 images'),
                        ),
                      );
                    } else {
                      productUpload.getImageFromCamera();
                    }
                  },
                  child: const Text('Take a Picture',
                      style: TextStyle(color: Appcolors.white)),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Obx(
              () => Container(
                margin: const EdgeInsets.only(left: 30, right: 30),
                child: productUpload.isproductUploadLoading.value
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator(),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Please Wait data is uploading..."),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                if (productnamecontroller.text.isEmpty ||
                                    productdescriptioncontroller.text.isEmpty ||
                                    minimumbidpricecontroller.text.isEmpty ||
                                    auctionenddatecontroller.text.isEmpty ||
                                    productUpload.images.isEmpty) {
                                  Get.snackbar("error", "filed is empty",backgroundColor: Appcolors.black,colorText: Appcolors.white);
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: const Text(
                                              "You Want to Add New Auction Post"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("cancel")),
                                            TextButton(
                                                onPressed: () async {
                                                  Navigator.of(context).pop();

                                                  productUpload
                                                      .isproductUploadLoading
                                                      .value = true;

                                                  List<String> images =
                                                      await FirebaseServicess()
                                                          .uploadImagesToFirebaseStorage(
                                                              productUpload
                                                                  .images);
                                                  InputAuctionPostModel
                                                      auctionPostModel =
                                                      InputAuctionPostModel(
                                                          productname:
                                                              productnamecontroller
                                                                  .text,
                                                          productdescription:
                                                              productdescriptioncontroller
                                                                  .text,
                                                          minimumbidprice:
                                                              minimumbidpricecontroller
                                                                  .text,
                                                          auctionenddate:
                                                              auctionenddatecontroller
                                                                  .text,
                                                          images: images);
                                                  firestoreController
                                                      .addauctionpostToFirebase(
                                                          auctionPostModel);

                                                  productUpload
                                                      .isproductUploadLoading
                                                      .value = false;

                                                  // ignore: use_build_context_synchronously
                                                },
                                                child: const Text("ok")),
                                          ],
                                        );
                                      });
                                }
                              },
                              child: const Text("Add Auction Post"),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(
              height: 10,
            )
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

    if (pikcerTime != null) {
     auctionenddatecontroller.text = pikcerTime.toString().split(" ")[0]; 
    }else{
      auctionenddatecontroller.text = "";
    }
  }
}
