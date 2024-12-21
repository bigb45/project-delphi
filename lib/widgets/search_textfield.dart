import 'package:flutter/material.dart';

class SearchTextfield extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onTextChanged;
  final String hintText;
  const SearchTextfield({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onTextChanged,
    this.hintText = "Where are you?",
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      onChanged: onTextChanged,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(0),
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.w300,
              fontSize: 18,
            ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceContainerLow,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
