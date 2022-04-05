import 'package:flutter/material.dart';
import 'package:trivia_app/consts/app_styles.dart';

class GroupNameTextField extends StatefulWidget {
  const GroupNameTextField(
      {Key? key,
      required this.routeName,
      required this.isKeyboard,
      required this.validator,
      required this.updator})
      : super(key: key);

  final String routeName;
  final bool isKeyboard;
  final Function validator;
  final Function updator;

  // final Function customValidate;

  @override
  State<GroupNameTextField> createState() => _GroupNameTextFieldState();
}

class _GroupNameTextFieldState extends State<GroupNameTextField> {
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
            width: 240,
            child: Stack(children: <Widget>[
              Form(
                key: _formKey,
                child: TextFormField(
                  style: triviaSmall1,
                  validator: (value) => widget.validator(value),
                  onFieldSubmitted: (value) async {
                    if (_formKey.currentState!.validate()) {
                      await widget.updator(value);
                      Navigator.pushNamed(context, widget.routeName);
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
                    hintText: 'Enter group name',
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
                            await widget.updator(_controller.value.text);
                            Navigator.pushNamed(context, widget.routeName);
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
