import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Timer(
    //   Duration(seconds: 2),
    //   () => Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => HomePage(),
    //     ),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      backgroundColor: Colors.grey[50],
      body: SizedBox(
        // padding: EdgeInsets.only(bottom: 250),
        // color: Colors.white,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 150,
            ),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                'lib/images/logo.png',
                width: 100,
                height: 100,
                // fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 350,
            ),
            // CircularProgressIndicator(
            //   backgroundColor: Colors.white,
            //   color: Colors.white,
            //   valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
            // ),
            Image.asset("lib/images/gloading.gif",height: 100,width: 100,)
            // SizedBox(height: 218,),
          ],
        ),
      ),
    );
  }
}
