import 'package:flutter/material.dart';
import 'package:project_delphi/util.dart';

class Button extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData? trailingIcon;
  final IconData? leadingIcon;
  const Button({
    super.key,
    required this.text,
    this.trailingIcon,
    this.leadingIcon,
    required this.onPressed,
  });

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
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
              // if (widget.leadingIcon != null)
              Icon(
                widget.leadingIcon,
                color: Theme.of(context).colorScheme.secondary,
              ),
              Text(
                widget.text,
                // TODO: extract text style to theme
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Icon(
                widget.trailingIcon,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
