import 'package:flutter/material.dart';

class TextFieldWithButton extends StatefulWidget {
  const TextFieldWithButton(
      {Key? key, required this.routeName, required this.isKeyboard})
      : super(key: key);

  final String routeName;
  final bool isKeyboard;

  // final Function customValidate;

  @override
  State<TextFieldWithButton> createState() => _TextFieldWithButtonState();
}

class _TextFieldWithButtonState extends State<TextFieldWithButton> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      // padding: const EdgeInsets.symmetric(horizontal: 10),
      // height: 200,
      child: Stack(children: <Widget>[
        Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          body: Image.asset('assets/images/DemoBox.png',
              alignment: Alignment.topCenter),
        ),
        Row(children: [
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
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.transparent, width: 4.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.transparent, width: 5.0),
                  ),
                  hintText: "Enter game code",
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
      ]),
    );
  }
}
