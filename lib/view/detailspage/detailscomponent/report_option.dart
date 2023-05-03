import 'package:ebay/controller/firestore_controller.dart';
import 'package:ebay/model/report_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportOption extends StatefulWidget {
  final String auctionid;
  final String userid;
  const ReportOption({Key? key, required this.auctionid, required this.userid})
      : super(key: key);
  @override
  _ReportOptionState createState() => _ReportOptionState();
}

class _ReportOptionState extends State<ReportOption> {
  final FirestoreController firestoreController =
      Get.put(FirestoreController());
  late TextEditingController _reporttypeController;
  late TextEditingController _reportmessageController;

  @override
  void initState() {
    _reportmessageController = TextEditingController();
    _reporttypeController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                TextField(
                  controller: _reporttypeController,
                  decoration: const InputDecoration(
                    hintText: 'Enter report type',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _reportmessageController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText: 'Enter report message',
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    ReportModel reportModel = ReportModel(
                        auctionid: widget.auctionid,
                        userid: widget.userid,
                        reporttype: _reporttypeController.text,
                        reportmessage: _reportmessageController.text);
                    if (_reportmessageController.text.isNotEmpty &&
                        _reporttypeController.text.isNotEmpty) {
                      firestoreController.report(reportModel);
                    }
                    Future.delayed(const Duration(seconds: 1), () {
                      Navigator.pop(context);
                    });
                  },
                  child: const Text('Submit Report'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
