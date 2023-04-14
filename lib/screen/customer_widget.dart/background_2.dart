import 'package:flutter/cupertino.dart';

class background2 extends StatelessWidget {
  const background2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Wrap the body in a container to add a gradient background
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF5e8eea),
            Color.fromARGB(255, 214, 225, 249),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -50,
            right: -130,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    Color.fromARGB(0, 81, 100, 153),
                    Color(0xFFe884d0),
                  ],
                  radius: 1,
                  center: Alignment(1, -1),
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -40,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    Color.fromARGB(255, 255, 255, 255),
                    Color(0xFF9553ac),
                  ],
                  radius: 1,
                  center: Alignment(-1, 1),
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
