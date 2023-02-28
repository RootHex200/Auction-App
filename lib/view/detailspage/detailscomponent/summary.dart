import 'package:flutter/material.dart';


class Summary extends StatelessWidget {
  final String description;
  const Summary({super.key, required this.description});

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
                color: Colors.green,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            description.toString(),
            textAlign: TextAlign.justify,
            style: const TextStyle(
              color: Colors.black54,
            ),
          )
        ],
      ),
    );
  }
}
