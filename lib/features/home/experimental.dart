import 'package:flutter/material.dart';

class SeparationAnimation extends StatefulWidget {
  const SeparationAnimation({super.key});

  @override
  _SeparationAnimationState createState() => _SeparationAnimationState();
}

class _SeparationAnimationState extends State<SeparationAnimation> {
  bool _isSeparated = false;
  BorderRadius leftCardBorderRadius = BorderRadius.circular(0);
  BorderRadius rightCardBorderRadius = BorderRadius.circular(0);
  double gap = 0.0;
  static const radius = 16.0;
  static const duration = Duration(milliseconds: 150);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Separation Animation")),
      body: Center(
        child: Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: duration,
                width: 100,
                height: 100,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ], color: Colors.blue, borderRadius: rightCardBorderRadius),
                child: const Center(
                  child: Text(
                    "Child",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              AnimatedContainer(
                duration: duration,
                width: gap,
              ),
              ClipRect(
                clipper: MyClipper(
                  padding: EdgeInsets.only(
                    right: 30,
                    top: 30,
                    bottom: 30,
                    left: gap,
                  ),
                ),
                child: AnimatedContainer(
                  duration: duration,
                  width: 200,
                  height: 100,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                    color: Colors.blue,
                    borderRadius: leftCardBorderRadius,
                  ),
                  child: const Center(
                    child: Text(
                      "Parent",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            leftCardBorderRadius = _isSeparated
                ? BorderRadius.circular(radius)
                : const BorderRadius.only(
                    topRight: Radius.circular(radius),
                    bottomRight: Radius.circular(radius),
                  );
            rightCardBorderRadius = _isSeparated
                ? BorderRadius.circular(radius)
                : const BorderRadius.only(
                    topLeft: Radius.circular(radius),
                    bottomLeft: Radius.circular(radius),
                  );
            gap = _isSeparated ? 16 : 0;

            _isSeparated = !_isSeparated;
          });
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Rect> {
  final EdgeInsets padding;

  const MyClipper({this.padding = EdgeInsets.zero});

  @override
  Rect getClip(Size size) => padding.inflateRect(Offset.zero & size);

  @override
  bool shouldReclip(covariant MyClipper oldClipper) {
    return oldClipper.padding != padding;
  }
}
