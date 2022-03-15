import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputValidate extends StatelessWidget{
  const InputValidate ({Key? key, required this.routeName}) : super(key: key);

  final String routeName;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(150, 60),
      ),
      child: const Text('Input here', style: TextStyle(fontSize: 18)),
      onPressed: () {
        Navigator.pushNamed(context, this.routeName);
      },
    );
  }

}