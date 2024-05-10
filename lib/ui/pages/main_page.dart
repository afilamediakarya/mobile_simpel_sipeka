// ignore_for_file: unnecessary_overrides

import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simpel/cubit/date_birth_cubit.dart';
import 'package:simpel/cubit/list_kelurahan_cubit.dart';
import 'package:simpel/cubit/navbar_cubit.dart';
import 'package:simpel/cubit/pencarian_nik_cubit.dart';
import 'package:simpel/cubit/type_user_cubit.dart';
import 'package:simpel/cubit/user_cubit.dart';
import 'package:simpel/shared/shared_prefrences.dart';
import 'package:simpel/shared/theme.dart';
import 'package:simpel/ui/pages/akun/akun_page.dart';
import 'package:simpel/ui/pages/home/home_page.dart';
import 'package:simpel/ui/pages/kandidat/kandidat_page.dart';
import 'package:simpel/ui/pages/suara/suara_page.dart';
import 'package:simpel/ui/pages/tambah/add_page.dart';
import 'package:simpel/ui/widgets/custom_bottom_navigation_item.dart';
import 'package:simpel/ui/widgets/custom_primary_button.dart';
import 'package:simpel/ui/widgets/custom_text_form_field_icon_right.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with AutomaticKeepAliveClientMixin<MainPage> {
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController ktpController = TextEditingController(text: '');

  //role sementara
  String roleSuara = "tim";
  int idCalon = 0;

  //kalo roleSuara==tim, akses modalChooseSuara;
  //kalo roleSuara==pin, akses modalPrepareKtp;

  modalNikBelumAda() {
    return Container(
        height: 393,
        decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(24),
            )),
        padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
        child: Column(
          children: [
            SizedBox(
              height: 56,
              width: double.infinity,
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset(
                        "assets/ic_arrow_left.png",
                        height: 24,
                        width: 24,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Suara Tidak Ditemukan",
                      style: blackTextStyle.copyWith(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            Image.asset(
              "assets/ic_unregistered_data.png",
              height: 156,
              width: 161,
            ),
            const SizedBox(
              height: 36,
            ),
            CustomPrimaryButton(
                title: "OK",
                onPressed: () {
                  Navigator.pop(context);
                  context.read<DateBirthCubit>().setinitDate();
                  //sengaja default, blm ada api
                  context
                      .read<ListKelurahanCubit>()
                      .getKelurahanData(idCalon: idCalon);
                  Navigator.pushNamed(context, "tambah-data-pribadi");
                })
          ],
        ));
  }

  modalNikTerdaftar() {
    return Container(
        height: 387,
        decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(24),
            )),
        padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
        child: Column(
          children: [
            Text(
              "Data Telah Terdaftar",
              style: blackTextStyle.copyWith(
                  fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 32,
            ),
            Image.asset(
              "assets/ic_registered_data.png",
              height: 158,
              width: 140,
            ),
            const SizedBox(
              height: 36,
            ),
            CustomPrimaryButton(
                title: "OK",
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ));
  }

  modalLoading() {
    return Container(
        height: 387,
        decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(24),
            )),
        padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(
                height: 32,
              ),
              Text(
                "Mohon Menunggu ...",
                style: blackTextStyle.copyWith(
                    fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ));
  }

  modalCheckKtp(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
          height: 302,
          decoration: BoxDecoration(
              color: kWhiteColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              )),
          padding: const EdgeInsets.only(
            top: 16,
            left: 24,
            right: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Tambah Suara",
                  style: blackTextStyle.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 39,
              ),
              Text(
                "Nomor Induk Kependudukan (NIK)",
                style: blackTextStyle.copyWith(
                    fontSize: 12, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 8,
              ),
              CustomTextFormFieldIconRight(
                  autofocus: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'NIK tidak boleh kosong';
                    }
                    return null;
                  },
                  hintText: "Masukkan NIK",
                  image: "assets/ic_ktp.png",
                  controller: ktpController,
                  backgroundColor: kWhiteColor,
                  borderColor: kBorderColor,
                  textInputType: TextInputType.number,
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
              CustomPrimaryButton(
                  title: "Cari Nomor Induk Keluarga",
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      if (ktpController.text.isEmpty) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text("Mohon lengkapi form !")));
                      } else {
                        if ((ktpController.text.length < 16) ||
                            (ktpController.text.length > 16)) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text("NIK harus 16 digit !")));
                        } else {
                          context
                              .read<PencarianNikCubit>()
                              .getPencarianNik(nik: ktpController.text);

                          showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16.0),
                                ),
                              ),
                              backgroundColor: kTransparentColor,
                              builder: (context) => BlocConsumer<
                                      PencarianNikCubit, PencarianNikState>(
                                    listener: (context, state) {
                                      if (state is PencarianNikSuccess) {
                                        if (state.pencarianNikModel.data.type ==
                                            "dpt") {
                                          context
                                              .read<TypeUserCubit>()
                                              .setTypeUser("dpt");
                                          context
                                              .read<ListKelurahanCubit>()
                                              .getKelurahanData(
                                                  idCalon: idCalon);
                                          Navigator.pushNamed(
                                              context, "info-data-pribadi");
                                        }
                                      }
                                    },
                                    builder: (context, state) {
                                      if (state is PencarianNikLoading) {
                                        return modalLoading();
                                      } else if (state is PencarianNikFailed) {
                                        return modalNikBelumAda();
                                      } else if (state is PencarianNikSuccess) {
                                        if (state.pencarianNikModel.data.type ==
                                            "suara") {
                                          return modalNikTerdaftar();
                                        } else {
                                          return const SizedBox();
                                        }
                                      } else {
                                        return const SizedBox();
                                      }
                                    },
                                  ));
                        }
                      }
                    }
                  })
            ],
          )),
    );
  }

  modalPrepareKtp() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16.0),
          ),
        ),
        backgroundColor: kTransparentColor,
        builder: (context) => Container(
              height: 302,
              decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  )),
              padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
              child: Column(
                children: [
                  Text(
                    "Tambah Suara",
                    style: blackTextStyle.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 43,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Persiapkan terlebih dahulu\n',
                      style: blackTextStyle.copyWith(
                          fontSize: 14, fontWeight: FontWeight.w400),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Kartu Tanda Penduduk (KTP)\n',
                            style: blackTextStyle.copyWith(
                                fontSize: 13, fontWeight: FontWeight.w600)),
                        TextSpan(
                            text: 'Pendaftar sebelum menambah suara',
                            style: blackTextStyle.copyWith(
                                fontSize: 14, fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: kBackgroundBlueColor),
                          child: Center(
                            child: Text(
                              "Batal",
                              style: blueTextStyle.copyWith(
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
                        title: "Siap",
                        onPressed: () {
                          Navigator.pop(context);
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16.0),
                                ),
                              ),
                              backgroundColor: kTransparentColor,
                              builder: (context) {
                                return modalCheckKtp(context);
                              });
                        },
                      ))
                    ],
                  )
                ],
              ),
            ));
  }

  modalChooseSuara() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16.0),
          ),
        ),
        backgroundColor: kTransparentColor,
        builder: (context) => Container(
              height: 302,
              decoration: BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  )),
              padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
              child: Column(
                children: [
                  Text(
                    "Tambah Suara",
                    style: blackTextStyle.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //tambah suara
                      GestureDetector(
                        onTap: () {
                          SharedPreference.choosedRoleSuara
                              ?.setString("role", "suara");
                          Navigator.pop(context);
                          modalPrepareKtp();
                        },
                        child: Container(
                            width: 148,
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(33),
                              border: Border.all(color: kBorderSuaraColor),
                            ),
                            child: SizedBox(
                              width: 100,
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/ic_suara.png",
                                    height: 46,
                                    width: 46,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Suara",
                                    style: blackTextStyle.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            )),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      //tambah pin
                      GestureDetector(
                        onTap: () {
                          SharedPreference.choosedRoleSuara
                              ?.setString("role", "pin");
                          Navigator.pop(context);
                          modalPrepareKtp();
                        },
                        child: Container(
                            width: 148,
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(33),
                              border: Border.all(color: kBorderPinColor),
                            ),
                            child: SizedBox(
                              width: 100,
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/ic_pin.png",
                                    height: 46,
                                    width: 46,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "PIN",
                                    style: blackTextStyle.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            )),
                      )
                    ],
                  )
                ],
              ),
            ));
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Form(
      key: formKey,
      child: BlocBuilder<NavbarCubit, int>(
        builder: (context, currentIndex) {
          Widget buildContent(int currentIndex) {
            switch (currentIndex) {
              case 0:
                return const HomePage();
              case 1:
                return const KandidatPage();
              case 2:
                return const AddPage();
              case 3:
                return const SuaraPage();
              case 4:
                return const AkunPage();
              default:
                return const HomePage();
            }
          }

          return Scaffold(
              body: Stack(
            children: [
              Column(
                children: [
                  Expanded(child: buildContent(currentIndex)),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      decoration:
                          BoxDecoration(color: kPureWhiteColor, boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(
                              0, -0.1), // changes position of shadow
                        ),
                      ]),
                      child: Container(
                        decoration: BoxDecoration(
                            color: kPureWhiteColor,
                            boxShadow: const [
                              // BoxShadow(
                              //     blurStyle: BlurStyle.outer,
                              //     blurRadius: 2.0,
                              //     spreadRadius: 0.1,
                              //     offset: Offset(0, -0.1)
                              // )
                            ]),
                        // ignore: prefer_const_constructors
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            // ignore: prefer_const_constructors
                            CustomBottomNavigationItem(
                              index: 0,
                              imageNavbar0: 'assets/ic_home_0.png',
                              imageNavbar1: 'assets/ic_home_1.png',
                              titleNavbar: 'Home',
                            ),
                            // ignore: prefer_const_constructors
                            CustomBottomNavigationItem(
                              index: 1,
                              imageNavbar0: 'assets/ic_kandidat_0.png',
                              imageNavbar1: 'assets/ic_kandidat_1.png',
                              titleNavbar: 'Kandidat',
                            ),
                            // ignore: prefer_const_constructors
                            CustomBottomNavigationItem(
                              index: 2,
                              imageNavbar0: 'assets/ic_suara_0.png',
                              imageNavbar1: 'assets/ic_suara_1.png',
                              titleNavbar: '',
                            ),
                            // ignore: prefer_const_constructors
                            CustomBottomNavigationItem(
                              index: 3,
                              imageNavbar0: 'assets/ic_suara_0.png',
                              imageNavbar1: 'assets/ic_suara_1.png',
                              titleNavbar: 'Suara',
                            ),
                            // ignore: prefer_const_constructors
                            CustomBottomNavigationItem(
                              index: 4,
                              imageNavbar0: 'assets/ic_akun_0.png',
                              imageNavbar1: 'assets/ic_akun_1.png',
                              titleNavbar: 'Akun',
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  if (state is DataUserSuccess) {
                    roleSuara = state.dataUserModel.data.role;
                    idCalon = state.dataUserModel.data.idCalon;
                  }
                  return Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                          onTap: () {
                            if (roleSuara == "tim") {
                              SharedPreference.choosedRoleSuara
                                  ?.setString("role", "suara");
                              modalPrepareKtp();
                              
                              // modalChooseSuara(); sementara pin di hide
                            } else {
                              SharedPreference.choosedRoleSuara
                                  ?.setString("role", "suara");
                              modalPrepareKtp();
                            }
                          },
                          child: Image.asset(
                            "assets/ic_btn_add.png",
                            height: 56,
                            width: 56,
                          ),
                        )),
                  );
                },
              )
            ],
          ));
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
