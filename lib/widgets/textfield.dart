import 'package:flutter/material.dart';

class Textfield extends StatefulWidget {
  final Function(String text)? onTextChanged;
  final String? Function(String? text)? validator;
  final Key? formKey;
  final String label;
  final TextInputType keyboardType;
  const Textfield({
    super.key,
    this.onTextChanged,
    this.formKey,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  State<Textfield> createState() => _Textfield();
}

class _Textfield extends State<Textfield> {
  late FocusNode _focusNode;
  final TextEditingController _controller = TextEditingController();
  bool hasText = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _controller.addListener(() {
      setState(() {
        hasText = _controller.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Focus(
        onFocusChange: (value) {
          setState(() {});
        },
        child: GestureDetector(
          onTap: () {
            _focusNode.requestFocus();
          },
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              border: Border.all(
                color: _focusNode.hasFocus || hasText
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).colorScheme.onSecondaryContainer,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 22,
                  child: TextFormField(
                    cursorWidth: 1,
                    cursorHeight: 16,
                    controller: _controller,
                    focusNode: _focusNode,
                    cursorColor: Theme.of(context).colorScheme.inversePrimary,
                    validator: (value) {
                      if (widget.validator != null) {
                        return widget.validator!(value);
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      label: Text(
                        "Label",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 16),
                      ),
                    ),
                    keyboardType: widget.keyboardType,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
