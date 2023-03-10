import 'package:ebay/controller/navigationcontroller.dart';
import 'package:ebay/view/dashboardview/dashboard_page.dart';
import 'package:ebay/view/hompage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

List pages = [const Homepage(), const DashBoardPage()];

class BottomNavigationPage extends StatelessWidget {
  const BottomNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Obx(
      () => WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return Future.value(false);
        },
        child: Scaffold(
          body: pages[controller.currentvalue.value],
          bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Colors.green,
              unselectedItemColor: Colors.grey,
              selectedIconTheme: const IconThemeData(color: Colors.green),
              unselectedIconTheme: const IconThemeData(color: Colors.grey),
              currentIndex: controller.currentvalue.value,
              onTap: (value) {
                controller.currentindex(value);
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard), label: 'dashboard'),
              ]),
        ),
      ),
    );
  }
}
