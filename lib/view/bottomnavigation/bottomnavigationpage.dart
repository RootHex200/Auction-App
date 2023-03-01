import 'dart:ffi';

import 'package:ebay/controller/navigationcontroller.dart';
import 'package:ebay/service/firebase_service.dart';
import 'package:ebay/view/dashboardview/component/running_bids.dart';
import 'package:ebay/view/dashboardview/dashboard_page.dart';
import 'package:ebay/view/hompage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

List pages = [const DashBoardPage(), const Homepage()];

class BottomNavigationPage extends StatelessWidget {
  const BottomNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    return Obx(
      () => Scaffold(
        body: pages[controller.currentvalue.value],
        bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.green,
            unselectedItemColor: Colors.grey,
            selectedIconTheme: IconThemeData(color: Colors.green),
            unselectedIconTheme: IconThemeData(color: Colors.grey),
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
    );
  }
}
