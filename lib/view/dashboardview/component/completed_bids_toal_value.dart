import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:ebay/controller/firestore_controller.dart';
import 'package:ebay/model/running_bid_model.dart';
import 'package:ebay/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompletedBidTotalPriceTimeSeriesChart extends StatelessWidget {
  const CompletedBidTotalPriceTimeSeriesChart({super.key});

  @override
  Widget build(BuildContext context) {
    final FirestoreController firestoreController =
        Get.put(FirestoreController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Obx(
              ()=> Text(
                "Completed Winning Bid price: ${firestoreController.finaltotalWinningBidprice.value.toString()}",
                style: const TextStyle(color: Appcolors.black, fontSize: 20),
              ),
            ),
          ),
        
        const SizedBox(
          height: 20,
        ),
         Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Obx(
              ()=> Text(
                "Completed bid pirce: ${firestoreController.finalcompletedBidprice.value.toString()}",
                style: const TextStyle(color: Appcolors.black, fontSize: 20),
              ),
            ),
          ),
        
        Container(
          margin: const EdgeInsets.all(20),
          height: 250,
          child: charts.TimeSeriesChart(
                _createSampleData(firestoreController.compelteBidTotalValueList),
                animate: false,
                dateTimeFactory: const charts.LocalDateTimeFactory(),
              ),
          
        
        ),
      ],
    );
  }

  static List<charts.Series<CompletedBidTotalValueModel, DateTime>>
      _createSampleData(bidlist) {


    return [
      charts.Series<CompletedBidTotalValueModel, DateTime>(
        seriesColor: charts.ColorUtil.fromDartColor(Colors.red),
        id: 'bidcompleted',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (CompletedBidTotalValueModel bid, _) => bid.time,
        measureFn: (CompletedBidTotalValueModel bid, _) => bid.bidpirce,
        data: bidlist,
      )
    ];
  }
}
