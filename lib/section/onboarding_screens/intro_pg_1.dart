import 'package:flutter/material.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

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
              "Search for products",
              style: TextStyle(fontSize: 20,),
              textAlign: TextAlign.center,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              "lib/images/123.gif",
              height: 200,
              width: 200,
            ),
          ),
        ],
      ),
    );
  }
}
