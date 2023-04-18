import 'package:flutter/material.dart';

class CouponCodeInput extends StatefulWidget {
  @override
  _CouponCodeInputState createState() => _CouponCodeInputState();
}

class _CouponCodeInputState extends State<CouponCodeInput> {
  final List<TextEditingController> _textControllers =
      List.generate(6, (_) => TextEditingController());

  @override
  void dispose() {
    _textControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width_ = MediaQuery.of(context).size.width;
    final double height_ = MediaQuery.of(context).size.height;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < 6; i++)
          SizedBox(
            width: width_ * 0.12,
            height: height_ * 0.08,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width_ * 0.009),
              child: TextField(
                controller: _textControllers[i],
                maxLength: 1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  counterText: "",
                  contentPadding:
                      EdgeInsets.symmetric(vertical: height_ * 0.025),
                ),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
              ),
            ),
          ),
      ],
    );
  }
}
