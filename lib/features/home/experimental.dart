import 'package:flutter/material.dart';
import 'package:project_delphi/widgets/animated_shadow_container.dart';

const double _kShadowBlurRadius = 8.0;
const double _kShadowSpreadRadius = 2.0;

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
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedShadowContainer(
                  isShadowVisible: !_isSeparated,
                  animateShadow: false,
                  color: Theme.of(context).colorScheme.surfaceContainerLow,
                  child: AnimatedContainer(
                    duration: duration,
                    height: 53,
                    width: 53,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerLow,
                      borderRadius: rightCardBorderRadius,
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: duration,
                  width: gap,
                ),
                Expanded(
                  child: AnimatedShadowContainer(
                    isShadowVisible: !_isSeparated,
                    color: Theme.of(context).colorScheme.surfaceContainerLow,
                    child: AnimatedContainer(
                      duration: duration,
                      decoration: BoxDecoration(
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.black.withOpacity(0.2),
                        //     blurRadius: 8,
                        //     spreadRadius: 2,
                        //   ),
                        // ],
                        color:
                            Theme.of(context).colorScheme.surfaceContainerLow,
                        borderRadius: leftCardBorderRadius,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16),
                        child: Text(
                          "Where are you?",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
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

// class AnimatedShadowContainer extends StatefulWidget {
//   final Color color;
//   final bool isShadowVisible;
//   final Widget child;
//   final bool animateShadow;
//   const AnimatedShadowContainer({
//     super.key,
//     required this.isShadowVisible,
//     required this.child,
//     this.color = Colors.white,
//     this.animateShadow = true,
//   });

//   @override
//   _AnimatedShadowContainerState createState() =>
//       _AnimatedShadowContainerState();
// }

// class _AnimatedShadowContainerState extends State<AnimatedShadowContainer>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _opacityAnimation;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 150),
//     );

//     _opacityAnimation = Tween<double>(begin: 0, end: 0.2).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void toggleShadow() {
//     if (_controller.status == AnimationStatus.completed) {
//       _controller.reverse();
//     } else {
//       _controller.forward();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (widget.animateShadow && widget.isShadowVisible) {
//       toggleShadow();
//     } else {
//       _controller.reverse();
//     }
//     return AnimatedBuilder(
//       animation: _controller,
//       builder: (context, child) {
//         return CustomPaint(
//           painter: ShadowPainter(
//             opacity: widget.animateShadow ? _opacityAnimation.value : 0.2,
//             shadowColor:
//                 Theme.of(context).colorScheme.inverseSurface.withOpacity(0.1),
//           ),
//           child: widget.child,
//         );
//       },
//     );
//   }
// }

// class ShadowPainter extends CustomPainter {
//   final double opacity;
//   final Color shadowColor;
//   ShadowPainter({required this.opacity, required this.shadowColor});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = shadowColor
//       ..maskFilter =
//           const MaskFilter.blur(BlurStyle.normal, _kShadowBlurRadius);

//     final animatedShadowPaint = Paint()
//       ..color = Colors.black.withOpacity(opacity)
//       ..maskFilter =
//           const MaskFilter.blur(BlurStyle.normal, _kShadowBlurRadius);

//     canvas.drawRect(
//       Rect.fromLTRB(0, -_kShadowBlurRadius, size.width, 0),
//       paint,
//     );

//     canvas.drawRect(
//       Rect.fromLTRB(
//           size.width, 0, size.width + _kShadowBlurRadius, size.height),
//       paint,
//     );

//     canvas.drawRect(
//       Rect.fromLTRB(
//           0, size.height, size.width, size.height + _kShadowBlurRadius),
//       paint,
//     );

//     canvas.drawRect(
//       Rect.fromLTRB(-_kShadowBlurRadius, 0, 0, size.height),
//       animatedShadowPaint,
//     );
//   }

//   @override
//   bool shouldRepaint(covariant ShadowPainter oldDelegate) {
//     return oldDelegate.opacity != opacity;
//   }
// }
