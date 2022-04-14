import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trivia_app/consts/app_styles.dart';

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
  // final _formKey = GlobalKey<FormState>();
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
      height: widget.height + 20,
      color: Colors.transparent,
      child: Stack(children: <Widget>[
        Container(
          width: 250.0 / 300.0 * widget.width,
          height: widget.height,
          // height: widget.height,
          child: Image.asset(
            'assets/images/InputBox2.png',
            fit: BoxFit.fill,
            height: widget.height,
          ),
        ),
        Positioned(
          left: 0,
          child: Container(
            width: widget.width * 0.8,
            child: TextFormField(
              style: triviaSmall1,
              validator: (value) => widget.validator(value),
              onFieldSubmitted: (_) async => await widget.onEnter(),
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
                  errorStyle: TextStyle(color: Colors.white, fontFamily: 'PixelFont',fontSize: 13),
                errorMaxLines: 2,
                focusedErrorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 4.0),
                ),
                errorBorder: const UnderlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.red, width: 4.0),
                  )
              ),
              onSaved: (value) => widget.updator(value),
            ),
          ),
        ),
      ]),
    );
  }
}
