import 'package:flutter/material.dart';
import 'package:simpel/shared/theme.dart';

class CustomPrimaryButton extends StatelessWidget {
  final String title;
  final double width, height;
  final EdgeInsets margin;
  final Function() onPressed;

  const CustomPrimaryButton({
    Key? key,
    required this.title,
    this.height = 48,
    this.width = double.infinity,
    required this.onPressed,
    this.margin = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      height: height,
      child: ElevatedButton(
        style: TextButton.styleFrom(
          backgroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: whiteTextStyle.copyWith(
              fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
