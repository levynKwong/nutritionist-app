import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:meal_aware/screen/home/home_screen.dart';
import 'package:meal_aware/screen/nutritionist_home/nutritionistHome_screen.dart';

class chatNutritionistHelp extends StatefulWidget {
  const chatNutritionistHelp({super.key});

  @override
  State<chatNutritionistHelp> createState() => _chatNutritionistHelpState();
}

class _chatNutritionistHelpState extends State<chatNutritionistHelp> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => Home()),
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
      autoScrollDuration: 40000,
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
          title: "Chat Nutritionist",
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Flexible(
                child: Text(
                  "Start chatting with your nutritionist",
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
          image: _buildImage('c1.jpg'),
          reverse: true,
        ),
        PageViewModel(
          title: "Chat with your Doctor",
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Flexible(
                child: Text(
                  "",
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
          image: _buildImage('c2.jpg'),
          reverse: true,
        ),
        PageViewModel(
          title: "Choose your Nutritionist",
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
          image: _buildImage('c3.jpg'),
          reverse: true,
        ),
        PageViewModel(
          title: "Purchase",
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Flexible(
                child: Text(
                  "Buy paying you can chat with your nutritionist for a week.",
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
          image: _buildImage('c4.jpg'),
          reverse: true,
        ),
        PageViewModel(
          title: "Start Chatting!",
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Flexible(
                child: Text(
                  "Start chatting with your nutritionist",
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
          image: _buildImage('c7.jpg'),
          reverse: true,
        ),
        PageViewModel(
          title: "Purchase History",
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Flexible(
                child: Text(
                  "Check your purchase history here",
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
          image: _buildImage('c5.jpg'),
          reverse: true,
        ),
        PageViewModel(
          title: "Purchase History",
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Flexible(
                child: Text(
                  "",
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
          image: _buildImage('c6.jpg'),
          reverse: true,
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
