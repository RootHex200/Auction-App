import 'package:ebay/utils/colors.dart';
import 'package:flutter/material.dart';

class TitleRatingPrice extends StatelessWidget {
  final String producttitle;
  final String price;
  final String rating;
  final String date;
  const TitleRatingPrice(
      {super.key,
      required this.producttitle,
      required this.price,
      required this.rating,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width - 150,
                  child: Text(
                    producttitle,
                    maxLines: 4,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  )),
              const SizedBox(height: 10),
              Text(
                "End DateTime: $date",
                style: const TextStyle(fontSize: 17),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                        5,
                        (index) => Icon(
                              Icons.star,
                              color: index < int.parse(rating)
                                  ? Appcolors.primaryColor
                                  : Appcolors.grey.withOpacity(0.3),
                            )),
                  ),
                  const SizedBox(width: 20),
                  Text(
                    "($rating)",
                    style: const TextStyle(
                        color: Appcolors.textSecondaryColor, fontSize: 18),
                  )
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
                color: Appcolors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8)),
            child: Center(
                child: Text(
              "৳$price",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Appcolors.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            )),
          )
        ],
      ),
    );
  }
}
