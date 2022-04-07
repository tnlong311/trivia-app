import 'package:flutter/material.dart';
import 'package:trivia_app/consts/app_styles.dart';
import 'package:trivia_app/views/dialogs/custom_snackbar.dart';

class TextFieldWithButton extends StatefulWidget {
  const TextFieldWithButton(
      {Key? key,
      required this.routeName,
      required this.isKeyboard,
      required this.validator,
      required this.updator,
      required this.failMsg,
      required this.successMsg})
      : super(key: key);

  final String routeName;
  final String failMsg;
  final String successMsg;
  final bool isKeyboard;
  final Function validator;
  final Function updator;

  // final Function customValidate;

  @override
  State<TextFieldWithButton> createState() => _TextFieldWithButtonState();
}

class _TextFieldWithButtonState extends State<TextFieldWithButton> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    onSubmitValidate() async {
      var status =
      await widget.updator(_controller.value.text);

      if (status) {
        CustomSnackBar.showSuccessSnackBar(
            context, widget.successMsg);
        await Future.delayed(
            const Duration(milliseconds: 1500));
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        await Future.delayed(
            const Duration(milliseconds: 500));

        Navigator.pushNamed(context, widget.routeName);
      } else {
        CustomSnackBar.showFailSnackBar(
            context, widget.failMsg);
      }
    }

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
            width: 240,
            child: Stack(children: <Widget>[
              Form(
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
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 8, left: 15),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 4.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 5.0),
                    ),
                    hintText: 'Enter here',
                  ),
                ),
              ),
              widget.isKeyboard
                  ? Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.navigate_next),
                        iconSize: 40,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            // close keyboard
                            FocusManager.instance.primaryFocus?.unfocus();

                            await onSubmitValidate();
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
