import "package:flutter/material.dart";
import 'package:simpel/shared/theme.dart';

class CustomTextFormField extends StatelessWidget {
  final int maxLines;
  final TextStyle textStyle;
  final Color cursorColor;
  final TextEditingController textEditingController;
  final Color fillColor;
  final TextStyle hintStyle;
  final Color enabledColor;
  final Color focusedColor;
  final String hintText;
  final TextInputType textInputType;
  final String? Function(String?) validator;

  const CustomTextFormField(
      {super.key,
      required this.cursorColor,
      required this.enabledColor,
      required this.fillColor,
      required this.focusedColor,
      required this.hintStyle,
      required this.maxLines,
      required this.textEditingController,
      required this.textStyle,
      required this.textInputType,
      required this.validator,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      scrollPadding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      maxLines: maxLines,
      style: textStyle,
      cursorColor: kBlackColor,
      controller: textEditingController,
      keyboardType: textInputType,
      validator: validator,
      decoration: InputDecoration(
          filled: true,
          fillColor: kPureWhiteColor,
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 14.0),
          hintText: hintText,
          hintStyle: hintStyle,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: kBorderColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: kPrimaryColor))),
    );
  }
}
