// ignore_for_file: unused_local_variable

import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:simpel/cubit/confirm_photo_rumah_cubit.dart';
import 'package:simpel/cubit/confirm_photo_swafoto_cubit.dart';
import 'package:simpel/cubit/date_birth_cubit.dart';
import 'package:simpel/cubit/jenis_kelamin_cubit.dart';
import 'package:simpel/cubit/list_kelurahan_cubit.dart';
import 'package:simpel/cubit/list_tps_cubit.dart';
import 'package:simpel/cubit/tambah_data_suara_sementara_cubit.dart';
import 'package:simpel/cubit/type_user_cubit.dart';
import 'package:simpel/models/list_kelurahan_model.dart';
import 'package:simpel/models/tambah_data_suara_sementara_model.dart';
import 'package:simpel/shared/screen_tap.dart';
import 'package:simpel/shared/theme.dart';
import 'package:simpel/ui/widgets/custom_primary_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:intl/intl.dart';

class TambahDataPribadiPage extends StatelessWidget {
  const TambahDataPribadiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController nikController = TextEditingController();
    final TextEditingController noKKController = TextEditingController();
    final TextEditingController nameController =
        TextEditingController(text: '');
    final TextEditingController tempatLahirController =
        TextEditingController(text: '');
    final TextEditingController addressController =
        TextEditingController(text: '');
    final TextEditingController rtController = TextEditingController(text: '');
    final TextEditingController rwController = TextEditingController(text: '');
    final TextEditingController tpsController = TextEditingController(text: '');
    String jenisKelamin = "-";

    String statusKawin = "-";

    String selectedDateBirth = 'Masukkan Tanggal Lahir';

    int idKabupaten = 0;
    int idKecamatan = 0;
    int idKelurahan = 0;
    int idTps = 0;

    String provinsi = "-";
    String kabupaten = "-";
    String kecamatan = "-";
    String kelurahan = "-";
    String tps = "-";

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

    void onSelectionDateBirthChange(DateRangePickerSelectionChangedArgs args) {
      selectedDateBirth = DateFormat('yyyy-MM-dd').format(args.value);
      context.read<DateBirthCubit>().setDate(selectedDateBirth);
      Navigator.pop(context);
    }

    return Form(
      key: formKey,
      child: GestureDetector(
        onTap: () {
          screenTap();
        },
        child: Scaffold(
          body: SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        "Tambah Data Pribadi",
                        style: blackTextStyle.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "NIK",
                          style: blackTextStyle.copyWith(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          inputFormatters: const [],
                          enabled: true,
                          maxLines: 1,
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w400),
                          cursorColor: kBlackColor,
                          controller: nikController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty || value == '') {
                              return 'NIK tidak boleh kosong';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: kPureWhiteColor,
                              isDense: true,
                              hintText: "Masukkan NIK",
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
                          "No kartu Keluarga",
                          style: blackTextStyle.copyWith(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          inputFormatters: const [],
                          enabled: true,
                          maxLines: 1,
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w400),
                          cursorColor: kBlackColor,
                          controller: noKKController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty || value == '') {
                              return 'No KK tidak boleh kosong';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: kPureWhiteColor,
                              isDense: true,
                              hintText: "Masukkan No KK",
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
                          maxLines: 1,
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w400),
                          cursorColor: kBlackColor,
                          controller: nameController,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty || value == '') {
                              return 'Nama tidak boleh kosong';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: kPureWhiteColor,
                              isDense: true,
                              hintText: "Masukkan Nama",
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
                        FormField(validator: (value) {
                          if (jenisKelamin == "-") {
                            return "Pilih Jenis Kelamin terlebih dahulu !";
                          }
                          return null;
                        }, builder: (formFieldState) {
                          return Column(
                            children: [
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
                              if (formFieldState.hasError)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, left: 12),
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
                          height: 16,
                        ),
                        Text(
                          "Status Pernikahan",
                          style: blackTextStyle.copyWith(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        FormField<String>(validator: (value) {
                          if (statusKawin == "-") {
                            return "Pilih Status Pernikahan terlebih dahulu !";
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
                                items: const ["Kawin", "Belum Kawin"],
                                onChanged: (value) {
                                  statusKawin = value!;
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
                                          "Pilih Status Pernikahan",
                                          style: greyTextStyle.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        )
                                      : Text(selectedItem);
                                },
                              ),
                              if (formFieldState.hasError)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, left: 12),
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
                          "Tempat Lahir",
                          style: blackTextStyle.copyWith(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          inputFormatters: const [],
                          enabled: true,
                          maxLines: 1,
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w400),
                          cursorColor: kBlackColor,
                          controller: tempatLahirController,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty || value == '') {
                              return 'Tempat Lahir tidak boleh kosong';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: kPureWhiteColor,
                              isDense: true,
                              hintText: "Masukkan Tempat Lahir",
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
                          "Tanggal Lahir",
                          style: blackTextStyle.copyWith(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        FormField<String>(validator: (value) {
                          if (selectedDateBirth == "Masukkan Tanggal Lahir") {
                            return 'Tanggal Lahir tidak boleh kosong';
                          }
                          return null;
                        }, builder: (formFieldState) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          height: 100,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 64, horizontal: 16),
                                          decoration: BoxDecoration(
                                              color: kWhiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: SfDateRangePicker(
                                            maxDate: DateTime.now(),
                                            selectionMode:
                                                DateRangePickerSelectionMode
                                                    .single,
                                            onSelectionChanged:
                                                onSelectionDateBirthChange,
                                          ),
                                        );
                                      });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14, horizontal: 16),
                                  decoration: BoxDecoration(
                                      color: kPureWhiteColor,
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                          color: kBorderDisabledFieldColor)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      BlocBuilder<DateBirthCubit, String>(
                                        builder: (context, state) {
                                          return Text(
                                            selectedDateBirth,
                                            style: selectedDateBirth ==
                                                    "Masukkan Tanggal Lahir"
                                                ? greyTextStyle.copyWith(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400)
                                                : blackTextStyle.copyWith(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400),
                                          );
                                        },
                                      ),
                                      Image.asset(
                                        "assets/ic_date_range.png",
                                        height: 20,
                                        width: 20,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              if (formFieldState.hasError)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, left: 12),
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
                          maxLines: 5,
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w400),
                          cursorColor: kBlackColor,
                          controller: addressController,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty || value == '') {
                              return 'Alamat tidak boleh kosong';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: kPureWhiteColor,
                              isDense: true,
                              hintText: "Masukkan Alamat ...",
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
                          "Kelurahan/Desa",
                          style: blackTextStyle.copyWith(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        FormField<String>(validator: (value) {
                          if (kelurahan == "-") {
                            return "Pilih Jenis Kelurahan/Desa terlebih dahulu !";
                          }
                          return null;
                        }, builder: (formFieldState) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BlocBuilder<ListKelurahanCubit,
                                  ListKelurahanState>(
                                builder: (context, state) {
                                  List<DataListKelurahan> allKelurahanData = [];
                                  if (state is ListKelurahanSuccess) {
                                    return DropdownSearch<DataListKelurahan>(
                                      asyncItems: (text) async {
                                        if (allKelurahanData.isEmpty) {
                                          for (var element
                                              in state.listKelurahan) {
                                            allKelurahanData
                                                .add(DataListKelurahan(
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
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                              dropdownSearchDecoration:
                                                  InputDecoration(
                                                      filled: true,
                                                      fillColor:
                                                          kPureWhiteColor,
                                                      contentPadding:
                                                          const EdgeInsets
                                                                  .symmetric(
                                                              vertical: 14,
                                                              horizontal: 16),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color:
                                                                    kBorderDisabledFieldColor,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4)))),
                                      onChanged: (value) {
                                        idKelurahan = value!.id;
                                        kelurahan = value.text;

                                        context
                                            .read<ListTpsCubit>()
                                            .getTpsData(idKelurahan: value.id);
                                      },
                                      dropdownBuilder: (context, selectedItem) {
                                        return selectedItem == null
                                            ? Text("Pilih Kelurahan",
                                                style: greyTextStyle.copyWith(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400))
                                            : Text(selectedItem.text);
                                      },
                                    );
                                  } else if (state is ListKelurahanLoading) {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        backgroundColor: kPrimaryColor,
                                        color: kSecondaryColor,
                                      ),
                                    );
                                  } else if (state is ListKelurahanFailed) {
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
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Pilih Kelurahan",
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
                              if (formFieldState.hasError)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, left: 12),
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
                        Row(
                          children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "RT",
                                  style: blackTextStyle.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                TextFormField(
                                  inputFormatters: const [],
                                  enabled: true,
                                  maxLines: 1,
                                  style: blackTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                  cursorColor: kBlackColor,
                                  controller: rtController,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value == '') {
                                      return 'RT tidak boleh kosong';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: kPureWhiteColor,
                                      isDense: true,
                                      hintText: "00",
                                      hintStyle: greyTextStyle.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                      enabled: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          borderSide: BorderSide(
                                              color:
                                                  kBorderDisabledFieldColor)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          borderSide: BorderSide(
                                              color: kPrimaryColor))),
                                ),
                              ],
                            )),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "RW",
                                  style: blackTextStyle.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                TextFormField(
                                  inputFormatters: const [],
                                  enabled: true,
                                  maxLines: 1,
                                  style: blackTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                  cursorColor: kBlackColor,
                                  controller: rwController,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value == '') {
                                      return 'RW tidak boleh kosong';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: kPureWhiteColor,
                                      isDense: true,
                                      hintText: "00",
                                      hintStyle: greyTextStyle.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                      enabled: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          borderSide: BorderSide(
                                              color:
                                                  kBorderDisabledFieldColor)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          borderSide: BorderSide(
                                              color: kPrimaryColor))),
                                ),
                              ],
                            )),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "TPS",
                                  style: blackTextStyle.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                TextFormField(
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(3),
                                  ],
                                  enabled: true,
                                  maxLines: 1,
                                  style: blackTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                  cursorColor: kBlackColor,
                                  controller: tpsController,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value == '') {
                                      return 'TPS tidak boleh kosong';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: kPureWhiteColor,
                                      isDense: true,
                                      hintText: "000",
                                      hintStyle: greyTextStyle.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                      enabled: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          borderSide: BorderSide(
                                              color:
                                                  kBorderDisabledFieldColor)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          borderSide: BorderSide(
                                              color: kPrimaryColor))),
                                ),
                              ],
                            )),
                          ],
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        BlocConsumer<TambahDataSuaraSementaraCubit,
                            TambahDataSuaraSementaraState>(
                          listener: (context, state) {
                            if (state is TambahDataSuaraSementaraSuccess) {
                              context
                                  .read<TypeUserCubit>()
                                  .setTypeUser("notyet");
                              Navigator.pushNamed(context, "info-data-pribadi");
                            } else if (state
                                is TambahDataSuaraSementaraFailed) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text("Gagal Input Data")));
                            }
                          },
                          builder: (context, state) {
                            if (state is TambahDataSuaraSementaraLoading) {
                              return Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: kPrimaryColor,
                                  color: kSecondaryColor,
                                ),
                              );
                            }
                            return CustomPrimaryButton(
                                title: "Selanjutnya",
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    if (nikController.text.isEmpty ||
                                        noKKController.text.isEmpty ||
                                        nameController.text.isEmpty ||
                                        jenisKelamin == "-" ||
                                        statusKawin == "-" ||
                                        tempatLahirController.text.isEmpty ||
                                        selectedDateBirth ==
                                            "Masukkan Tanggal Lahir" ||
                                        addressController.text.isEmpty ||
                                        idKelurahan == 0 ||
                                        tpsController.text == "" ||
                                        rtController.text.isEmpty ||
                                        rwController.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              backgroundColor: Colors.red,
                                              content: Text(
                                                  "Lengkapi form terlebih dahulu !")));
                                    } else {
                                      if (((nikController.text.length < 16) ||
                                              (nikController.text.length >
                                                  16)) ||
                                          ((noKKController.text.length < 16) ||
                                              (noKKController.text.length >
                                                  16))) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                backgroundColor: Colors.red,
                                                content: Text(
                                                    "NIK dan KK harus 16 digit !")));
                                      } else {
                                        context
                                            .read<ConfirmPhotoRumahCubit>()
                                            .deletePicture();
                                        context
                                            .read<ConfirmPhotoSwafotoCubit>()
                                            .deletePicture();
                                        context
                                            .read<
                                                TambahDataSuaraSementaraCubit>()
                                            .tambahDataSuaraSementara(
                                              data:
                                                  TambahDataSuaraSementaraModel(
                                                nik: nikController.text,
                                                noKK: noKKController.text,
                                                name: nameController.text,
                                                jenisKelamin: jenisKelamin,
                                                statusPerkawinan: statusKawin,
                                                tempatLahir:
                                                    tempatLahirController.text,
                                                tanggalLahir: selectedDateBirth,
                                                address: addressController.text,
                                                idKelurahan:
                                                    idKelurahan.toString(),
                                                kelurahan: kelurahan,
                                                rt: rtController.text,
                                                rw: rwController.text,
                                                tps: tpsController.text,
                                              ),
                                            );
                                      }
                                    }
                                  }
                                });
                          },
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
