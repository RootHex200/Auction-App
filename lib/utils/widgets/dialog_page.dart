import 'package:ebay/service/firebase_service.dart';
import 'package:ebay/utils/colors.dart';
import 'package:ebay/view/welcomepage/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuctionAlartDiolog extends StatelessWidget {
  final String title;
  final String content;
  final String lftbtn;
  final String rtbtn;

  const AuctionAlartDiolog(
      {super.key,
      required this.title,
      required this.content,
      required this.lftbtn,
      required this.rtbtn});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
          child: Text(
        title,
        style: const TextStyle(color: Appcolors.primaryColor),
      )),
      titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold, color: Appcolors.black, fontSize: 20),
      content: Text(
        content,
        textAlign: TextAlign.center,
      ),
      actionsOverflowButtonSpacing: 20,
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        SizedBox(
          height: 35,
          width: 70,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Appcolors.primaryColor, // background
              ),
              onPressed: () async {
                switch (title) {
                  case "Log Out":
                    await FirebaseAuth.instance.signOut();
                    Future.delayed(const Duration(milliseconds: 100), () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SplashScreen()),
                          (route) => false);
                    });
                    break;
                  case "Delete Account":
                    await FirebaseServicess().deletedUser();
                    Future.delayed(const Duration(milliseconds: 100), () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SplashScreen()),
                          (route) => false);
                    });
                    break;
                }
              },
              child: Text(lftbtn)),
        ),
        SizedBox(
          height: 35,
          width: 70,
          child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(rtbtn)),
        ),
      ],
    );
  }
}
