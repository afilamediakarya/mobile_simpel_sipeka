import "package:flutter/material.dart";
import 'package:simpel/cubit/change_pass_cubit.dart';
import 'package:simpel/cubit/show_hide_change_pass_1_cubit.dart';
import 'package:simpel/cubit/show_hide_change_pass_2_cubit.dart';
import 'package:simpel/cubit/show_hide_change_pass_3_cubit.dart';
import 'package:simpel/shared/screen_tap.dart';
import 'package:simpel/shared/theme.dart';
import 'package:simpel/ui/widgets/custom_primary_button.dart';
import 'package:simpel/ui/widgets/custom_text_form_field_icon_right.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simpel/ui/widgets/dialog_failed.dart';
import 'package:simpel/ui/widgets/dialog_loading.dart';
import 'package:simpel/ui/widgets/dialog_other.dart';
import 'package:simpel/ui/widgets/dialog_success.dart';

class UbahPasswordPage extends StatelessWidget {
  const UbahPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController oldPassController =
        TextEditingController(text: '');

    final TextEditingController newPassController =
        TextEditingController(text: '');

    final TextEditingController confirmPassController =
        TextEditingController(text: '');

    return Form(
      key: formKey,
      child: GestureDetector(
        onTap: () => screenTap(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: kPureWhiteColor,
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                      left: 16, top: 24, bottom: 8, right: 24),
                  decoration: BoxDecoration(color: kPureWhiteColor, boxShadow: [
                    BoxShadow(
                        color: kGreyColor,
                        blurRadius: 1,
                        spreadRadius: 0.1,
                        offset: const Offset(0, 1)),
                  ]),
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          "assets/ic_arrow_left.png",
                          height: 24,
                          width: 24,
                        ),
                      ),
                      Center(
                        child: Text(
                          "Ubah Password",
                          style: blackTextStyle.copyWith(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Password Lama",
                        style: blackTextStyle.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      BlocBuilder<ShowHideChangePass_1Cubit, bool>(
                        builder: (context, state) {
                          return CustomTextFormFieldIconRight(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password lama tidak boleh kosong';
                                }
                                return null;
                              },
                              onTapEye: () {
                                if (state) {
                                  context
                                      .read<ShowHideChangePass_1Cubit>()
                                      .setShowHidePass(false);
                                } else {
                                  context
                                      .read<ShowHideChangePass_1Cubit>()
                                      .setShowHidePass(true);
                                }
                              },
                              hintText: "Masukkan Password Lama",
                              image: "pass",
                              controller: oldPassController,
                              backgroundColor: kWhiteColor,
                              borderColor: kBorderColor,
                              textInputType: TextInputType.text,
                              maxLines: 1,
                              obscureText: state,
                              hintStyle: greyTextStyle.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                              textStyle: blackTextStyle.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                              enabled: true);
                        },
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Text(
                        "Password Baru",
                        style: blackTextStyle.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      BlocBuilder<ShowHideChangePass_2Cubit, bool>(
                        builder: (context, state) {
                          return CustomTextFormFieldIconRight(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password baru tidak boleh kosong';
                                }
                                return null;
                              },
                              hintText: "Masukkan Password Baru",
                              onTapEye: () {
                                if (state) {
                                  context
                                      .read<ShowHideChangePass_2Cubit>()
                                      .setShowHidePass(false);
                                } else {
                                  context
                                      .read<ShowHideChangePass_2Cubit>()
                                      .setShowHidePass(true);
                                }
                              },
                              image: "pass",
                              controller: newPassController,
                              backgroundColor: kWhiteColor,
                              borderColor: kBorderColor,
                              textInputType: TextInputType.text,
                              maxLines: 1,
                              obscureText: state,
                              hintStyle: greyTextStyle.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                              textStyle: blackTextStyle.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                              enabled: true);
                        },
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Text(
                        "Password Baru Ulang",
                        style: blackTextStyle.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      BlocBuilder<ShowHideChangePass_3Cubit, bool>(
                        builder: (context, state) {
                          return CustomTextFormFieldIconRight(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password baru tidak boleh kosong';
                                }
                                return null;
                              },
                              hintText: "Masukkan Password Baru",
                              image: "pass",
                              onTapEye: () {
                                if (state) {
                                  context
                                      .read<ShowHideChangePass_3Cubit>()
                                      .setShowHidePass(false);
                                } else {
                                  context
                                      .read<ShowHideChangePass_3Cubit>()
                                      .setShowHidePass(true);
                                }
                              },
                              controller: confirmPassController,
                              backgroundColor: kWhiteColor,
                              borderColor: kBorderColor,
                              textInputType: TextInputType.text,
                              maxLines: 1,
                              obscureText: state,
                              hintStyle: greyTextStyle.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                              textStyle: blackTextStyle.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                              enabled: true);
                        },
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      CustomPrimaryButton(
                          title: "Ubah",
                          onPressed: () {
                            screenTap();
                            if (formKey.currentState!.validate()) {
                              if (confirmPassController.text.isEmpty ||
                                  newPassController.text.isEmpty ||
                                  oldPassController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(
                                            "Lengkapi form terlebih dahulu !")));
                              } else {
                                if (confirmPassController.text !=
                                    newPassController.text) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(
                                              "Password baru dan konfirmasi password tidak sama !")));
                                } else {
                                  context.read<ChangePassCubit>().changePass(
                                      oldPass: oldPassController.text,
                                      newPass: confirmPassController.text);

                                  showDialog(
                                      barrierDismissible: true,
                                      context: context,
                                      builder: (context) => BlocBuilder<
                                              ChangePassCubit, ChangePassState>(
                                            builder: (context, state) {
                                              if (state is ChangePassLoading) {
                                                return const DialogLoading();
                                              } else if (state
                                                  is ChangePassFailed) {
                                                return DialogFailed(
                                                    desc: state.error);
                                              } else if (state
                                                  is ChangePassSuccess) {
                                                return DialogSuccess(
                                                  desc:
                                                      "Password Berhasil Diperbarui",
                                                  onTap: () => Navigator
                                                      .pushNamedAndRemoveUntil(
                                                          context,
                                                          'login',
                                                          (route) => false),
                                                );
                                              } else {
                                                return const DialogOther();
                                              }
                                            },
                                          ));
                                }
                              }
                            }
                          })
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
