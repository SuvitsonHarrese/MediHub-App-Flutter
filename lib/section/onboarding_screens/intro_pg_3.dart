import 'package:flutter/material.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

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
              "Save money by buying products with low price",
              style: TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              "lib/images/save_money.gif",
              height: 200,
              width: 200,
            ),
          ),
        ],
      ),
    );
  }
}