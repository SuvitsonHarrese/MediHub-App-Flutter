import 'package:flutter/material.dart';
import 'package:medicine_hub/login/auth.dart';
import 'package:medicine_hub/section/onboarding_screens/intro_pg_1.dart';
import 'package:medicine_hub/section/onboarding_screens/intro_pg_2.dart';
import 'package:medicine_hub/section/onboarding_screens/intro_pg_3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
// controller to keep tarck of which page we're on
  PageController controller = PageController();

// keep track of if we are on the last page or not
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller,
            onPageChanged: ((index) {
              setState(() {
                onLastPage = (index == 2);
              });
            }),
            children: const [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),
          Container(
            alignment: Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // skip
                GestureDetector(
                  onTap: () {
                    controller.jumpToPage(2);
                  },
                  child: Text("skip"),
                ),

                SmoothPageIndicator(controller: controller, count: 3),

                // next or done
                !onLastPage
                    ? GestureDetector(
                        onTap: () {
                          controller.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        child: Text("next"),
                      )
                    : GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return AuthPage();
                              },
                            ),
                          );
                        },
                        child: Text(
                          "done",
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
