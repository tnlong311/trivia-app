import 'package:flutter/material.dart';

class TextFieldSingle extends StatefulWidget {
  const TextFieldSingle({Key? key, required this.width}) : super(key: key);

  final double width;

  @override
  State<TextFieldSingle> createState() => _TextFieldSingleState();
}

class _TextFieldSingleState extends State<TextFieldSingle> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      // height: 100,
      child: TextFormField(
        // expands: true,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        controller: _controller,
        decoration: const InputDecoration(
          // alignLabelWithHint: false,
          border: OutlineInputBorder(),
          hintText: "Enter answer here",
          labelText: "Hello",
        ),
      ),
    );
  }
}
