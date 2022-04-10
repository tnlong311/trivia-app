import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trivia_app/consts/app_styles.dart';
import 'package:trivia_app/views/pages/team_formation_page.dart';
import 'package:trivia_app/views/dialogs/custom_snackbar.dart';

class TextFieldSingle2 extends StatefulWidget {
  const TextFieldSingle2({
    Key? key,
    required this.isKeyboard,
    required this.validator,
    required this.updator,
    required this.hintText,
    required this.width,
    required this.height,
    required this.onEnter,
  }) : super(key: key);

  final bool isKeyboard;
  final Function validator;
  final Function updator;
  final Function onEnter;
  final String hintText;
  final double width;
  final double height;

  // final Function customValidate;

  @override
  State<TextFieldSingle2> createState() => _TextFieldSingle2State();
}

class _TextFieldSingle2State extends State<TextFieldSingle2> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  var p1;

  @override
  void initState() {
    p1 = Image.asset('assets/images/next_page_button.png');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      color: Colors.transparent,
      child: Stack(children: <Widget>[
        Container(
          width: 250.0 / 300.0 * widget.width,
          height: widget.height,
          child: Image.asset(
            'assets/images/InputBox2.png',
            fit: BoxFit.fill,
            height: widget.height,
          ),
        ),
        widget.isKeyboard
            ? Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTapDown: (tap) async {
                    setState(() {
                      p1 = Image.asset(
                          'assets/images/next_page_button_pressed.png');
                    });
                  },
                  onTapCancel: () => {
                    setState(() {
                      p1 = Image.asset('assets/images/next_page_button.png');
                    })
                  },
                  onTapUp: (tap) async {
                    setState(() {
                      p1 = Image.asset('assets/images/next_page_button.png');
                    });
                    Future.delayed(Duration(seconds: 5));
                    if (_formKey.currentState!.validate()) {
                      // close keyboard
                      FocusManager.instance.primaryFocus?.unfocus();
                    };
                  },
                  child: Container(width: widget.width / 9, child: p1),
                ),
              )
            : const SizedBox.shrink(),
        Positioned(
          left: 0,
          child: Container(
            width: widget.width * 0.8,
            child: Form(
              key: _formKey,
              child: TextFormField(
                style: triviaSmall1,
                validator: (value) => widget.validator(value),
                onFieldSubmitted: (_) async => widget.onEnter(),
                controller: _controller,
                textAlign: TextAlign.center,
                // textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.transparent, width: 4.0),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.transparent, width: 5.0),
                  ),
                  hintText: widget.hintText,
                ),
                onSaved: (value) => widget.updator(value),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
