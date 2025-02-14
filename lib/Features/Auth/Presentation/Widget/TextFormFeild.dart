import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget defaultTextFormDecorated({
  TextEditingController ?controller,
  String? label,
  String ?hintText,
  TextInputType ?type,
  FormFieldSetter<String> ?onSubmit,
  FormFieldValidator<String> ?validate,
  ValueChanged<String> ?onChange,
  VoidCallback ?suffixPressed,
  IconData ?suffixicon,
  VoidCallback ?prefixPressed,
  IconData? prefixicon,
  Color? borderColor,
  double? borderRadius,
  Color? fillColor,
  Color? hintColor,
  Color? labelColor,
  bool isPassword = false,
}) {
  return TextFormField(
    style: TextStyle(color: Colors.white),
    controller: controller,
    keyboardType: type,
    decoration: InputDecoration(

      labelText: label,
      hintText: hintText,
      suffixIcon: IconButton(
        icon: Icon(suffixicon),
        onPressed: suffixPressed,
      ),
      prefixIcon: prefixicon != null
          ? IconButton(
        icon: Icon(prefixicon),
        onPressed: prefixPressed, // Trigger dropdown menu
      )
          : null,
      filled: true,
      fillColor: fillColor ?? Colors.white,
      hintStyle: TextStyle(color: hintColor ?? Colors.grey),
      labelStyle: TextStyle(color: labelColor ?? Colors.black),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 20.0),
        borderSide: BorderSide(color: borderColor ?? Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 20.0),
        borderSide: BorderSide(color: borderColor ?? Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 20.0),
        borderSide: BorderSide(color: borderColor ?? Colors.blue),
      ),
    ),
    onFieldSubmitted: onSubmit,
    validator: validate,
    onChanged: onChange,
    obscureText: isPassword,
  );
}