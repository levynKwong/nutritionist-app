import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:meal_aware/screen/nutritionist_home/nutritionistHome_screen.dart';

class introductionNutritionist extends StatefulWidget {
  const introductionNutritionist({super.key});

  @override
  State<introductionNutritionist> createState() =>
      _introductionNutritionistState();
}

class _introductionNutritionistState extends State<introductionNutritionist> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => NutritionistHome()),
    );
  }

  // Widget _buildFullscreenImage() {
  //   return Image.asset(
  //     '1.jpg',
  //     fit: BoxFit.cover,
  //     height: double.infinity,
  //     width: double.infinity,
  //     alignment: Alignment.center,
  //   );
  // }

  Widget _buildImage(String assetName, [double width = 500]) {
    return Image.asset('images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      autoScrollDuration: 4000,
      globalHeader: Align(
        alignment: Alignment.topRight,
        // child: SafeArea(
        //   child: Padding(
        //     padding: const EdgeInsets.only(top: 16, right: 16),
        //     child: _buildImage('1.jpg', 100),
        //   ),
        // ),
      ),
      // globalFooter: SizedBox(
      //   width: double.infinity,
      //   height: 60,
      //   child: ElevatedButton(
      //     child: const Text(
      //       'Let\'s go right away!',
      //       style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      //     ),
      //     onPressed: () => _onIntroEnd(context),
      //   ),
      // ),
      pages: [
        PageViewModel(
          title: "Welcome to MealAware",
          body:
              "MealAware is a platform that helps you to track your daily food intake and provide you with a healthy diet plan.\n\n Let's get started!",
          image: _buildImage('nutritionist_photo.png', 300),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Dashboard",
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Flexible(
                child: Text(
                  "Welcome to your dashboard, here you can look for your clients appointment schedule and place the time slot for your clients",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          decoration: pageDecoration.copyWith(
            bodyFlex: 2,
            imageFlex: 8,
            bodyAlignment: Alignment.bottomCenter,
            imageAlignment: Alignment.topCenter,
          ),
          image: _buildImage('n5.jpg'),
          reverse: true,
        ),
        PageViewModel(
          title: "Time availability",
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Flexible(
                child: Text(
                  "This page is where you can set your time availability for your clients to book an appointment with you.",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          decoration: pageDecoration.copyWith(
            bodyFlex: 2,
            imageFlex: 8,
            bodyAlignment: Alignment.bottomCenter,
            imageAlignment: Alignment.topCenter,
          ),
          image: _buildImage('n1.png'),
          reverse: true,
        ),
        PageViewModel(
          title: "Form",
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Flexible(
                child: Text(
                  "This page allows you to fill in questions for your clients to answer before they chat with you.",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          decoration: pageDecoration.copyWith(
            bodyFlex: 2,
            imageFlex: 8,
            bodyAlignment: Alignment.bottomCenter,
            imageAlignment: Alignment.topCenter,
          ),
          image: _buildImage('n4.jpg'),
          reverse: true,
        ),
        PageViewModel(
          title: "Message your clients",
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Flexible(
                child: Text(
                  " This page allows you to chat with your clients and help them to achieve their goal",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          decoration: pageDecoration.copyWith(
            bodyFlex: 2,
            imageFlex: 8,
            bodyAlignment: Alignment.bottomCenter,
            imageAlignment: Alignment.topCenter,
          ),
          image: _buildImage('n2.jpg'),
          reverse: true,
        ),
        PageViewModel(
          title: "Profile Page",
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Flexible(
                child: Text(
                  "Here are all your details, if you want to edit it, contact us",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          decoration: pageDecoration.copyWith(
            bodyFlex: 2,
            imageFlex: 8,
            bodyAlignment: Alignment.bottomCenter,
            imageAlignment: Alignment.topCenter,
          ),
          image: _buildImage('n3.jpg'),
          reverse: true,
        ),
        PageViewModel(
          title: "Client History",
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Flexible(
                child: Text(
                  "This page allows you to view your Client History ",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          decoration: pageDecoration.copyWith(
            bodyFlex: 2,
            imageFlex: 8,
            bodyAlignment: Alignment.bottomCenter,
            imageAlignment: Alignment.topCenter,
          ),
          image: _buildImage('n6.jpg'),
          reverse: true,
        ),
        PageViewModel(
          title: "Thanks for using MealAware",
          body:
              "We are delighted to have you as part of our community. Our app is designed to make your life easier and more enjoyable.\n\nExplore the features, connect with other users, and unlock exciting opportunities.\n\nWe hope you have a fantastic experience!",
          image: _buildImage('nutritionist_photo.png', 300),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
//onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
//rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back, color: Color(0xFF575ecb)),
      skip: const Text('Skip',
          style:
              TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF575ecb))),
      next: const Icon(Icons.arrow_forward, color: Color(0xFF575ecb)),
      done: const Text('Done',
          style:
              TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF575ecb))),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
