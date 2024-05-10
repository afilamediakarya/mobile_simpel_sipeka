// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import "package:flutter/material.dart";
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:simpel/cubit/confirm_photo_rumah_cubit.dart';
import 'package:simpel/cubit/confirm_photo_swafoto_cubit.dart';
import 'package:simpel/cubit/pencarian_nik_cubit.dart';
import 'package:simpel/cubit/show_hide_pass_cubit.dart';
import 'package:simpel/cubit/tambah_data_suara_sementara_cubit.dart';
import 'package:simpel/cubit/tambah_suara_bukan_dpt_cubit.dart';
import 'package:simpel/cubit/tambah_suara_dpt_cubit.dart';
import 'package:simpel/cubit/type_user_cubit.dart';
import 'package:simpel/cubit/user_cubit.dart';
import 'package:simpel/models/tambah_data_suara_bukan_dpt_model.dart';
import 'package:simpel/models/tambah_data_suara_dpt_model.dart';
import 'package:simpel/shared/shared_prefrences.dart';
import 'package:simpel/shared/theme.dart';
import 'package:simpel/ui/widgets/custom_primary_button.dart';
import 'package:simpel/ui/widgets/custom_text_form_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simpel/ui/widgets/dialog_failed.dart';
import 'package:simpel/ui/widgets/dialog_loading.dart';
import 'package:simpel/ui/widgets/dialog_other.dart';
import 'package:simpel/ui/widgets/dialog_success.dart';
import 'package:simpel/ui/widgets/custom_text_form_field_icon_right.dart';

class TambahSuaraPage extends StatelessWidget {
  const TambahSuaraPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final String uuid = SharedPreference.login.getString("uuid");

    final TextEditingController noTeleponController =
        TextEditingController(text: '');

    final TextEditingController alasanController =
        TextEditingController(text: '');

    final TextEditingController usernamePinController =
        TextEditingController(text: '');

    final TextEditingController passwordController =
        TextEditingController(text: '');

    String komunitasValue = "";

    String roleSuara = SharedPreference.choosedRoleSuara.getString("role");

    List<String> dataHubunganDenganTim = [
      "Orang Tua Kandung",
      "Saudara Kandung",
      "Sepupu",
      "Anak Kandung",
      "Paman",
      "Tante",
      "Kemanakan",
      "Tetangga",
      "Kerabat Jauh"
    ];

    List<Map<String, String>> dataStatusPemilihan = [
      {'label': 'Pemilih Aktif', 'value': 'aktif'},
      {'label': 'Pemilih Pasif', 'value': 'pasif'}
    ];

    List<String> labelList =
        dataStatusPemilihan.map((e) => e['label'] ?? '').toList();
    List<String> valueList =
        dataStatusPemilihan.map((e) => e['value'] ?? '').toList();

    String syaratFotoRumah = """
* Foto rumah dari depan 

* Foto rumah harus tampak jelas dan menyeluruh

""";

    String syaratSwafoto = """
* Seluruh wajah menghadap kamera 

* Foto dengan pencahayaan yang cukup

""";

    modalPrepareFotoRumah() {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16.0),
            ),
          ),
          backgroundColor: kTransparentColor,
          builder: (context) => Container(
                height: 450,
                decoration: BoxDecoration(
                    color: kPureWhiteColor,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(24),
                    )),
                padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
                child: Column(
                  children: [
                    Text(
                      "Foto Rumah",
                      style: blackTextStyle.copyWith(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          children: [
                            Container(
                              height: 148,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: const DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                        "assets/rumah_2.png",
                                      ))),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "assets/ic_yes.png",
                                  width: 24,
                                  height: 24,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Benar",
                                  style: blackTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            )
                          ],
                        )),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                            child: Column(
                          children: [
                            Container(
                              height: 148,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: const DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                        "assets/rumah_1.png",
                                      ))),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "assets/ic_not.png",
                                  width: 24,
                                  height: 24,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Salah",
                                  style: blackTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            )
                          ],
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                        height: 50,
                        color: kPureWhiteColor,
                        child: Markdown(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            data: syaratFotoRumah)),
                    const Expanded(child: SizedBox()),
                    CustomPrimaryButton(
                        title: "Foto Sekarang",
                        onPressed: () {
                          Navigator.pushNamed(context, "camera-rumah");
                        }),
                    const SizedBox(
                      height: 24,
                    )
                  ],
                ),
              ));
    }

    modalPrepareSwafoto() {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16.0),
            ),
          ),
          backgroundColor: kTransparentColor,
          builder: (context) => Container(
                height: 460,
                decoration: BoxDecoration(
                    color: kPureWhiteColor,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(24),
                    )),
                padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
                child: Column(
                  children: [
                    Text(
                      "Swafoto",
                      style: blackTextStyle.copyWith(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          children: [
                            Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                    "assets/suara_1.png",
                                  ))),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "assets/ic_yes.png",
                                  width: 24,
                                  height: 24,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Benar",
                                  style: blackTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            )
                          ],
                        )),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                            child: Column(
                          children: [
                            Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                    "assets/suara_3.png",
                                  ))),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "assets/ic_not.png",
                                  width: 24,
                                  height: 24,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Salah",
                                  style: blackTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            )
                          ],
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                        height: 50,
                        color: kPureWhiteColor,
                        child: Markdown(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            data: syaratSwafoto)),
                    const Expanded(child: SizedBox()),
                    CustomPrimaryButton(
                        title: "Foto Sekarang",
                        onPressed: () {
                          Navigator.pushNamed(context, "camera-swafoto");
                        }),
                    const SizedBox(
                      height: 24,
                    )
                  ],
                ),
              ));
    }

    String pathPhotoRumah = "-";
    String pathPhotoSwafoto = "-";
    String type = "-";
    String nik = "-";
    String alasan = "-";
    String hdt = "-";
    String tkp = "-";
    String statusPemilih = "-";

    bool validateDataSuara() {
      if (noTeleponController.text.isEmpty ||
          alasan == "-" ||
          pathPhotoSwafoto == "-" ||
          pathPhotoRumah == "-") {
        return false;
      } else {
        return true;
      }
    }

    bool validateDataSuaraDpt() {
      if (noTeleponController.text.isEmpty ||
          alasan == "-" ||
          pathPhotoSwafoto == "-" ||
          pathPhotoRumah == "-") {
        return false;
      } else {
        return true;
      }
    }

    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: kPureWhiteColor,
        appBar: AppBar(
          centerTitle: true,
          shadowColor: kGreyColor,
          title: Text(
            "Tambah Suara",
            style: blackTextStyle.copyWith(
                fontSize: 16, fontWeight: FontWeight.w500),
          ),
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Image.asset(
                'assets/ic_arrow_left.png',
                width: 24,
                height: 24,
              )),
          backgroundColor: kWhiteColor,
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: BlocBuilder<TypeUserCubit, String>(
              builder: (context, state) {
                String idUser = SharedPreference.login.getString("idUser");

                ///section dpt
                if (state == "dpt") {
                  return BlocBuilder<PencarianNikCubit, PencarianNikState>(
                    builder: (context, state) {
                      if (state is PencarianNikSuccess) {
                        nik = SharedPreference.nikDpt.getString("nik_dpt");
                        type = state.pencarianNikModel.data.type;
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Data Pribadi",
                            style: blackTextStyle.copyWith(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: BlocBuilder<ConfirmPhotoSwafotoCubit,
                                    ConfirmPhotoSwafotoState>(
                                  builder: (context, state) {
                                    if (state is ConfirmPhotoSwafotoSuccess) {
                                      pathPhotoSwafoto = state.xFile.path;
                                      return GestureDetector(
                                        onTap: () {
                                          modalPrepareSwafoto();
                                        },
                                        child: Container(
                                            width: 148,
                                            height: 148,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: kUploadColor),
                                            child: Image.file(
                                              File(state.xFile.path),
                                              fit: BoxFit.fitWidth,
                                            )),
                                      );
                                    } else if (state
                                        is ConfirmPhotoSwafotoLoading) {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          backgroundColor: kPrimaryColor,
                                          color: kSecondaryColor,
                                        ),
                                      );
                                    } else if (state
                                        is ConfirmPhotoSwafotoFailed) {
                                      return Center(
                                        child: Text(state.error),
                                      );
                                    } else {
                                      return GestureDetector(
                                        onTap: () {
                                          modalPrepareSwafoto();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: kUploadColor),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 34, horizontal: 26),
                                          child: Center(
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  "assets/ic_plus.png",
                                                  width: 42,
                                                  height: 42,
                                                ),
                                                const SizedBox(
                                                  height: 24,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      "assets/ic_info.png",
                                                      height: 16,
                                                      width: 16,
                                                    ),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text(
                                                      "Upload Swafoto",
                                                      style: blackTextStyle
                                                          .copyWith(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: BlocBuilder<ConfirmPhotoRumahCubit,
                                    ConfirmPhotoRumahState>(
                                  builder: (context, state) {
                                    if (state is ConfirmPhotoRumahSuccess) {
                                      pathPhotoRumah = state.xFile.path;
                                      return GestureDetector(
                                        onTap: () {
                                          modalPrepareFotoRumah();
                                        },
                                        child: Container(
                                            width: 148,
                                            height: 148,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: kUploadColor),
                                            child: Image.file(
                                              File(state.xFile.path),
                                              fit: BoxFit.fitWidth,
                                            )),
                                      );
                                    } else if (state
                                        is ConfirmPhotoRumahLoading) {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          backgroundColor: kPrimaryColor,
                                          color: kSecondaryColor,
                                        ),
                                      );
                                    } else if (state
                                        is ConfirmPhotoRumahFailed) {
                                      return Center(
                                        child: Text(state.error),
                                      );
                                    } else {
                                      return GestureDetector(
                                        onTap: () {
                                          modalPrepareFotoRumah();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: kUploadColor),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 34, horizontal: 26),
                                          child: Center(
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  "assets/ic_plus.png",
                                                  width: 42,
                                                  height: 42,
                                                ),
                                                const SizedBox(
                                                  height: 24,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      "assets/ic_info.png",
                                                      height: 16,
                                                      width: 16,
                                                    ),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text(
                                                      "Upload Foto Rumah",
                                                      style: blackTextStyle
                                                          .copyWith(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Text(
                            "Nomor Telepon",
                            style: blackTextStyle.copyWith(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          CustomTextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Nomor Telepon tidak boleh kosong';
                                }
                                return null;
                              },
                              textInputType: TextInputType.number,
                              hintText: "Masukkan No Telepon",
                              cursorColor: kBlackColor,
                              enabledColor: kBorderColor,
                              fillColor: kPureWhiteColor,
                              focusedColor: kPrimaryColor,
                              hintStyle: greyTextStyle.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                              maxLines: 1,
                              textEditingController: noTeleponController,
                              textStyle: blackTextStyle.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w400)),
                          const SizedBox(
                            height: 24,
                          ),
                          Text(
                            "Alasan",
                            style: blackTextStyle.copyWith(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          DropdownSearch<String>(
                            itemAsString: (selectedItem) {
                              return selectedItem;
                            },
                            items: const [
                              "Sewilayah",
                              "Dermawan",
                              "Relasi/Sahabat",
                              "Pilihan Keluarga",
                              "Visi/Misi",
                              "Referensi Tokoh",
                              "Keluarga"
                            ],
                            onChanged: (value) {
                              alasan = value!;
                            },
                            dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 14, horizontal: 16),
                                    filled: true,
                                    fillColor: kPureWhiteColor,
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: kBorderDisabledFieldColor,
                                            width: 1.0),
                                        borderRadius:
                                            BorderRadius.circular(4)))),
                            dropdownBuilder: (context, selectedItem) {
                              return selectedItem == null
                                  ? Text(
                                      "Pilih Alasan Memilih",
                                      style: greyTextStyle.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    )
                                  : Text(selectedItem);
                            },
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Text(
                            "Hubungan dengan TIM",
                            style: blackTextStyle.copyWith(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          FormField<String>(validator: (value) {
                            if (hdt == "-") {
                              return "Pilih Hubungan terlebih dahulu !";
                            }
                            return null;
                          }, builder: (formFieldState) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DropdownSearch<String>(
                                  itemAsString: (selectedItem) {
                                    return selectedItem;
                                  },
                                  items: dataHubunganDenganTim,
                                  onChanged: (value) {
                                    hdt = value!;
                                  },
                                  dropdownDecoratorProps: DropDownDecoratorProps(
                                      dropdownSearchDecoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 14, horizontal: 16),
                                          filled: true,
                                          fillColor: kPureWhiteColor,
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                      kBorderDisabledFieldColor),
                                              borderRadius:
                                                  BorderRadius.circular(4)))),
                                  dropdownBuilder: (context, selectedItem) {
                                    return selectedItem == null
                                        ? Text(
                                            "Pilih Hubungan",
                                            style: greyTextStyle.copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          )
                                        : Text(selectedItem);
                                  },
                                ),
                                if (formFieldState.hasError)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 12),
                                    child: Text(
                                      formFieldState.errorText!,
                                      style: TextStyle(
                                          fontStyle: FontStyle.normal,
                                          fontSize: 12,
                                          color: Colors.red[700],
                                          height: 0.5),
                                    ),
                                  )
                              ],
                            );
                          }),
                          const SizedBox(
                            height: 24,
                          ),
                          Text(
                            "Status Pemilih",
                            style: blackTextStyle.copyWith(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          FormField(validator: (value) {
                            if (statusPemilih == "-") {
                              return "Pilih Status Pemilih terlebih dahulu !";
                            }
                            return null;
                          }, builder: (formFieldState) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DropdownSearch(
                                  itemAsString: (selectedItem) {
                                    return selectedItem;
                                  },
                                  items: labelList,
                                  onChanged: (value) {
                                    String? correspondingValue =
                                        dataStatusPemilihan.firstWhere((e) =>
                                            e['label'] == value)['value'];
                                    statusPemilih = correspondingValue!;
                                  },
                                  dropdownDecoratorProps: DropDownDecoratorProps(
                                      dropdownSearchDecoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 14, horizontal: 16),
                                          filled: true,
                                          fillColor: kPureWhiteColor,
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                      kBorderDisabledFieldColor),
                                              borderRadius:
                                                  BorderRadius.circular(4)))),
                                  dropdownBuilder: (context, selectedItem) {
                                    return selectedItem == null
                                        ? Text(
                                            "Pilih Status Pemilh",
                                            style: greyTextStyle.copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          )
                                        : Text(selectedItem);
                                  },
                                ),
                                if (formFieldState.hasError)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 12),
                                    child: Text(
                                      formFieldState.errorText!,
                                      style: TextStyle(
                                          fontStyle: FontStyle.normal,
                                          fontSize: 12,
                                          color: Colors.red[700],
                                          height: 0.5),
                                    ),
                                  )
                              ],
                            );
                          }),
                          Visibility(
                              visible: roleSuara == "pin" ? true : false,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Username",
                                    style: blackTextStyle.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  CustomTextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Username tidak boleh kosong';
                                        }
                                        return null;
                                      },
                                      textInputType: TextInputType.text,
                                      hintText: "Masukkan Username PIN",
                                      cursorColor: kBlackColor,
                                      enabledColor: kBorderColor,
                                      fillColor: kPureWhiteColor,
                                      focusedColor: kPrimaryColor,
                                      hintStyle: greyTextStyle.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                      maxLines: 1,
                                      textEditingController:
                                          usernamePinController,
                                      textStyle: blackTextStyle.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400)),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  Text(
                                    "Password",
                                    style: blackTextStyle.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  BlocBuilder<ShowHidePassCubit, bool>(
                                    builder: (context, state) {
                                      return CustomTextFormFieldIconRight(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
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
                                          controller: passwordController,
                                          backgroundColor: kPureWhiteColor,
                                          borderColor: kBorderColor,
                                          textInputType: TextInputType.text,
                                          maxLines: 1,
                                          obscureText: state,
                                          hintStyle: greyTextStyle.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                          textStyle: blackTextStyle.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                          enabled: true);
                                    },
                                  ),
                                ],
                              )),
                          const SizedBox(
                            height: 32,
                          ),
                          CustomPrimaryButton(
                              title: "Tambah",
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  if (!validateDataSuaraDpt()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            backgroundColor: Colors.red,
                                            content: Text(
                                                "Lengkapi form terlebih dahulu !")));
                                  } else {
                                    //tambah suara dpt
                                    context
                                        .read<TambahSuaraDptCubit>()
                                        .tambahSuaraDpt(
                                          tambahDataSuaraDptModel:
                                              TambahDataSuaraDptModel(
                                                  nik: nik,
                                                  noTelp:
                                                      noTeleponController.text,
                                                  alasan: alasan,
                                                  idUser: idUser,
                                                  pathPhotoSwafoto:
                                                      pathPhotoSwafoto,
                                                  pathPhotoRumah:
                                                      pathPhotoRumah,
                                                  type: type,
                                                  hdt: hdt,
                                                  tkp: tkp,
                                                  statusPemilih: statusPemilih,
                                                  username:
                                                      usernamePinController
                                                          .text,
                                                  password:
                                                      passwordController.text),
                                        );

                                    showDialog(
                                        barrierDismissible: true,
                                        context: context,
                                        builder: (context) => BlocBuilder<
                                                TambahSuaraDptCubit,
                                                TambahSuaraDptState>(
                                              builder: (context, state) {
                                                if (state
                                                    is TambahSuaraDptSuccess) {
                                                  return DialogSuccess(
                                                    desc:
                                                        "Data Suara Anda Berhasil di Input",
                                                    onTap: () {
                                                      context
                                                          .read<UserCubit>()
                                                          .getDataUser(
                                                              uuid: uuid);
                                                      Navigator.popAndPushNamed(
                                                          context, "main");
                                                    },
                                                  );
                                                } else if (state
                                                    is TambahSuaraDptLoading) {
                                                  return const DialogLoading();
                                                } else if (state
                                                    is TambahSuaraDptFailed) {
                                                  return DialogFailed(
                                                      desc: state.error);
                                                } else {
                                                  return const DialogOther();
                                                }
                                              },
                                            ));
                                  }
                                }
                              })
                        ],
                      );
                    },
                  );
                } else {
                  ///section bukan dpt
                  return BlocBuilder<TambahDataSuaraSementaraCubit,
                      TambahDataSuaraSementaraState>(
                    builder: (context, state) {
                      String noKK = "-";
                      String nama = "-";
                      String jenisKelamin = "-";
                      String statusKawin = "-";
                      String tempatLahir = "-";
                      String tanggalLahir = "-";
                      String alamat = "-";
                      String idKabupaten = "-";
                      String idKecamatan = "-";
                      String idKelurahan = "-";
                      String rt = "-";
                      String rw = "-";
                      String tps = "-";

                      if (state is TambahDataSuaraSementaraSuccess) {
                        nik =
                            state.tambahDataSuaraSementaraModel.nik.toString();
                        noKK =
                            state.tambahDataSuaraSementaraModel.noKK.toString();
                        nama = state.tambahDataSuaraSementaraModel.name;
                        jenisKelamin =
                            state.tambahDataSuaraSementaraModel.jenisKelamin;
                        statusKawin = state
                            .tambahDataSuaraSementaraModel.statusPerkawinan;
                        tempatLahir =
                            state.tambahDataSuaraSementaraModel.tempatLahir;
                        tanggalLahir =
                            state.tambahDataSuaraSementaraModel.tanggalLahir;
                        alamat = state.tambahDataSuaraSementaraModel.address;
                        idKelurahan =
                            state.tambahDataSuaraSementaraModel.idKelurahan;
                        rt = state.tambahDataSuaraSementaraModel.rt;
                        rw = state.tambahDataSuaraSementaraModel.rw;
                        tps = state.tambahDataSuaraSementaraModel.tps;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Data Pribadi",
                              style: blackTextStyle.copyWith(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: BlocBuilder<ConfirmPhotoSwafotoCubit,
                                      ConfirmPhotoSwafotoState>(
                                    builder: (context, state) {
                                      if (state is ConfirmPhotoSwafotoSuccess) {
                                        pathPhotoSwafoto = state.xFile.path;
                                        return GestureDetector(
                                          onTap: () {
                                            modalPrepareSwafoto();
                                          },
                                          child: Container(
                                              width: 148,
                                              height: 148,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  color: kUploadColor),
                                              child: Image.file(
                                                File(state.xFile.path),
                                                fit: BoxFit.fitWidth,
                                              )),
                                        );
                                      } else if (state
                                          is ConfirmPhotoSwafotoLoading) {
                                        return Center(
                                          child: CircularProgressIndicator(
                                            backgroundColor: kPrimaryColor,
                                            color: kSecondaryColor,
                                          ),
                                        );
                                      } else if (state
                                          is ConfirmPhotoSwafotoFailed) {
                                        return Center(
                                          child: Text(state.error),
                                        );
                                      } else {
                                        return GestureDetector(
                                          onTap: () {
                                            modalPrepareSwafoto();
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: kUploadColor),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 34, horizontal: 26),
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    "assets/ic_plus.png",
                                                    width: 42,
                                                    height: 42,
                                                  ),
                                                  const SizedBox(
                                                    height: 24,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.asset(
                                                        "assets/ic_info.png",
                                                        height: 16,
                                                        width: 16,
                                                      ),
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      Text(
                                                        "Upload Swafoto",
                                                        style: blackTextStyle
                                                            .copyWith(
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: BlocBuilder<ConfirmPhotoRumahCubit,
                                      ConfirmPhotoRumahState>(
                                    builder: (context, state) {
                                      if (state is ConfirmPhotoRumahSuccess) {
                                        pathPhotoRumah = state.xFile.path;
                                        return GestureDetector(
                                          onTap: () {
                                            modalPrepareFotoRumah();
                                          },
                                          child: Container(
                                              width: 148,
                                              height: 148,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  color: kUploadColor),
                                              child: Image.file(
                                                File(state.xFile.path),
                                                fit: BoxFit.fitWidth,
                                              )),
                                        );
                                      } else if (state
                                          is ConfirmPhotoRumahLoading) {
                                        return Center(
                                          child: CircularProgressIndicator(
                                            backgroundColor: kPrimaryColor,
                                            color: kSecondaryColor,
                                          ),
                                        );
                                      } else if (state
                                          is ConfirmPhotoRumahFailed) {
                                        return Center(
                                          child: Text(state.error),
                                        );
                                      } else {
                                        return GestureDetector(
                                          onTap: () {
                                            modalPrepareFotoRumah();
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: kUploadColor),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 34, horizontal: 26),
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  Image.asset(
                                                    "assets/ic_plus.png",
                                                    width: 42,
                                                    height: 42,
                                                  ),
                                                  const SizedBox(
                                                    height: 24,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.asset(
                                                        "assets/ic_info.png",
                                                        height: 16,
                                                        width: 16,
                                                      ),
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      Text(
                                                        "Upload Foto Rumah",
                                                        style: blackTextStyle
                                                            .copyWith(
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Text(
                              "Nomor Telepon",
                              style: blackTextStyle.copyWith(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            CustomTextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Nomor Telepon tidak boleh kosong';
                                  }
                                  return null;
                                },
                                textInputType: TextInputType.number,
                                hintText: "Masukkan No Telepon",
                                cursorColor: kBlackColor,
                                enabledColor: kBorderColor,
                                fillColor: kPureWhiteColor,
                                focusedColor: kPrimaryColor,
                                hintStyle: greyTextStyle.copyWith(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                                maxLines: 1,
                                textEditingController: noTeleponController,
                                textStyle: blackTextStyle.copyWith(
                                    fontSize: 14, fontWeight: FontWeight.w400)),
                            const SizedBox(
                              height: 24,
                            ),
                            Text(
                              "Alasan",
                              style: blackTextStyle.copyWith(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            FormField<String>(validator: (value) {
                              if (alasan == "-") {
                                return "Pilih Alasan terlebih dahulu !";
                              }
                              return null;
                            }, builder: (formFieldState) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DropdownSearch<String>(
                                    itemAsString: (selectedItem) {
                                      return selectedItem;
                                    },
                                    items: const [
                                      "Sewilayah",
                                      "Dermawan",
                                      "Relasi/Sahabat",
                                      "Pilihan Keluarga",
                                      "Visi/Misi",
                                      "Referensi Tokoh",
                                      "Keluarga"
                                    ],
                                    onChanged: (value) {
                                      alasan = value!;
                                    },
                                    dropdownDecoratorProps: DropDownDecoratorProps(
                                        dropdownSearchDecoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 14,
                                                    horizontal: 16),
                                            filled: true,
                                            fillColor: kPureWhiteColor,
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        kBorderDisabledFieldColor,
                                                    width: 1.0),
                                                borderRadius:
                                                    BorderRadius.circular(4)))),
                                    dropdownBuilder: (context, selectedItem) {
                                      return selectedItem == null
                                          ? Text(
                                              "Pilih Alasan Memilih",
                                              style: greyTextStyle.copyWith(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          : Text(selectedItem);
                                    },
                                  ),
                                  if (formFieldState.hasError)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 12),
                                      child: Text(
                                        formFieldState.errorText!,
                                        style: TextStyle(
                                            fontStyle: FontStyle.normal,
                                            fontSize: 12,
                                            color: Colors.red[700],
                                            height: 0.5),
                                      ),
                                    )
                                ],
                              );
                            }),
                            const SizedBox(
                              height: 24,
                            ),
                            Text(
                              "Hubungan dengan TIM",
                              style: blackTextStyle.copyWith(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            FormField<String>(validator: (value) {
                              if (hdt == "-") {
                                return "Pilih Hubungan terlebih dahulu !";
                              }
                              return null;
                            }, builder: (formFieldState) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DropdownSearch<String>(
                                    itemAsString: (selectedItem) {
                                      return selectedItem;
                                    },
                                    items: dataHubunganDenganTim,
                                    onChanged: (value) {
                                      hdt = value!;
                                    },
                                    dropdownDecoratorProps: DropDownDecoratorProps(
                                        dropdownSearchDecoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 14,
                                                    horizontal: 16),
                                            filled: true,
                                            fillColor: kPureWhiteColor,
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        kBorderDisabledFieldColor),
                                                borderRadius:
                                                    BorderRadius.circular(4)))),
                                    dropdownBuilder: (context, selectedItem) {
                                      return selectedItem == null
                                          ? Text(
                                              "Pilih Hubungan",
                                              style: greyTextStyle.copyWith(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          : Text(selectedItem);
                                    },
                                  ),
                                  if (formFieldState.hasError)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 12),
                                      child: Text(
                                        formFieldState.errorText!,
                                        style: TextStyle(
                                            fontStyle: FontStyle.normal,
                                            fontSize: 12,
                                            color: Colors.red[700],
                                            height: 0.5),
                                      ),
                                    )
                                ],
                              );
                            }),
                            const SizedBox(
                              height: 24,
                            ),
                            Text(
                              "Status Pemilih",
                              style: blackTextStyle.copyWith(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            FormField(validator: (value) {
                              if (statusPemilih == "-") {
                                return "Pilih Status Pemilih terlebih dahulu !";
                              }
                              return null;
                            }, builder: (formFieldState) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DropdownSearch(
                                    itemAsString: (selectedItem) {
                                      return selectedItem;
                                    },
                                    items: labelList,
                                    onChanged: (value) {
                                      String? correspondingValue =
                                          dataStatusPemilihan.firstWhere((e) =>
                                              e['label'] == value)['value'];
                                      statusPemilih = correspondingValue!;
                                    },
                                    dropdownDecoratorProps: DropDownDecoratorProps(
                                        dropdownSearchDecoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 14,
                                                    horizontal: 16),
                                            filled: true,
                                            fillColor: kPureWhiteColor,
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        kBorderDisabledFieldColor),
                                                borderRadius:
                                                    BorderRadius.circular(4)))),
                                    dropdownBuilder: (context, selectedItem) {
                                      return selectedItem == null
                                          ? Text(
                                              "Pilih Status Pemilh",
                                              style: greyTextStyle.copyWith(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          : Text(selectedItem);
                                    },
                                  ),
                                  if (formFieldState.hasError)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 12),
                                      child: Text(
                                        formFieldState.errorText!,
                                        style: TextStyle(
                                            fontStyle: FontStyle.normal,
                                            fontSize: 12,
                                            color: Colors.red[700],
                                            height: 0.5),
                                      ),
                                    )
                                ],
                              );
                            }),
                            const SizedBox(
                              height: 24,
                            ),
                            Visibility(
                                visible: roleSuara == "pin" ? true : false,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Username",
                                      style: blackTextStyle.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    CustomTextFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Username tidak boleh kosong';
                                          }
                                          return null;
                                        },
                                        textInputType: TextInputType.text,
                                        hintText: "Masukkan Username PIN",
                                        cursorColor: kBlackColor,
                                        enabledColor: kBorderColor,
                                        fillColor: kPureWhiteColor,
                                        focusedColor: kPrimaryColor,
                                        hintStyle: greyTextStyle.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                        maxLines: 1,
                                        textEditingController:
                                            usernamePinController,
                                        textStyle: blackTextStyle.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400)),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    Text(
                                      "Password",
                                      style: blackTextStyle.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    BlocBuilder<ShowHidePassCubit, bool>(
                                      builder: (context, state) {
                                        return CustomTextFormFieldIconRight(
                                            hintText: "Masukkan Password",
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Password tidak boleh kosong';
                                              }
                                              return null;
                                            },
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
                                            controller: passwordController,
                                            backgroundColor: kPureWhiteColor,
                                            borderColor: kBorderColor,
                                            textInputType: TextInputType.text,
                                            maxLines: 1,
                                            obscureText: state,
                                            hintStyle: greyTextStyle.copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                            textStyle: blackTextStyle.copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                            enabled: true);
                                      },
                                    ),
                                  ],
                                )),
                            const SizedBox(
                              height: 32,
                            ),
                            CustomPrimaryButton(
                                title: "Tambah",
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    if (!validateDataSuara()) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              backgroundColor: Colors.red,
                                              content: Text(
                                                  "Lengkapi form terlebih dahulu !")));
                                    } else {
                                      //tambah suara bukan dpt
                                      context
                                          .read<TambahSuaraBukanDptCubit>()
                                          .tambahSuaraBukanDpt(
                                            tambahDataSuaraBukanDptModel:
                                                TambahDataSuaraBukanDptModel(
                                                    nik: nik,
                                                    noKK: noKK,
                                                    nama: nama,
                                                    jenisKelamin: jenisKelamin,
                                                    statusKawin: statusKawin,
                                                    tempatLahir: tempatLahir,
                                                    tanggalLahir: tanggalLahir,
                                                    noTelp: noTeleponController
                                                        .text,
                                                    alamat: alamat,
                                                    idKelurahan: idKelurahan,
                                                    rt: rt,
                                                    rw: rw,
                                                    tps: tps,
                                                    alasan: alasan,
                                                    idUser: idUser,
                                                    pathPhotoSwafoto:
                                                        pathPhotoSwafoto,
                                                    pathPhotoRumah:
                                                        pathPhotoRumah,
                                                    type: type,
                                                    username:
                                                        usernamePinController
                                                            .text,
                                                    password:
                                                        passwordController.text,
                                                    hdt: hdt,
                                                    tkp: tkp,
                                                    statusPemilih:
                                                        statusPemilih),
                                          );

                                      showDialog(
                                          barrierDismissible: true,
                                          context: context,
                                          builder: (context) => BlocBuilder<
                                                  TambahSuaraBukanDptCubit,
                                                  TambahSuaraBukanDptState>(
                                                builder: (context, state) {
                                                  if (state
                                                      is TambahSuaraBukanDptSuccess) {
                                                    return DialogSuccess(
                                                      desc:
                                                          "Data Suara Anda Berhasil di Input",
                                                      onTap: () {
                                                        context
                                                            .read<UserCubit>()
                                                            .getDataUser(
                                                                uuid: uuid);
                                                        Navigator
                                                            .popAndPushNamed(
                                                                context,
                                                                "main");
                                                      },
                                                    );
                                                  } else if (state
                                                      is TambahSuaraBukanDptLoading) {
                                                    return const DialogLoading();
                                                  } else if (state
                                                      is TambahSuaraBukanDptFailed) {
                                                    return DialogFailed(
                                                        desc: state.error);
                                                  } else {
                                                    return const DialogOther();
                                                  }
                                                },
                                              ));
                                    }
                                  }
                                })
                          ],
                        );
                      } else {
                        return const Center(
                          child: Text("Gagal memuat data"),
                        );
                      }
                    },
                  );
                }
              },
            ),
          ),
        )),
      ),
    );
  }
}
