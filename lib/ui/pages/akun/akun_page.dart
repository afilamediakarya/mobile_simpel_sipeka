import 'package:flutter/material.dart';
import 'package:simpel/cubit/confirm_photo_profile_cubit.dart';
import 'package:simpel/cubit/navbar_cubit.dart';
import 'package:simpel/cubit/user_cubit.dart';
import 'package:simpel/shared/shared_prefrences.dart';
import 'package:simpel/shared/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../../services/base_url.dart' as base_url;

class AkunPage extends StatelessWidget {
  const AkunPage({super.key});

  @override
  Widget build(BuildContext context) {
    String name, role, refferal, foto;

    return Scaffold(
        backgroundColor: kPureWhiteColor,
        body: SafeArea(
          child: BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is DataUserSuccess) {
                name = state.dataUserModel.data.nama;
                role = state.dataUserModel.data.role;
                refferal = state.dataUserModel.data.refferal;
                foto = state.dataUserModel.data.foto;
              } else {
                name = "-";
                role = "-";
                refferal = "-";
                foto = "";
              }
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 24, bottom: 8),
                    decoration:
                        BoxDecoration(color: kPureWhiteColor, boxShadow: [
                      BoxShadow(
                          color: kGreyColor,
                          blurRadius: 1,
                          spreadRadius: 0.1,
                          offset: const Offset(0, 1)),
                    ]),
                    child: Center(
                      child: Text(
                        "Akun",
                        style: blackTextStyle.copyWith(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 32, horizontal: 24),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              foto == ""
                                  ? Image.asset(
                                      "assets/ic_avatar.png",
                                      height: 40,
                                      width: 40,
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: FadeInImage.memoryNetwork(
                                        image: "${base_url.urlPhoto}$foto",
                                        placeholder: kTransparentImage,
                                        width: 40,
                                        height: 40,
                                        imageErrorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                            'assets/ic_error_img.png',
                                            width: 40,
                                            height: 40,
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      ),
                                    ),
                              const SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name,
                                    style: blackTextStyle.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "Akun $role",
                                    style: greyTextStyle.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              )),
                              GestureDetector(
                                onTap: () {
                                  context
                                      .read<ConfirmPhotoProfileCubit>()
                                      .deletePicture();
                                  Navigator.pushNamed(context, "edit-profile");
                                },
                                child: Image.asset(
                                  "assets/ic_edit_profile.png",
                                  width: 24,
                                  height: 24,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 26,
                          ),
                          Row(
                            children: [
                              Image.asset(
                                "assets/ic_star_ratings.png",
                                height: 24,
                                width: 24,
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'Kode Referal ',
                                  style: blackTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: '($refferal)',
                                        style: blackTextStyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500)),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 48,
                          ),
                          Text(
                            "Umum",
                            style: blackTextStyle.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "ubah-password");
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/ic_ubah_pass.png",
                                  height: 40,
                                  width: 40,
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                    child: Text(
                                  "Ubah Password",
                                  style: blackTextStyle.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )),
                                Image.asset(
                                  "assets/ic_arrow_right.png",
                                  height: 24,
                                  width: 24,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 26,
                          ),
                          GestureDetector(
                            onTap: () {
                              context.read<NavbarCubit>().setPage(3);
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/ic_daftar_suara_akun.png",
                                  height: 40,
                                  width: 40,
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                    child: Text(
                                  "Daftar Suara",
                                  style: blackTextStyle.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )),
                                Image.asset(
                                  "assets/ic_arrow_right.png",
                                  height: 24,
                                  width: 24,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 26,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "bantuan");
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/ic_bantuan.png",
                                  height: 40,
                                  width: 40,
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                    child: Text(
                                  "Bantuan",
                                  style: blackTextStyle.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )),
                                Image.asset(
                                  "assets/ic_arrow_right.png",
                                  height: 24,
                                  width: 24,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 56,
                          ),
                          GestureDetector(
                            onTap: () {
                              SharedPreference.login
                                  ?.setBool("is_login", false);

                              SharedPreference.login?.setString("id_calon", "");
                              SharedPreference.login?.setString("refferal", "");
                              SharedPreference.choosedRoleSuara
                                  ?.setString("role", "");
                              Navigator.pushNamedAndRemoveUntil(
                                  context, "login", (route) => false);
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Center(
                                child: Text(
                                  "Keluar",
                                  style: whiteTextStyle.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ))
                ],
              );
            },
          ),
        ));
  }
}
