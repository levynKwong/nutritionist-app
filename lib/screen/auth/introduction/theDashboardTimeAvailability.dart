import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:meal_aware/screen/nutritionist_home/nutritionistHome_screen.dart';


class theDashboardTimeAvailability extends StatefulWidget {
  const theDashboardTimeAvailability({super.key});

  @override
  State<theDashboardTimeAvailability> createState() => _theDashboardTimeAvailabilityState();
}

class _theDashboardTimeAvailabilityState extends State<theDashboardTimeAvailability> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => NutritionistHome()),
    );
  }

  Widget _buildImage(String assetName, [double width = 400]) {
    return Image.asset('images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    final double width_ = MediaQuery.of(context).size.width;

    var pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: width_ * 0.05, fontWeight: FontWeight.w700),
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
          title: "Time Availability",
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Flexible(
                child: Text(
                  "This is the time availability page. This page will show the time that you are available. ",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          decoration: pageDecoration.copyWith(
            bodyFlex: 3,
            imageFlex: 8,
            bodyAlignment: Alignment.bottomCenter,
            imageAlignment: Alignment.topCenter,
          ),
          image: _buildImage('d5.jpg'),
          reverse: true,
        ),
        PageViewModel(
          title: "Time Availability toggle", 
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Flexible(
                child: Text(
                  "You can toggle the time availability for your client to make the appointment.",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          decoration: pageDecoration.copyWith(
            bodyFlex: 3,
            imageFlex: 8,
            bodyAlignment: Alignment.bottomCenter,
            imageAlignment: Alignment.topCenter,
          ),
          image: _buildImage('n1.jpg'),
          reverse: true,
        ),
        PageViewModel(
          title: "Client side",
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Flexible(
                child: Text(
                  "This is how the available time will be displayed in client side. The client can make an appointment by clicking the time slot.",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          decoration: pageDecoration.copyWith(
            bodyFlex: 3,
            imageFlex: 8,
            bodyAlignment: Alignment.bottomCenter,
            imageAlignment: Alignment.topCenter,
          ),
          image: _buildImage('t2.jpg'),
          reverse: true,
        ),
        PageViewModel(
          title: "Lock",
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Flexible(
                child: Text(
                  "This lock should not be touched, this is used to lock people when multiple people are making purchase",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          decoration: pageDecoration.copyWith(
            bodyFlex: 3,
            imageFlex: 8,
            bodyAlignment: Alignment.bottomCenter,
            imageAlignment: Alignment.topCenter,
          ),
          image: _buildImage('t1.jpg'),
          reverse: true,
        ),

        PageViewModel(
          title: "Unlock when needed",
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Flexible(
                child: Text(
                  "In case an error is occuring, you can unlock the time slot by clicking the lock button. Be careful when using this button.",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          decoration: pageDecoration.copyWith(
            bodyFlex: 3,
            imageFlex: 8,
            bodyAlignment: Alignment.bottomCenter,
            imageAlignment: Alignment.topCenter,
          ),
          image: _buildImage('t1.jpg'),
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
