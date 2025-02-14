import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final Color backgroundColor;
  final String text;
  final double borderRadius;
  final VoidCallback onPressed;
  final bool isLoading;

  const CustomButton({
    Key? key,
    this.width = 250,
    this.height = 50,
    this.backgroundColor = Colors.blue,
    this.text = 'Button',
    this.borderRadius = 30,
    required this.onPressed,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 5,
        ),
        child: isLoading
            ? const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 3,
          ),
        )
            : Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
