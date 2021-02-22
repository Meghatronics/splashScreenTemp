import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'page_indicator_widget.dart';

class OnboardingView extends StatefulWidget {
  OnboardingView({Key key}) : super(key: key);

  @override
  _OnboardingViewState createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final onboardingData = [
    {
      'title': 'Explore Fresh Organic \nProducts Everyday',
      'sub':
          'Search through a variety of products that help you keep fit and healthy',
      'background': 'onboarding_1.png',
    },
    {
      'title': 'Eat healthy, Spend Wisely.\nBe Happy',
      'sub': 'Discover products by our vendors at very affordable prices ',
      'background': 'onboarding_2.png',
    },
    {
      'title': 'Fast Delivery within 24 hours of purchase',
      'sub':
          'Worried about time? Don’t stress, our products are at our doorstep before sunset',
      'background': 'onboarding_3.png',
    }
  ];

  PageController _pageController;
  Timer _pageAnimationTimer;
  int _page = 0;

  void _animatePages() {
    if (_pageController == null) return;
    if (_page < 2) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 700),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  void initState() {
    _pageController = PageController();
    _pageAnimationTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      _animatePages();
    });

    super.initState();
  }

  @override
  void dispose() {
    _pageAnimationTimer.cancel();
    _pageAnimationTimer = null;
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: [
        //Background
        PageView(
          controller: _pageController,
          onPageChanged: (newPage) {
            setState(() {
              _page = newPage;
            });
          },
          children: [
            Image(
              image: AssetImage(
                  'assets/images/${onboardingData[0]['background']}'),
              fit: BoxFit.cover,
            ),
            Image(
              image: AssetImage(
                  'assets/images/${onboardingData[1]['background']}'),
              fit: BoxFit.cover,
            ),
            Image(
              image: AssetImage(
                  'assets/images/${onboardingData[2]['background']}'),
              fit: BoxFit.cover,
            ),
          ],
        ),
        //Body
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 48.0, horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PageIndicatorWidget(
                count: 3,
                value: _page,
                size: 8,
                spacing: 10,
              ),
              Text(
                onboardingData[_page]['title'],
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 8),
              Text(
                onboardingData[_page]['sub'],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 48.0, bottom: 16.0),
                child: FlatButton(
                  onPressed: () {
                    //TODO Navigate to signin or signup
                  },
                  height: 48,
                  minWidth:
                      MediaQuery.of(context).size.width.clamp(60.0, 400.0),
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  color: Color(0xFF3A953C),
                ),
              ),
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: 'Have an account already? ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                      children: [
                        TextSpan(
                            text: 'Sign In',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // TODO Navigate to sign in
                              }),
                      ]),
                ),
              )
            ],
          ),
        )
      ],
    ));
  }
}
