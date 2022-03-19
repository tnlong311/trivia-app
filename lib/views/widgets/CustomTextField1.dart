import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField1 extends StatefulWidget {
  const CustomTextField1(
      {Key? key, required this.routeName, required this.isKeyboard})
      : super(key: key);

  final String routeName;
  final bool isKeyboard;

  // final Function customValidate;

  @override
  State<CustomTextField1> createState() => _CustomTextField1State();
}

class _CustomTextField1State extends State<CustomTextField1> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      // padding: const EdgeInsets.symmetric(horizontal: 10),
      // height: 200,
      child: Row(children: [
        Expanded(
          flex: 3,
          child: Form(
            key: _formKey,
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              controller: _controller,
              decoration: const InputDecoration(
                hintText: "Enter game code",
                // labelText: "Hello",
                // errorText: "Please fill in",
              ),
            ),
          ),
        ),
        widget.isKeyboard
            ? Expanded(
                child: IconButton(
                  icon: const Icon(Icons.navigate_next),
                  iconSize: 40,
                  onPressed: () {
                    // print(widget.isKeyboard);
                    // print(_controller.text);
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushNamed(context, this.widget.routeName);
                    }
                  },
                ),
              )
            : const SizedBox.shrink(),
      ]),
    );
  }
}
