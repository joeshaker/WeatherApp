import 'package:flutter/material.dart';

class LoginText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;

  const LoginText({
    super.key,
    required this.text,
    this.fontSize = 20,
    this.color = Colors.white,
    this.fontWeight = FontWeight.bold,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}