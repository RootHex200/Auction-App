import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:ebay/controller/firestore_controller.dart';
import 'package:ebay/model/running_bid_model.dart';
import 'package:ebay/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RunningBidTimeSeriesChart extends StatelessWidget {
  const RunningBidTimeSeriesChart({super.key});

  @override
  Widget build(BuildContext context) {
    final FirestoreController firestoreController =
        Get.put(FirestoreController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Running Bids: ${firestoreController.runningbitcount.toString()}",
              style: const TextStyle(color: Appcolors.black, fontSize: 20),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(20),
          height: 250,
          child:charts.TimeSeriesChart(
              _createSampleData(firestoreController.runingBidList),
              animate: false,
              dateTimeFactory: const charts.LocalDateTimeFactory(),
            ),
         
        ),
      ],
    );
  }

  static List<charts.Series<RunningBidModel, DateTime>> _createSampleData(
      bidlist) {

    return [
      charts.Series<RunningBidModel, DateTime>(
        seriesColor: charts.ColorUtil.fromDartColor(Colors.red),
        id: 'bid',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (RunningBidModel bid, _) => bid.time,
        measureFn: (RunningBidModel bid, _) => bid.bidnumber,
        data: bidlist,
      )
    ];
  }
}

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}
