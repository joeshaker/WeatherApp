import 'package:flutter/material.dart';

class defaultText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;

  const defaultText({
    super.key,
    required this.text,
    this.fontSize = 20,
    this.color = Colors.white,
    this.fontWeight = FontWeight.bold,
    this.textAlign=TextAlign.start
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
      textAlign: textAlign,
    );
  }
}