import 'package:flutter/material.dart';

class CustomIconButton extends StatefulWidget {
  final ButtonStyle buttonStyle;
  final VoidCallback? onPressed;
  final IconData icon;
  final bool isLoading;

  const CustomIconButton({
    super.key,
    this.buttonStyle = ButtonStyle.primary,
    required this.icon,
    this.isLoading = false,
    required this.onPressed,
  });

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  bool isPressed = false;

  bool get isEnabled => widget.onPressed != null && !widget.isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondaryColor = theme.hintColor;

    final Widget icon = widget.isLoading
        ? const SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(strokeWidth: 3),
          )
        : Icon(widget.icon, size: 24, color: secondaryColor);

    return GestureDetector(
      onTap: isEnabled ? widget.onPressed : null,
      onTapDown: (_) => _updatePressedState(true),
      onTapUp: (_) => _updatePressedState(false),
      onTapCancel: () => _updatePressedState(false),
      child: ColorFiltered(
        colorFilter: isEnabled
            ? const ColorFilter.mode(Colors.transparent, BlendMode.dst)
            : ColorFilter.mode(
                Theme.of(context).colorScheme.inversePrimary.withOpacity(0.7),
                BlendMode.srcATop),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInOut,
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            // borderRadius: FullyRounded.circular(),
            borderRadius: BorderRadius.circular(11),
            boxShadow: isPressed || !isEnabled
                ? []
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ],
          ),
          child: Center(
            child: icon,
          ),
        ),
      ),
    );
  }

  void _updatePressedState(bool isPressed) {
    if (isEnabled) {
      setState(() {
        this.isPressed = isPressed;
      });
    }
  }
}

enum ButtonStyle {
  primary,
  secondary,
  tertiary,
}
