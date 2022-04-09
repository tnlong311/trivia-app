import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trivia_app/consts/app_styles.dart';
import 'package:trivia_app/views/pages/team_formation_page.dart';
import 'package:trivia_app/views/dialogs/custom_snackbar.dart';

class TextFieldWithButton extends StatefulWidget {
  const TextFieldWithButton(
      {Key? key,
      required this.routeName,
      required this.isKeyboard,
      required this.validator,
      required this.updator,
      required this.failMsg,
      required this.successMsg,
      required this.run_animation,
      required this.hintText,
      required this.width,
      required this.height})
      : super(key: key);

  final String routeName;
  final String failMsg;
  final String successMsg;
  final bool isKeyboard;
  final Function validator;
  final Function updator;
  final Function run_animation;
  final String hintText;
  final double width;
  final double height;

  // final Function customValidate;

  @override
  State<TextFieldWithButton> createState() => _TextFieldWithButtonState();
}

class _TextFieldWithButtonState extends State<TextFieldWithButton> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  var p1;

  @override
  void initState() {
    p1 = Image.asset('assets/images/next_page_button.png');
  }

  @override
  Widget build(BuildContext context) {
    onSubmitValidate() async {
      var status = await widget.updator(_controller.value.text);

      if (status) {
        CustomSnackBar.showSuccessSnackBar(context, widget.successMsg);
        widget.run_animation();
        await Future.delayed(const Duration(milliseconds: 1500));
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        await Future.delayed(const Duration(milliseconds: 5000));

        Navigator.push(
            context,
            PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) =>
                    const TeamFormationPage(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero));
      } else {
        CustomSnackBar.showFailSnackBar(context, widget.failMsg);
      }
    }

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

                      await onSubmitValidate();
                    }
                    ;
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
                onFieldSubmitted: (value) async {
                  if (_formKey.currentState!.validate()) {
                    await onSubmitValidate();
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
                        const BorderSide(color: Colors.transparent, width: 5.0),
                  ),
                  hintText: this.widget.hintText,
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
