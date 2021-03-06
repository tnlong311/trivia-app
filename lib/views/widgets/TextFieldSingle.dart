import 'package:flutter/material.dart';

class TextFieldSingle extends StatefulWidget {
  TextFieldSingle(
      {Key? key,
      required this.width,
      required this.title,
      required this.description,
      required this.validator,
      required this.updator,
      required this.onEnter})
      : super(key: key);

  final double width;
  final String title;
  final String description;
  final Function validator;
  final Function updator;
  final Function onEnter;

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
        validator: (value) => widget.validator(value),
        controller: _controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: widget.description,
          labelText: widget.title,
        ),
        onFieldSubmitted: (_) async => await widget.onEnter(),
        onSaved: (value) => widget.updator(value),
      ),
    );
  }
}
