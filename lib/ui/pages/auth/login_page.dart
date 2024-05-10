import 'package:flutter/material.dart';
import 'package:simpel/cubit/auth_cubit.dart';
import 'package:simpel/cubit/kandidat_cubit.dart';
import 'package:simpel/cubit/komunitas_cubit.dart';
import 'package:simpel/cubit/list_kabupaten_cubit.dart';
import 'package:simpel/cubit/list_suara_cubit.dart';
import 'package:simpel/cubit/navbar_cubit.dart';
import 'package:simpel/cubit/show_hide_pass_cubit.dart';
import 'package:simpel/cubit/total_suara_cubit.dart';
import 'package:simpel/cubit/user_cubit.dart';
import 'package:simpel/shared/screen_tap.dart';
import 'package:simpel/shared/shared_prefrences.dart';
import 'package:simpel/shared/theme.dart';
import 'package:simpel/ui/widgets/custom_primary_button.dart';
import 'package:simpel/ui/widgets/custom_text_form_field_icon_right.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController =
        TextEditingController(text: '');

    final TextEditingController passController =
        TextEditingController(text: '');

    bool validateCheck() {
      if (usernameController.text.isEmpty || passController.text.isEmpty) {
        return false;
      } else {
        return true;
      }
    }

    saveSession() async {
      await SharedPreference.login?.setBool("is_login", true);
    }

    return Form(
      key: formKey,
      child: GestureDetector(
        onTap: () {
          screenTap();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    height: 87,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset(
                        "assets/ic_logo_splash.png",
                        height: 85,
                        width: 90,
                      ),
                      Image.asset(
                        "assets/img_lokomotif.png",
                        height: 85,
                        width: 133,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 37,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Masuk Akun",
                      style: deepBlackTextStyle.copyWith(
                          fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    height: 42,
                  ),
                  Text(
                    "Username",
                    style: blackTextStyle.copyWith(
                        fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomTextFormFieldIconRight(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Username tidak boleh kosong';
                        }
                        return null;
                      },
                      hintText: "Masukkan Username",
                      image: "assets/ic_username_textfield.png",
                      controller: usernameController,
                      backgroundColor: kWhiteColor,
                      borderColor: kBorderColor,
                      textInputType: TextInputType.text,
                      maxLines: 1,
                      obscureText: false,
                      hintStyle: greyTextStyle.copyWith(
                          fontSize: 14, fontWeight: FontWeight.w400),
                      textStyle: blackTextStyle.copyWith(
                          fontSize: 14, fontWeight: FontWeight.w400),
                      enabled: true),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    "Password",
                    style: blackTextStyle.copyWith(
                        fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: EdgeInsets.zero,
                    child: BlocBuilder<ShowHidePassCubit, bool>(
                      builder: (context, state) {
                        return CustomTextFormFieldIconRight(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password tidak boleh kosong';
                              }
                              return null;
                            },
                            hintText: "Masukkan Password",
                            onTapEye: () {
                              if (state) {
                                context
                                    .read<ShowHidePassCubit>()
                                    .setShowHidePass(false);
                              } else {
                                context
                                    .read<ShowHidePassCubit>()
                                    .setShowHidePass(true);
                              }
                            },
                            image: "pass",
                            controller: passController,
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
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is LoginUserSuccess) {
                        saveSession();

                        String uuid = SharedPreference.login.getString("uuid");

                        context
                            .read<UserCubit>()
                            .getDataUser(uuid: uuid); //get data user dari api
                        context
                            .read<TotalSuaraCubit>()
                            .getDataTotalSuara(); //get data total suara dari api
                        context
                            .read<ListSuaraCubit>()
                            .getDataListSuara(page: ""); //get data list suara
                        context
                            .read<ListKabupatenCubit>()
                            .getKabupatenData(); //get data kabupaten dari api

                        context.read<KomunitasCubit>().getDataKomunitas();

                        context.read<NavbarCubit>().setPage(0);

                        Navigator.pushNamedAndRemoveUntil(
                            context, "main", (route) => false);

                        BlocListener<UserCubit, UserState>(
                          listener: (context, state) {
                            if (state is DataUserSuccess) {
                              context.read<KandidatCubit>().getDataKandidat(
                                  idCalon: state.dataUserModel.data.idCalon
                                      .toString());
                            }
                          },
                        );

                        context.read<NavbarCubit>().setPage(0);
                      } else if (state is LoginUserFailed) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(state.error)));
                      }
                    },
                    builder: (context, state) {
                      if (state is LoginUserLoading) {
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: kPrimaryColor,
                            color: kSecondaryColor,
                          ),
                        );
                      }
                      return CustomPrimaryButton(
                          title: "Masuk",
                          onPressed: () {
                            screenTap();
                            if (formKey.currentState!.validate()) {
                              if (!validateCheck()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        backgroundColor: Colors.red,
                                        content:
                                            Text("Mohon lengkapi form !")));
                              } else {
                                context.read<AuthCubit>().loginUser(
                                    username: usernameController.text,
                                    password: passController.text);
                              }
                            }
                          });
                    },
                  ),
                  const SizedBox(
                    height: 138,
                  ),
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}
