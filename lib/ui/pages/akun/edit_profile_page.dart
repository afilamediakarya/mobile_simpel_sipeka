// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import "package:flutter/material.dart";
import 'package:simpel/cubit/change_profile_cubit.dart';
import 'package:simpel/cubit/confirm_photo_profile_cubit.dart';
import 'package:simpel/cubit/jenis_kelamin_cubit.dart';
import 'package:simpel/cubit/list_kabupaten_cubit.dart';
import 'package:simpel/cubit/list_kecamatan_cubit.dart';
import 'package:simpel/cubit/list_kelurahan_profile_cubit.dart';
import 'package:simpel/cubit/user_cubit.dart';
import 'package:simpel/models/list_kabupaten_model.dart';
import 'package:simpel/models/list_kecamatan_model.dart';
import 'package:simpel/models/list_kelurahan_profile_model.dart';
import 'package:simpel/shared/shared_prefrences.dart';
import 'package:simpel/shared/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simpel/ui/pages/akun/confirm_profile_picture_page.dart';
import 'package:simpel/ui/widgets/custom_primary_button.dart';
import 'package:simpel/ui/widgets/dialog_failed.dart';
import 'package:simpel/ui/widgets/dialog_loading.dart';
import 'package:simpel/ui/widgets/dialog_other.dart';
import 'package:simpel/ui/widgets/dialog_success.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../../services/base_url.dart' as base_url;

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController(text: '');
  final TextEditingController addressController = TextEditingController(text: '');
  String pathPhotoProfile = "";

  var nik,
      gender,
      foto,
      kabupaten,
      kecamatan,
      kelurahan,
      // idKomunitas,
      jenisKelamin;

  int kabupatenId = 0;
  int kecamatanId = 0;
  int kelurahanId = 0;

  File pickFile = File('');

  String uuid = SharedPreference.login.getString("uuid");

  @override
  Widget build(BuildContext context) {
    bool validateData() {
      if (nameController.text.isEmpty ||
          addressController.text.isEmpty ||
          kelurahanId == 0) {
        return false;
      } else {
        return true;
      }
    }

    pickFileProfilePhoto() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        pickFile = File(result.files.single.path!);

        XFile file = XFile(result.files.single.path!);

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ConfirmProfilePicturePage(picture: file)));
      } else {
        // User canceled the picker
      }
    }

    modalOptionChangeProfilePicture() {
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
                      "Pilih Opsi ",
                      style: blackTextStyle.copyWith(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 43,
                    ),
                    Text(
                      'Pilih opsi untuk mengganti foto profil.\npilih menggunakan kamera atau pilih file',
                      textAlign: TextAlign.center,
                      style: blackTextStyle.copyWith(
                          fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: CustomPrimaryButton(
                          title: 'Kamera',
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, 'camera-profile');
                          },
                        )),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                            child: CustomPrimaryButton(
                          title: "Pilih Foto",
                          onPressed: () {
                            pickFileProfilePhoto();
                          },
                        ))
                      ],
                    )
                  ],
                ),
              ));
    }

    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: kPureWhiteColor,
        body: SafeArea(child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is DataUserSuccess) {
              nik = state.dataUserModel.data.nik;
              nameController.text = state.dataUserModel.data.nama;
              gender = state.dataUserModel.data.jenisKelamin;
              addressController.text = state.dataUserModel.data.alamat;
              foto = state.dataUserModel.data.foto;
              kabupaten = state
                  .dataUserModel.data.kabupatenKota;
              kecamatan = state.dataUserModel.data.kecamatan;
              kelurahan = state.dataUserModel.data.kelurahan;
              kelurahanId = state.dataUserModel.data.idDesa;
              // idKomunitas = state.dataUserModel.data.idKomunitas;
              context
                  .read<JenisKelaminCubit>()
                  .setGender(gender == "L" ? 0 : 1);
            } else {
              nik = "-";
              nameController.text = "-";
              gender = "-";
              addressController.text = "-";
              foto = "";
              kabupaten = "-";
              kecamatan = "-";
              kelurahan = "-";
              // idKomunitas = 0;
            }
            return Column(
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
                          "Profile",
                          style: blackTextStyle.copyWith(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 100,
                                width: 106,
                                child: Center(
                                  child: BlocBuilder<ConfirmPhotoProfileCubit,
                                      ConfirmPhotoProfileState>(
                                    builder: (context, state) {
                                      if (state is ConfirmPhotoProfileSuccess) {
                                        pathPhotoProfile = state.xFile.path;

                                        return GestureDetector(
                                          onTap: () {
                                            modalOptionChangeProfilePicture();
                                          },
                                          child: Stack(
                                            children: [
                                              SizedBox(
                                                height: 100,
                                                width: 100,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(4)),
                                                  child: Image.file(
                                                    File(state.xFile.path),
                                                    fit: BoxFit.fitWidth,
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 5),
                                                  child: Image.asset(
                                                    "assets/ic_edit_photo_profile.png",
                                                    height: 24,
                                                    width: 24,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      } else if (state
                                          is ConfirmPhotoProfileLoading) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else if (state
                                          is ConfirmPhotoProfileFailed) {
                                        return const Center(
                                          child: Text("Gagal memuat foto"),
                                        );
                                      } else {
                                        return GestureDetector(
                                          onTap: () {
                                            modalOptionChangeProfilePicture();
                                          },
                                          child: Stack(
                                            children: [
                                              foto == ""
                                                  ? Image.asset(
                                                      "assets/ic_avatar.png",
                                                      height: 100,
                                                      width: 100,
                                                    )
                                                  : ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      child: FadeInImage
                                                          .memoryNetwork(
                                                        image:
                                                            "${base_url.urlPhoto}$foto",
                                                        placeholder:
                                                            kTransparentImage,
                                                            placeholderScale: 100,
                                                        imageErrorBuilder:
                                                            (context, error,
                                                                stackTrace) {
                                                          return Image.asset(
                                                            'assets/ic_error_img.png',
                                                            width: 100,
                                                            height: 100,
                                                          );
                                                        },
                                                      ),
                                                    ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 5),
                                                  child: Image.asset(
                                                    "assets/ic_edit_photo_profile.png",
                                                    height: 24,
                                                    width: 24,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Text(
                            "NIK",
                            style: blackTextStyle.copyWith(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                vertical: 14, horizontal: 16),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: kBorderDisabledFieldColor),
                                color:
                                    const Color.fromRGBO(143, 155, 179, 0.08),
                                borderRadius: BorderRadius.circular(4)),
                            child: Text(
                              nik,
                              style: greyTextStyle.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Text(
                            "Nama",
                            style: blackTextStyle.copyWith(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            inputFormatters: const [],
                            enabled: true,
                            scrollPadding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            maxLines: 1,
                            style: blackTextStyle.copyWith(
                                fontSize: 14, fontWeight: FontWeight.w400),
                            cursorColor: kBlackColor,
                            controller: nameController,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value == '') {
                                return 'Mohon isi form !';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: kPureWhiteColor,
                                isDense: true,
                                hintText: nameController.text,
                                hintStyle: greyTextStyle.copyWith(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                                enabled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                        color: kBorderDisabledFieldColor)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide:
                                        BorderSide(color: kPrimaryColor))),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Text(
                            "Jenis Kelamin",
                            style: blackTextStyle.copyWith(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          BlocBuilder<JenisKelaminCubit, int>(
                            builder: (context, state) {
                              jenisKelamin = state == 0 ? "L" : "P";
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Radio(
                                          value: 0,
                                          activeColor: kPrimaryColor,
                                          groupValue: state,
                                          onChanged: (dynamic val) {
                                            context
                                                .read<JenisKelaminCubit>()
                                                .setGender(val);
                                          }),
                                      Text(
                                        "Laki-Laki",
                                        style: blackTextStyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                          value: 1,
                                          activeColor: kPrimaryColor,
                                          groupValue: state,
                                          onChanged: (dynamic val) {
                                            context
                                                .read<JenisKelaminCubit>()
                                                .setGender(val);
                                          }),
                                      Text(
                                        "Perempuan",
                                        style: blackTextStyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  )
                                ],
                              );
                            },
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Text(
                            "Alamat",
                            style: blackTextStyle.copyWith(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            inputFormatters: const [],
                            enabled: true,
                            scrollPadding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            maxLines: 5,
                            style: blackTextStyle.copyWith(
                                fontSize: 14, fontWeight: FontWeight.w400),
                            cursorColor: kBlackColor,
                            controller: addressController,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value == '') {
                                return 'Mohon isi form !';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: kPureWhiteColor,
                                isDense: true,
                                hintText: addressController.text,
                                hintStyle: greyTextStyle.copyWith(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                                enabled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide(
                                        color: kBorderDisabledFieldColor)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide:
                                        BorderSide(color: kPrimaryColor))),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Text(
                            "Kabupaten",
                            style: blackTextStyle.copyWith(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          BlocBuilder<ListKabupatenCubit, ListKabupatenState>(
                            builder: (context, state) {
                              List<DataListKabupaten> allKabupatenData = [];
                              if (state is ListKabupatenSuccess) {
                                return DropdownSearch<DataListKabupaten>(
                                  asyncItems: (text) async {
                                    if (allKabupatenData.isEmpty) {
                                      for (var element in state.listKabupaten) {
                                        allKabupatenData.add(DataListKabupaten(
                                          id: element['id'],
                                          provinsiId: element['provinsi_id'],
                                          value: element['value'],
                                        ));
                                      }
                                    }
                                    return allKabupatenData;
                                  },
                                  itemAsString: (selectedItem) {
                                    selectedItem.value;
                                    return selectedItem.value;
                                  },
                                  // selectedItem: kabupaten,
                                  dropdownDecoratorProps: DropDownDecoratorProps(
                                      dropdownSearchDecoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                      kBorderDisabledFieldColor,
                                                  width: 0.1),
                                              borderRadius:
                                                  BorderRadius.circular(4)))),
                                  onChanged: (value) {
                                    kabupatenId = value!.id;
                                    context
                                        .read<ListKecamatanCubit>()
                                        .getKecamatanData(
                                            idKabupaten: value.id);
                                  },
                                  dropdownBuilder: (context, selectedItem) {
                                    return selectedItem == null
                                        ? Text(kabupaten)
                                        : Text(selectedItem.value);
                                  },
                                );
                              } else if (state is ListKabupatenLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is ListKabupatenFailed) {
                                return Center(
                                  child: Text(state.error),
                                );
                              } else {
                                return const Center(
                                  child: Text("Ada Kesalahan Server !"),
                                );
                              }
                            },
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Text(
                            "Kecamatan",
                            style: blackTextStyle.copyWith(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          BlocBuilder<ListKecamatanCubit, ListKecamatanState>(
                            builder: (context, state) {
                              List<DataListKecamatan> allKecamatanData = [];
                              if (state is ListKecamatanSuccess) {
                                return DropdownSearch<DataListKecamatan>(
                                  asyncItems: (text) async {
                                    if (allKecamatanData.isEmpty) {
                                      for (var element in state.listKecamatan) {
                                        allKecamatanData.add(DataListKecamatan(
                                          id: element['id'],
                                          kabkotId: element['kabkot_id'],
                                          text: element['text'],
                                        ));
                                      }
                                    }
                                    return allKecamatanData;
                                  },
                                  itemAsString: (selectedItem) {
                                    selectedItem.text;
                                    return selectedItem.text;
                                  },
                                  // selectedItem: kecamatan,
                                  dropdownDecoratorProps: DropDownDecoratorProps(
                                      dropdownSearchDecoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                      kBorderDisabledFieldColor,
                                                  width: 0.1),
                                              borderRadius:
                                                  BorderRadius.circular(4)))),
                                  onChanged: (value) {
                                    kecamatanId = value!.id;
                                    context
                                        .read<ListKelurahanProfileCubit>()
                                        .getKelurahanProfileData(
                                            idKecamatan: value.id);
                                  },
                                  dropdownBuilder: (context, selectedItem) {
                                    return selectedItem == null
                                        ? Text(kecamatan)
                                        : Text(selectedItem.text);
                                  },
                                );
                              } else if (state is ListKecamatanLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is ListKecamatanFailed) {
                                return Center(
                                  child: Text(state.error),
                                );
                              } else {
                                return Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14, horizontal: 16),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: kBorderDisabledFieldColor),
                                      color: kPureWhiteColor,
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        kecamatan==""?"Pilih Kecamatan":kecamatan,
                                        style: greyTextStyle.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Image.asset(
                                        "assets/ic_arrow_down.png",
                                        height: 20,
                                        width: 20,
                                      )
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Text(
                            "Kelurahan/Desa",
                            style: blackTextStyle.copyWith(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          BlocBuilder<ListKelurahanProfileCubit,
                              ListKelurahanProfileState>(
                            builder: (context, state) {
                              List<DataListKelurahanProfile> allKelurahanData =
                                  [];
                              if (state is ListKelurahanProfileSuccess) {
                                return DropdownSearch<DataListKelurahanProfile>(
                                  asyncItems: (text) async {
                                    if (allKelurahanData.isEmpty) {
                                      for (var element in state.listKelurahan) {
                                        allKelurahanData
                                            .add(DataListKelurahanProfile(
                                          id: element['id'],
                                          text: element['text'],
                                        ));
                                      }
                                    }
                                    return allKelurahanData;
                                  },
                                  itemAsString: (selectedItem) {
                                    selectedItem.text;
                                    return selectedItem.text;
                                  },
                                  // selectedItem: kelurahan,
                                  dropdownDecoratorProps: DropDownDecoratorProps(
                                      dropdownSearchDecoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color:
                                                      kBorderDisabledFieldColor,
                                                  width: 0.1),
                                              borderRadius:
                                                  BorderRadius.circular(4)))),
                                  onChanged: (value) {
                                    kelurahanId = value!.id;
                                  },
                                  dropdownBuilder: (context, selectedItem) {
                                    return selectedItem == null
                                        ? Text(kelurahan)
                                        : Text(selectedItem.text);
                                  },
                                );
                              } else if (state is ListKelurahanProfileLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is ListKelurahanProfileFailed) {
                                return Center(
                                  child: Text(state.error),
                                );
                              } else {
                                return Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14, horizontal: 16),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: kBorderDisabledFieldColor),
                                      color: kPureWhiteColor,
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        kelurahan==""?"Pilih Kelurahan":kelurahan,
                                        style: greyTextStyle.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Image.asset(
                                        "assets/ic_arrow_down.png",
                                        height: 20,
                                        width: 20,
                                      )
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          CustomPrimaryButton(
                              title: "Simpan",
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  if (!validateData()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            backgroundColor: Colors.red,
                                            content: Text(
                                                "Lengkapi form terlebih dahulu !")));
                                  } else {
                                    context
                                        .read<ChangeProfileCubit>()
                                        .changeProfile(
                                            foto: pathPhotoProfile,
                                            nik: nik,
                                            nama: nameController.text,
                                            jenisKelamin: jenisKelamin,
                                            alamat: addressController.text,
                                            idDesa: kelurahanId);
                                    showDialog(
                                        barrierDismissible: true,
                                        context: context,
                                        builder: (context) => BlocBuilder<
                                                ChangeProfileCubit,
                                                ChangeProfileState>(
                                              builder: (context, state) {
                                                if (state
                                                    is ChangeProfileLoading) {
                                                  return const DialogLoading();
                                                } else if (state
                                                    is ChangeProfileFailed) {
                                                      debugPrint("error edit profile : ${state.error}");
                                                  return DialogFailed(
                                                      desc: state.error);
                                                } else if (state
                                                    is ChangeProfileSuccess) {
                                                  return DialogSuccess(
                                                    desc:
                                                        "Data Profil Berhasil Diperbarui",
                                                    onTap: () {
                                                      context
                                                          .read<UserCubit>()
                                                          .getDataUser(
                                                              uuid: uuid);
                                                      Navigator.popAndPushNamed(
                                                          context, "main");
                                                    },
                                                  );
                                                } else {
                                                  return const DialogOther();
                                                }
                                              },
                                            ));
                                  }
                                }
                              })
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        )),
      ),
    );
  }
}
