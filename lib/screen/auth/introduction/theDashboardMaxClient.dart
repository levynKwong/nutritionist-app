import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'package:meal_aware/screen/customer_widget.dart/helpPageNutritionist.dart';


class TheDashboardPendingMaxClient extends StatefulWidget {
  const TheDashboardPendingMaxClient({super.key});

  @override
  State<TheDashboardPendingMaxClient> createState() => _TheDashboardPendingMaxClientState();
}

class _TheDashboardPendingMaxClientState extends State<TheDashboardPendingMaxClient> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => helpPageNutritionist()),
    );
  }

  Widget _buildImage(String assetName, [double width = 500]) {
    return Image.asset('images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    var pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Theme.of(context).colorScheme.tertiary,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Theme.of(context).colorScheme.tertiary,
      allowImplicitScrolling: true,
      autoScrollDuration: 4000,
      globalHeader: Align(
        alignment: Alignment.topRight,
      ),

      pages: [
        
        PageViewModel(
          title: "Maximum Chat client",
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Flexible(
                child: Text(
                  "This is the maximum client availability page. This page will show the maximum client that you can have. If you want to increase the maximum client. ",
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
          image: _buildImage('d4.jpg'),
          reverse: true,
        ),
        PageViewModel(
          title: "Set Maximum Client ",
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Flexible(
                child: Text(
                  "You can allow to set the maximum client you want to allow to reach out to you.",
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
          image: _buildImage('m1.jpg'),
          reverse: true,
        ),
        PageViewModel(
          title: "Maximum client reached",
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Flexible(
                child: Text(
                  "A lock button will be toggle automatically when max client reached. You can also toggle it manually. ",
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
          image: _buildImage('m2.jpg'),
          reverse: true,
        ),
        PageViewModel(
          title: "Client side",
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Flexible(
                child: Text(
                  "This is how it will appear on client side when a client want to make a purchase.",
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
          image: _buildImage('m3.jpg'),
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
