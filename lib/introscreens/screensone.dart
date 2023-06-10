import 'package:flutter/material.dart';

class OnboardingScreenOne extends StatefulWidget {
  @override
  State<OnboardingScreenOne> createState() => _OnboardingScreenOneState();
}

class _OnboardingScreenOneState extends State<OnboardingScreenOne> {
  @override
  Widget build(BuildContext context) {
    //it will helps to return the size of the screen
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/screen1.png",
              height: 200,
            ),
            Text(
              'Wide range of\nCategories & more',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                "Browse through our extensive list of restaurants and dishes, and when you're ready to order, simply add your desired items to your cart and checkout. It's that easy!",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ));
  }
}
