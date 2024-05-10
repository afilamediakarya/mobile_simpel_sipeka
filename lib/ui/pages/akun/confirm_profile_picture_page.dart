import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:simpel/cubit/confirm_photo_profile_cubit.dart';
import 'package:simpel/shared/theme.dart';
import 'package:simpel/ui/widgets/custom_primary_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmProfilePicturePage extends StatelessWidget {
  const ConfirmProfilePicturePage({super.key, required this.picture});

  final XFile picture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCameraPageColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      "assets/ic_close.png",
                      height: 24,
                      width: 24,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 25,
                ),
                Center(
                  child: Column(
                    children: [
                      Text(
                        "Foto Profile",
                        style: whiteTextStyle.copyWith(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Sesuaikan foto profile",
                        textAlign: TextAlign.center,
                        style: whiteTextStyle.copyWith(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 34,
                ),
                SizedBox(
                  height: 339,
                  width: double.infinity,
                  child: Image.file(File(picture.path), fit: BoxFit.cover),
                )
              ],
            )),
            const SizedBox(
              height: 48,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: kBorderColor),
                          borderRadius: BorderRadius.circular(4)),
                      child: Center(
                        child: Text(
                          "Foto Lagi",
                          style: whiteTextStyle.copyWith(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  )),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                      child: CustomPrimaryButton(
                          title: "Pakai Foto",
                          onPressed: () {
                            context
                                .read<ConfirmPhotoProfileCubit>()
                                .getPhotoProfileFile(file: picture);
                            Navigator.popAndPushNamed(context, 'edit-profile');
                          }))
                ],
              ),
            ),
            const SizedBox(
              height: 80,
            )
          ],
        ),
      ),
    );
  }
}
