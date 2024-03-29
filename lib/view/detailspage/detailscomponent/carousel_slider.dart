import 'package:carousel_nullsafety/carousel_nullsafety.dart';
import 'package:ebay/utils/colors.dart';
import 'package:flutter/material.dart';

class CarouselSlider extends StatelessWidget {
  final List<String>? image;
  const CarouselSlider({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SizedBox(
        height: 260,
        width: MediaQuery.of(context).size.width - 100,
        child: Carousel(
          images: List.generate(
            image!.length,
            (index) => NetworkImage(image![index]),
          ),
          borderRadius: true,
          dotBgColor: Colors.transparent,
          dotColor: Appcolors.grey.withOpacity(0.4),
          dotIncreasedColor: Appcolors.primaryColor,
        ),
      ),
    );
  }
}
