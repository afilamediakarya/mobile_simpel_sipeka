import 'package:flutter/material.dart';
import 'package:simpel/shared/theme.dart';

class DialogLoading extends StatelessWidget {
  const DialogLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: const EdgeInsets.all(24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
              color: kPureWhiteColor, borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                backgroundColor: kPrimaryColor,
                color: kSecondaryColor,
              ),
              const SizedBox(
                height: 28,
              ),
              Text(
                "Mohon tunggu ...",
                style: blackTextStyle.copyWith(
                    fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ));
  }
}
