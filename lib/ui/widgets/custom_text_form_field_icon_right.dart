import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simpel/shared/theme.dart';

class CustomTextFormFieldIconRight extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Color backgroundColor;
  final Color borderColor;
  final TextInputType textInputType;
  final int maxLines;
  final bool obscureText;
  final TextStyle hintStyle;
  final TextStyle textStyle;
  final Function()? onTapEye;
  final bool eye;
  final bool enabled;
  final String image;
  final bool autofocus;
  final String? Function(String?) validator;

  const CustomTextFormFieldIconRight(
      {Key? key,
      required this.hintText,
      required this.image,
      required this.controller,
      required this.backgroundColor,
      required this.borderColor,
      required this.textInputType,
      required this.maxLines,
      required this.obscureText,
      required this.hintStyle,
      required this.textStyle,
      required this.validator,
      this.onTapEye,
      required this.enabled,
      this.autofocus = false,
      this.eye = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextFormField(
          inputFormatters: [LengthLimitingTextInputFormatter(16)],
          autofocus: autofocus,
          enabled: enabled,
          scrollPadding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          obscureText: obscureText,
          maxLines: maxLines,
          style: textStyle,
          cursorColor: kBlackColor,
          controller: controller,
          keyboardType: textInputType,
          validator: validator,
          decoration: InputDecoration(
              filled: true,
              fillColor: backgroundColor,
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 14.0),
              hintText: hintText,
              hintStyle: hintStyle,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: borderColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: kPrimaryColor))),
        ),
        image == "pass"
            ? SizedBox(
                width: double.infinity,
                height: 48,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                      onTap: onTapEye,
                      child: Container(
                        height: 20,
                        width: 20,
                        margin: const EdgeInsets.only(right: 16),
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/ic_eye_textfield.png"))),
                      )),
                ),
              )
            : SizedBox(
                width: double.infinity,
                height: 48,
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 20,
                      width: 20,
                      margin: const EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage(image))),
                    )),
              )
      ],
    );
  }
}
