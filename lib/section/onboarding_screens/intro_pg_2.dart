import 'package:flutter/material.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: Column(
        children: [
          SizedBox(
            height: 250,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Compare same products from different websites",
              style: TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              "lib/images/compare.gif",
              height: 200,
              width: 200,
            ),
          ),
        ],
      ),
    );
  }
}
