import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String name;
  final Color color;
  VoidCallback onPressed;
   MyButton({super.key,
   required this.name,
   required this.color,
   required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(name),
      onPressed: onPressed,
    color: color ,
    );
  }
}
