import 'package:flutter/material.dart';
import 'package:trivia_app/consts/app_styles.dart';

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
      child: Stack(children: <Widget>[
        Image.asset(
          'assets/images/InputBox2.png',
          fit: BoxFit.fill,
          height: 80,
        ),
        Align(
          alignment: const Alignment(0.1, -1),
          child: Container(
            width:240,
            child: Stack(children: <Widget>[
              Form(
                key: _formKey,
                child: TextFormField(
                  style: triviaSmall1,
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
                    hintText: 'Enter game code',
                  ),
                ),
              ),
              widget.isKeyboard
                  ? Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.navigate_next),
                  iconSize: 40,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushNamed(context, this.widget.routeName);
                    }
                  },
                ),
              )
                  : const SizedBox.shrink(),
            ]),
          ),
        ),
      ]),
    );
  }
}
