import 'package:ebay/utils/colors.dart';
import 'package:flutter/material.dart';

class Summary extends StatelessWidget {
  final String description;
  final String sellerPhone;
  const Summary(
      {super.key, required this.description, required this.sellerPhone});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Description',
            style: TextStyle(
                color: Appcolors.primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            description.toString(),
            textAlign: TextAlign.justify,
            style: const TextStyle(
              color: Appcolors.textSecondaryColor,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Seller Details',
            style: TextStyle(
                color: Appcolors.primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          RichText(
              text: TextSpan(children: [
            const TextSpan(
              text: "Phone Number:-   ",
              style: TextStyle(
                color: Appcolors.textSecondaryColor,
              ),
            ),
            TextSpan(
                text: sellerPhone.toString(),
                style: const TextStyle(color: Colors.black)),
          ])),
        ],
      ),
    );
  }
}
