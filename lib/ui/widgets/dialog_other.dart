import 'package:flutter/material.dart';
import 'package:simpel/shared/theme.dart';
import 'package:simpel/ui/widgets/custom_primary_button.dart';

class DialogOther extends StatelessWidget {
  const DialogOther({super.key});

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
              const Text("Ada Kesalahan !"),
              CustomPrimaryButton(
                  title: "OK",
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          ),
        ));
  }
}
