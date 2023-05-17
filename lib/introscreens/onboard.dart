import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:osar_user/introscreens/screensone.dart';
import 'package:osar_user/introscreens/screensthree.dart';
import 'package:osar_user/introscreens/screenstwo.dart';

class OnBoardingScreens extends StatefulWidget {
  @override
  _OnBoardingScreensState createState() => _OnBoardingScreensState();
}

int currentPage = 0;

final _controller = PageController(initialPage: 0);
List<Widget> _pages = [
  Column(children: [Expanded(child: OnboardingScreenOne())]),
  Column(children: [Expanded(child: OnboardingScreenTwo())]),
  Column(children: [Expanded(child: OnboardingScreenThree())]),
];

class _OnBoardingScreensState extends State<OnBoardingScreens> {
  @override
  Widget build(BuildContext context) {
    //  Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: _controller,
            children: _pages,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
          ),
        ),
        DotsIndicator(
          dotsCount: _pages.length,
          decorator: DotsDecorator(
            color: Colors.black87, // Inactive color
            activeColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
