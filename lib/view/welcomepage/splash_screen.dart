import 'package:ebay/service/firebase_service.dart';
import 'package:ebay/utils/colors.dart';
import 'package:ebay/view/athuntication/loginpage/login_page.dart';
import 'package:ebay/view/bottomnavigation/bottomnavigationpage.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (FirebaseServicess().user_current_check().toString().length > 5) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const BottomNavigationPage()),
            (route) => false);
      });
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Login_page()),
            (route) => false);
      });
    }
    return Scaffold(
      backgroundColor: Appcolors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height < 630
                  ? MediaQuery.of(context).size.height / 4
                  : null,
              alignment: Alignment.topRight,
              child:
                  const Image(image: AssetImage('assets/images/splash1.png')),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(image: AssetImage('assets/images/auction.png')),
                RichText(
                    text: const TextSpan(children: [
                  TextSpan(
                      text: "AUCT",
                      style: TextStyle(
                          color: Appcolors.primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: "ION",
                      style: TextStyle(
                          color: Appcolors.secondaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: ".",
                      style: TextStyle(
                          color: Appcolors.primaryColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold)),
                ])),
              ],
            )),
            Container(
              height: MediaQuery.of(context).size.height < 630
                  ? MediaQuery.of(context).size.height / 4
                  : null,
              alignment: Alignment.topLeft,
              child:
                  const Image(image: AssetImage('assets/images/splash2.png')),
            )
          ],
        ),
      ),
    );
  }
}
