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
    final buttonImage = Image.asset(
      'assets/images/nextButton.png',
      scale: 2,
    );
    return Container(
      width: 250,
      child: Stack(children: <Widget>[
        Row(
          mainAxisAlignment: centertop,
          children: [
            Expanded(
              flex: 3,
              child: Image.asset(
                'assets/images/InputBox2.png',
                fit: BoxFit.fill,
                height: 80,
              ),
            ),
            widget.isKeyboard
                ? Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        const snackBar = SnackBar(content: Text('Tap'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: Align(
                          alignment: Alignment.centerRight, child: buttonImage),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
        Align(
          alignment: const Alignment(0.1, -1),
          child: Container(
            width: 230,
            height: 70,
            child: Form(
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
          ),
        ),
      ]),
    );
  }
}
