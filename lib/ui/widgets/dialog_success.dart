import 'package:flutter/material.dart';
import 'package:simpel/shared/theme.dart';
import 'package:simpel/ui/widgets/custom_primary_button.dart';

class DialogSuccess extends StatelessWidget {
  final String desc;
  final Function() onTap;

  const DialogSuccess({required this.desc, required this.onTap, super.key});

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
              Image.asset(
                "assets/ic_dialog_tambah_suara.png",
                width: 162,
                height: 157,
              ),
              const SizedBox(
                height: 28,
              ),
              Text(
                "Berhasil",
                style: blackTextStyle.copyWith(
                    fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                desc,
                style: blackTextStyle.copyWith(
                    fontSize: 16, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 32,
              ),
              CustomPrimaryButton(title: "OK", onPressed: onTap)
            ],
          ),
        ));
  }
}
