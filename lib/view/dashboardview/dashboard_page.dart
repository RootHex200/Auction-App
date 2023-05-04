import 'package:ebay/view/dashboardview/component/completed_bids.dart';
import 'package:ebay/view/dashboardview/component/completed_bids_toal_value.dart';
import 'package:ebay/view/dashboardview/component/running_bids.dart';
import 'package:flutter/material.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
                children: const [
            RunningBidTimeSeriesChart(),
            SizedBox(
              height: 20,
            ),
            CompletedBidTimeSeriesChart(),
            SizedBox(height: 20,),
            CompletedBidTotalPriceTimeSeriesChart(),
                ],
              ),
          ),
        ));
  }
}
