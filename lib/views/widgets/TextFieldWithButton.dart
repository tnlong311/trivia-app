import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trivia_app/consts/app_styles.dart';
import 'package:trivia_app/views/pages/team_formation_page.dart';
import 'package:trivia_app/views/dialogs/custom_snackbar.dart';

import '../dialogs/custom_spinner.dart';

class TextFieldWithButton extends StatefulWidget {
  const TextFieldWithButton(
      {Key? key,
      required this.routeName,
      required this.validator,
      required this.updator,
      required this.failMsg,
      required this.successMsg,
      required this.run_animation,
      required this.hintText,
      required this.width,
      required this.height,
      required this.nextPage})
      : super(key: key);

  final String routeName;
  final String failMsg;
  final String successMsg;
  final Function validator;
  final Function updator;
  final Function run_animation;
  final String hintText;
  final double width;
  final double height;
  final Function nextPage;

  // final Function customValidate;

  @override
  State<TextFieldWithButton> createState() => _TextFieldWithButtonState();
}

class _TextFieldWithButtonState extends State<TextFieldWithButton> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  var p1;
  bool _isPressing = false;

  @override
  void initState() {
    p1 = Image.asset('assets/images/next_page_button.png');
  }

  @override
  Widget build(BuildContext context) {
    onSubmitValidate() async {
      var status = await widget.updator(_controller.value.text);

      if (status) {
        widget.nextPage();
      } else {
        CustomSnackBar.showFailSnackBar(context, widget.failMsg);
      }
    }

    return Container(
      width: widget.width,
      height: widget.height + 20,
      color: Colors.transparent,
      child: _isPressing
          ? Padding(
            padding: const EdgeInsets.only(right: 40),
            child: Spinner.PouringHourGlass(),
          )
          : Stack(children: <Widget>[
              Container(
                width: 250.0 / 300.0 * widget.width,
                height: widget.height,
                child: Image.asset(
                  'assets/images/InputBox2.png',
                  fit: BoxFit.fill,
                  height: widget.height,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
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
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _isPressing = true;
                        });
                        // close keyboard
                        FocusManager.instance.primaryFocus?.unfocus();

                        await onSubmitValidate();
                        setState(() {
                          _isPressing = false;
                        });
                      }
                    },
                    child: Container(width: widget.width / 9, child: p1),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                child: Container(
                  width: widget.width * 0.8,
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      style: triviaSmall1,
                      validator: (value) => widget.validator(value),
                      onFieldSubmitted: (value) async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isPressing = true;
                          });

                          await onSubmitValidate();

                          setState(() {
                            _isPressing = false;
                          });
                        }
                      },
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
                        errorStyle: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'PixelFont',
                            fontSize: 13),
                        errorMaxLines: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ]),
    );
  }
}
