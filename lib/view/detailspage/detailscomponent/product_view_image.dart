import 'package:ebay/utils/colors.dart';
import 'package:ebay/view/detailspage/detailscomponent/carousel_slider.dart';
import 'package:flutter/material.dart';

class ProductImageView extends StatelessWidget {
  final List<dynamic> image;
  final discount;
  const ProductImageView(
      {super.key, required this.image, required this.discount});

  @override
  Widget build(BuildContext context) {
    List<String> images = [];
    for (int i = 0; i < image.length; i++) {
      images.add(image[i].toString());
    }
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Center(
            child: CarouselSlider(
          image: images,
        )),
        const Divider(
          color: Appcolors.grey,
          thickness: 2,
          height: 2,
        ),
      ]),
    );
  }
}
