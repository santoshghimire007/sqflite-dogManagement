import 'package:flutter/material.dart';

class TextfieldWidget extends StatefulWidget {
  final TextEditingController controllerValue;
  final String lblText;
  final TextInputType inType;
  const TextfieldWidget(
      {Key? key,
      required this.controllerValue,
      required this.lblText,
      required this.inType})
      : super(key: key);

  @override
  _TextfieldWidgetState createState() => _TextfieldWidgetState();
}

class _TextfieldWidgetState extends State<TextfieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: widget.inType,
      controller: widget.controllerValue,
      decoration: InputDecoration(
        hintText: 'Enter ${widget.lblText}',
        hintStyle: const TextStyle(fontWeight: FontWeight.bold),
        labelText: widget.lblText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
