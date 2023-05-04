import 'package:ebay/controller/firestore_controller.dart';
import 'package:ebay/utils/colors.dart';
import 'package:ebay/utils/strings.dart';
import 'package:ebay/utils/widgets/dialog_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FirestoreController firestoreController =
        Get.put(FirestoreController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Profile"),
      ),
      body: Column(
        children: [
          Container(
            height: 70,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 20, right: 20, top: 40),
            decoration: BoxDecoration(
                color: Appcolors.primaryColor,
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              children: [
                //IMAGE view
                const SizedBox(width: 10),
                const CircleAvatar(
                  radius: 25,
                  child: Icon(Icons.person),
                ),
                const SizedBox(width: 10),
                Expanded(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      firestoreController.userinfo.value.username.toString(),
                      style: const TextStyle(
                          color: Appcolors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                    Text(
                      firestoreController.userinfo.value.email.toString(),
                      style: const TextStyle(color: Appcolors.white),
                    )
                  ],
                )),

                const Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(
                      Icons.edit,
                      size: 30,
                      color: Appcolors.white,
                    ))
              ],
            ),
          ),
          const SizedBox(height: 25),
          ListView.builder(
              itemCount: setting.length,
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    switch (index) {
                      case 3:
                        showDialog(
                            context: context,
                            builder: (context) => const AuctionAlartDiolog(
                                  title: "Log Out",
                                  content: "Do you really want to logout?",
                                  lftbtn: "YES",
                                  rtbtn: "No",
                                ));
                        break;
                      case 2:
                        showDialog(
                            context: context,
                            builder: (context) => const AuctionAlartDiolog(
                                  title: "Delete Account",
                                  content:
                                      "Do you really want to Delete Account?",
                                  lftbtn: "YES",
                                  rtbtn: "No",
                                ));
                        break;
                    }
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundColor: Appcolors.primaryColor.withOpacity(0.3),
                      child: Image.asset(
                        "${setting[index]["icon"]}",
                        color: Appcolors.primaryColor,
                        height: 28,
                        //width: 20,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Appcolors.black,
                      size: 25,
                    ),
                    title: Text(
                      setting[index]["title"].toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      setting[index]["subtitle"].toString(),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
