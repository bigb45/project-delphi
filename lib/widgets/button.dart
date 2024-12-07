import 'package:flutter/material.dart';
import 'package:project_delphi/util.dart';

class Button extends StatefulWidget {
  final ButtonStyle buttonStyle;
  final VoidCallback? onPressed;
  final String text;
  final IconData? trailingIcon;
  final IconData? leadingIcon;
  final bool isLoading;

  const Button({
    Key? key,
    this.buttonStyle = ButtonStyle.primary,
    required this.text,
    this.trailingIcon,
    this.leadingIcon,
    this.isLoading = false,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  bool isPressed = false;

  bool get isEnabled => widget.onPressed != null && !widget.isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final secondaryColor = theme.colorScheme.secondary;

    final Widget leading = widget.isLoading
        ? const SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(strokeWidth: 3),
          )
        : widget.leadingIcon != null
            ? Icon(widget.leadingIcon, size: 24, color: secondaryColor)
            : const SizedBox();

    final Widget trailing = widget.trailingIcon != null
        ? Icon(widget.trailingIcon, size: 24, color: secondaryColor)
        : const SizedBox();

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
          width: double.infinity,
          decoration: BoxDecoration(
            color: theme.colorScheme.inversePrimary,
            borderRadius: FullyRounded.circular(),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                leading,
                if (widget.leadingIcon != null || widget.isLoading)
                  const SizedBox(width: 8),
                Text(
                  widget.text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: secondaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                if (widget.trailingIcon != null) const SizedBox(width: 8),
                trailing,
              ],
            ),
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
