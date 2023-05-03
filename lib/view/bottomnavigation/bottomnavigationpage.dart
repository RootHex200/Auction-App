import 'package:ebay/controller/navigationcontroller.dart';
import 'package:ebay/utils/colors.dart';
import 'package:ebay/view/dashboardview/dashboard_page.dart';
import 'package:ebay/view/hompage/homepage.dart';
import 'package:ebay/view/mypostedpage/mypost_page.dart';
import 'package:ebay/view/settingpage/user_setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

List pages = [
  const Homepage(),
  const MystorePage(),
  const DashBoardPage(),
  const SettingPage()
];

class BottomNavigationPage extends StatelessWidget {
  const BottomNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    controller.currentvalue.value = 0;
    return Obx(
      () => WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return Future.value(false);
        },
        child: Scaffold(
          body: pages[controller.currentvalue.value],
          bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Appcolors.primaryColor,
              unselectedItemColor: Appcolors.grey,
              selectedIconTheme:
                  const IconThemeData(color: Appcolors.primaryColor),
              unselectedIconTheme: const IconThemeData(color: Appcolors.grey),
              currentIndex: controller.currentvalue.value,
              onTap: (value) {
                controller.currentindex(value);
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.store), label: 'My Store'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard), label: 'dashboard'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'profile'),
              ]),
        ),
      ),
    );
  }
}
