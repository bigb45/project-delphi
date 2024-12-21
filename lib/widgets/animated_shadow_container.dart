import 'package:flutter/material.dart';
import 'package:project_delphi/constants.dart';

class AnimatedShadowContainer extends StatefulWidget {
  final Color color;
  final bool isShadowVisible;
  final Widget child;
  final bool animateShadow;
  const AnimatedShadowContainer({
    super.key,
    required this.isShadowVisible,
    required this.child,
    this.color = Colors.white,
    this.animateShadow = true,
  });

  @override
  _AnimatedShadowContainerState createState() =>
      _AnimatedShadowContainerState();
}

class _AnimatedShadowContainerState extends State<AnimatedShadowContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 0.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleShadow() {
    if (_controller.status == AnimationStatus.completed) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animateShadow && widget.isShadowVisible) {
      toggleShadow();
    } else {
      _controller.reverse();
    }
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: ShadowPainter(
            opacity: widget.animateShadow ? _opacityAnimation.value : 0.2,
            shadowColor:
                Theme.of(context).colorScheme.inverseSurface.withOpacity(0.1),
          ),
          child: widget.child,
        );
      },
    );
  }
}

class ShadowPainter extends CustomPainter {
  final double opacity;
  final Color shadowColor;
  ShadowPainter({required this.opacity, required this.shadowColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = shadowColor
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, kShadowBlurRadius);

    final animatedShadowPaint = Paint()
      ..color = Colors.black.withOpacity(opacity)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, kShadowBlurRadius);

    canvas.drawRect(
      Rect.fromLTRB(0, -kShadowBlurRadius, size.width, 0),
      paint,
    );

    canvas.drawRect(
      Rect.fromLTRB(size.width, 0, size.width + kShadowBlurRadius, size.height),
      paint,
    );

    canvas.drawRect(
      Rect.fromLTRB(
          0, size.height, size.width, size.height + kShadowBlurRadius),
      paint,
    );

    canvas.drawRect(
      Rect.fromLTRB(-kShadowBlurRadius, 0, 0, size.height),
      animatedShadowPaint,
    );
  }

  @override
  bool shouldRepaint(covariant ShadowPainter oldDelegate) {
    return oldDelegate.opacity != opacity;
  }
}
