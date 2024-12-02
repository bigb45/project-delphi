import 'package:flutter/material.dart';
import 'package:project_delphi/util.dart';

class Button extends StatefulWidget {
  final VoidCallback? onPressed;
  final String text;
  final IconData? trailingIcon;
  final IconData? leadingIcon;
  final bool isLoading;
  const Button({
    super.key,
    required this.text,
    this.trailingIcon,
    this.leadingIcon,
    this.isLoading = false,
    required this.onPressed,
  });

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  bool isPressed = false;
  late bool isEnabled;
  @override
  void initState() {
    super.initState();
    isEnabled = widget.onPressed != null && widget.isLoading == false;
  }

  @override
  Widget build(BuildContext context) {
    Widget leading = const SizedBox();
    if (widget.isLoading) {
      leading = const SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(
          strokeWidth: 3,
        ),
      );
    } else if (widget.leadingIcon != null) {
      leading = Icon(
        widget.leadingIcon,
        size: 24,
        color: Theme.of(context).colorScheme.secondary,
      );
    } else {
      leading = const SizedBox();
    }

    return GestureDetector(
      onTap: () {
        if (isEnabled) {
          widget.onPressed!();
        }
      },
      onTapDown: (_) {
        if (isEnabled) {
          setState(() {
            isPressed = true;
          });
        }
      },
      onTapUp: (_) {
        if (isEnabled) {
          setState(() {
            isPressed = false;
          });
        }
      },
      child: Card(
        elevation: isPressed ? 0 : 2,
        shape: RoundedRectangleBorder(
          borderRadius: FullyRounded.circular(),
        ),
        child: Container(
          height: 48,
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.inversePrimary,
            borderRadius: FullyRounded.circular(),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                leading,
                const SizedBox(width: 8),
                Text(
                  widget.text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  widget.trailingIcon,
                  size: 24,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
