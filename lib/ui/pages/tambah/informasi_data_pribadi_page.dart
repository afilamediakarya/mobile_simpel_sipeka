// ignore_for_file: unused_local_variable, prefer_const_literals_to_create_immutables, avoid_function_literals_in_foreach_calls

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:simpel/cubit/confirm_photo_rumah_cubit.dart';
import 'package:simpel/cubit/confirm_photo_swafoto_cubit.dart';
import 'package:simpel/cubit/date_birth_cubit.dart';
import 'package:simpel/cubit/jenis_kelamin_cubit.dart';
import 'package:simpel/cubit/list_kelurahan_cubit.dart';
import 'package:simpel/cubit/list_tps_cubit.dart';
import 'package:simpel/cubit/pencarian_nik_cubit.dart';
import 'package:simpel/cubit/tambah_data_suara_sementara_cubit.dart';
import 'package:simpel/cubit/type_user_cubit.dart';
import 'package:simpel/cubit/update_data_dpt_cubit.dart';
import 'package:simpel/models/list_kelurahan_model.dart';
import 'package:simpel/models/update_dpt_model.dart';
import 'package:simpel/shared/shared_prefrences.dart';
import 'package:simpel/shared/theme.dart';
import 'package:simpel/ui/widgets/custom_primary_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class InformasiDataPribadiPage extends StatelessWidget {
  const InformasiDataPribadiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        shadowColor: kGreyColor,
        title: Text(
          "Informasi Data Pribadi",
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
                //type="dpt"
                if (state == "dpt") {
                  TextEditingController nikController =
                      TextEditingController(text: '');
                  TextEditingController noKkController =
                      TextEditingController(text: '');
                  TextEditingController namaController =
                      TextEditingController(text: '');
                  TextEditingController tempatLahirController =
                      TextEditingController(text: '');
                  TextEditingController alamatController =
                      TextEditingController(text: '');
                  TextEditingController tpsController =
                      TextEditingController(text: '');
                  TextEditingController rtController =
                      TextEditingController(text: '');
                  TextEditingController rwController =
                      TextEditingController(text: '');

                  String jenisKelamin = "init";
                  String statusKawin = "init";
                  String tanggalLahir = "init";
                  int idKelurahan = 0;
                  int idKecamatan = 0;
                  int idKabupaten = 0;
                  String kelurahan = "init";
                  String kecamatan = "init";
                  String kabupaten = "init";
                  String provinsi = "init";
                  String uuid = "init";

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

                  void onSelectionDateBirthChange(
                      DateRangePickerSelectionChangedArgs args) {
                    tanggalLahir = DateFormat('yyyy-MM-dd').format(args.value);
                    context.read<DateBirthCubit>().setDate(tanggalLahir);
                    Navigator.pop(context);
                  }

                  return Form(
                    key: formKey,
                    child: BlocBuilder<PencarianNikCubit, PencarianNikState>(
                      builder: (context, state) {
                        if (state is PencarianNikLoading) {
                          return Expanded(
                            child: Center(
                              child: CircularProgressIndicator(
                                backgroundColor: kPrimaryColor,
                                color: kSecondaryColor,
                              ),
                            ),
                          );
                        } else if (state is PencarianNikFailed) {
                          return Center(
                            child: Text(state.error),
                          );
                        } else if (state is PencarianNikSuccess) {
                          nikController.text = state.pencarianNikModel.data.nik;
                          noKkController.text =
                              state.pencarianNikModel.data.noKk;
                          namaController.text =
                              state.pencarianNikModel.data.nama;
                          tempatLahirController.text =
                              state.pencarianNikModel.data.tempatLahir;
                          alamatController.text =
                              state.pencarianNikModel.data.alamat;
                          rtController.text = state.pencarianNikModel.data.rt;
                          rwController.text = state.pencarianNikModel.data.rw;
                          uuid = state.pencarianNikModel.data.uuid;
                          tpsController.text = state.pencarianNikModel.data.tps;
                          kelurahan =
                              state.pencarianNikModel.data.kelurahan.kelurahan;
                          kecamatan = state.pencarianNikModel.data.kelurahan
                              .kecamatan.kecamatan;
                          idKelurahan =
                              state.pencarianNikModel.data.kelurahan.id;

                          tanggalLahir =
                              state.pencarianNikModel.data.tanggalLahir;

                          context.read<JenisKelaminCubit>().setGender(
                              state.pencarianNikModel.data.jenisKelamin == "L"
                                  ? 0
                                  : 1);

                          statusKawin =
                              state.pencarianNikModel.data.statusKawin ==
                                      "Kawin"
                                  ? "Kawin"
                                  : "Belum Kawin";

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Image.asset(
                                    "assets/ic_nik.png",
                                    height: 46,
                                    width: 46,
                                  ),
                                  const SizedBox(
                                    width: 24,
                                  ),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "NIK",
                                        style: blackTextStyle.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      TextFormField(
                                        inputFormatters: [],
                                        enabled: true,
                                        scrollPadding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom),
                                        maxLines: 1,
                                        style: blackTextStyle.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                        cursorColor: kBlackColor,
                                        controller: nikController,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor: kPureWhiteColor,
                                            isDense: true,
                                            hintText: "",
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
                                  ))
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Image.asset(
                                    "assets/ic_nik.png",
                                    height: 46,
                                    width: 46,
                                  ),
                                  const SizedBox(
                                    width: 24,
                                  ),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "No kartu Keluarga",
                                        style: blackTextStyle.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      TextFormField(
                                        inputFormatters: [],
                                        enabled: true,
                                        scrollPadding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom),
                                        maxLines: 1,
                                        style: blackTextStyle.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                        cursorColor: kBlackColor,
                                        controller: noKkController,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor: kPureWhiteColor,
                                            isDense: true,
                                            hintText: "",
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
                                  ))
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Image.asset(
                                    "assets/ic_name.png",
                                    height: 46,
                                    width: 46,
                                  ),
                                  const SizedBox(
                                    width: 24,
                                  ),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Nama Lengkap",
                                        style: blackTextStyle.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      TextFormField(
                                        inputFormatters: [],
                                        enabled: true,
                                        scrollPadding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom),
                                        maxLines: 1,
                                        style: blackTextStyle.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                        cursorColor: kBlackColor,
                                        controller: namaController,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor: kPureWhiteColor,
                                            isDense: true,
                                            hintText: "",
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
                                  ))
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/ic_jk.png",
                                    height: 46,
                                    width: 46,
                                  ),
                                  const SizedBox(
                                    width: 24,
                                  ),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Jenis Kelamin",
                                        style: blackTextStyle.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
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
                                                      activeColor:
                                                          kPrimaryColor,
                                                      groupValue: state,
                                                      onChanged: (dynamic val) {
                                                        context
                                                            .read<
                                                                JenisKelaminCubit>()
                                                            .setGender(val);
                                                      }),
                                                  Text(
                                                    "Laki-Laki",
                                                    style:
                                                        blackTextStyle.copyWith(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Radio(
                                                      value: 1,
                                                      activeColor:
                                                          kPrimaryColor,
                                                      groupValue: state,
                                                      onChanged: (dynamic val) {
                                                        context
                                                            .read<
                                                                JenisKelaminCubit>()
                                                            .setGender(val);
                                                      }),
                                                  Text(
                                                    "Perempuan",
                                                    style:
                                                        blackTextStyle.copyWith(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                  )
                                                ],
                                              )
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  ))
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Image.asset(
                                    "assets/ic_name.png",
                                    height: 46,
                                    width: 46,
                                  ),
                                  const SizedBox(
                                    width: 24,
                                  ),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Status Pernikahan",
                                        style: blackTextStyle.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      DropdownSearch<String>(
                                        selectedItem: statusKawin,
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
                                                        vertical: 14,
                                                        horizontal: 16),
                                                filled: true,
                                                fillColor: kPureWhiteColor,
                                                enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            kBorderDisabledFieldColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)))),
                                        dropdownBuilder:
                                            (context, selectedItem) {
                                          return selectedItem == null
                                              ? Text(
                                                  "Pilih Status Pernikahan",
                                                  style: greyTextStyle.copyWith(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                )
                                              : Text(selectedItem);
                                        },
                                      ),
                                    ],
                                  ))
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Image.asset(
                                    "assets/ic_date_blue.png",
                                    height: 46,
                                    width: 46,
                                  ),
                                  const SizedBox(
                                    width: 24,
                                  ),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Tempat Lahir",
                                        style: blackTextStyle.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      TextFormField(
                                        inputFormatters: [],
                                        enabled: true,
                                        scrollPadding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom),
                                        maxLines: 1,
                                        style: blackTextStyle.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                        cursorColor: kBlackColor,
                                        controller: tempatLahirController,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor: kPureWhiteColor,
                                            isDense: true,
                                            hintText: "",
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
                                  ))
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Image.asset(
                                    "assets/ic_date_blue.png",
                                    height: 46,
                                    width: 46,
                                  ),
                                  const SizedBox(
                                    width: 24,
                                  ),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Tanggal Lahir",
                                        style: blackTextStyle.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Container(
                                                  height: 100,
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 64,
                                                      horizontal: 16),
                                                  decoration: BoxDecoration(
                                                      color: kWhiteColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
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
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              border: Border.all(
                                                  color: kBorderColor)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              BlocBuilder<DateBirthCubit,
                                                  String>(
                                                builder: (context, state) {
                                                  return Text(
                                                    tanggalLahir,
                                                    style: tanggalLahir ==
                                                            "init"
                                                        ? greyTextStyle
                                                            .copyWith(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400)
                                                        : blackTextStyle
                                                            .copyWith(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
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
                                    ],
                                  ))
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Image.asset(
                                    "assets/ic_forward.png",
                                    height: 46,
                                    width: 46,
                                  ),
                                  const SizedBox(
                                    width: 24,
                                  ),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Alamat",
                                        style: blackTextStyle.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      TextFormField(
                                        inputFormatters: [],
                                        enabled: true,
                                        scrollPadding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom),
                                        maxLines: 1,
                                        style: blackTextStyle.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                        cursorColor: kBlackColor,
                                        controller: alamatController,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor: kPureWhiteColor,
                                            isDense: true,
                                            hintText: "",
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
                                  ))
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Image.asset(
                                    "assets/ic_gps.png",
                                    height: 46,
                                    width: 46,
                                  ),
                                  const SizedBox(
                                    width: 24,
                                  ),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Kelurahan/Desa",
                                        style: blackTextStyle.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      BlocBuilder<ListKelurahanCubit,
                                          ListKelurahanState>(
                                        builder: (context, state) {
                                          List<DataListKelurahan>
                                              allKelurahanData = [];
                                          if (state is ListKelurahanSuccess) {
                                            state.listKelurahan
                                                .forEach((element) {
                                              allKelurahanData
                                                  .add(DataListKelurahan(
                                                id: element['id'],
                                                text: element['text'],
                                              ));
                                            });

                                            int indexSelectedFirst =
                                                allKelurahanData.indexWhere(
                                                    (element) =>
                                                        element.text ==
                                                        "$kelurahan - $kecamatan");
                                            return DropdownSearch<
                                                DataListKelurahan>(
                                              asyncItems: (text) async {
                                                if (allKelurahanData.isEmpty) {
                                                  state.listKelurahan
                                                      .forEach((element) {
                                                    allKelurahanData
                                                        .add(DataListKelurahan(
                                                      id: element['id'],
                                                      text: element['text'],
                                                    ));
                                                  });
                                                }
                                                return allKelurahanData;
                                              },
                                              itemAsString: (selectedItem) {
                                                selectedItem.text;
                                                return selectedItem.text;
                                              },
                                              selectedItem:
                                                  allKelurahanData.elementAt(
                                                      indexSelectedFirst),
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
                                                                      vertical:
                                                                          14,
                                                                      horizontal:
                                                                          16),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color:
                                                                            kBorderDisabledFieldColor,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              4)))),
                                              onChanged: (value) {
                                                idKelurahan = value!.id;
                                                kelurahan = value.text;

                                                context
                                                    .read<ListTpsCubit>()
                                                    .getTpsData(
                                                        idKelurahan: value.id);
                                              },
                                              dropdownBuilder:
                                                  (context, selectedItem) {
                                                return selectedItem == null
                                                    ? const Text(
                                                        "Pilih Kelurahan")
                                                    : Text(selectedItem.text);
                                              },
                                            );
                                          } else if (state
                                              is ListKelurahanLoading) {
                                            return Center(
                                              child: CircularProgressIndicator(
                                                backgroundColor: kPrimaryColor,
                                                color: kSecondaryColor,
                                              ),
                                            );
                                          } else if (state
                                              is ListKelurahanFailed) {
                                            return Center(
                                              child: Text(state.error),
                                            );
                                          } else {
                                            return Container(
                                              width: double.infinity,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 14,
                                                      horizontal: 16),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          kBorderDisabledFieldColor),
                                                  color: kPureWhiteColor,
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Pilih Kelurahan",
                                                    style:
                                                        greyTextStyle.copyWith(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
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
                                    ],
                                  ))
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Image.asset(
                                    "assets/ic_maps.png",
                                    height: 46,
                                    width: 46,
                                  ),
                                  const SizedBox(
                                    width: 24,
                                  ),
                                  Expanded(
                                      child: Row(children: [
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                              return 'Mohon isi form !';
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
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          inputFormatters: [],
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
                                              return 'Mohon isi form !';
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          inputFormatters: [],
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
                                              return 'Mohon isi form !';
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
                                    ))
                                  ]))
                                ],
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              BlocConsumer<UpdateDataDptCubit,
                                  UpdateDataDptState>(
                                listener: (context, state) {
                                  if (state is UpdateDataDptSuccess) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            backgroundColor: Colors.green,
                                            content: Text(
                                                "Data DPT berhasil diupdate")));

                                    SharedPreference.nikDpt?.setString(
                                        "nik_dpt", nikController.text);

                                    context
                                        .read<ConfirmPhotoSwafotoCubit>()
                                        .deletePicture();
                                    context
                                        .read<ConfirmPhotoRumahCubit>()
                                        .deletePicture();
                                    Navigator.pushNamed(
                                        context, "tambah-suara");
                                  } else if (state is UpdateDataDptFailed) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            backgroundColor: Colors.red,
                                            content: Text(state.error)));
                                  }
                                },
                                builder: (context, state) {
                                  if (state is UpdateDataDptLoading) {
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
                                          if (nikController.text == "" ||
                                              noKkController.text == "" ||
                                              namaController.text == "" ||
                                              statusKawin == "init" ||
                                              tempatLahirController.text ==
                                                  "" ||
                                              tanggalLahir == "init" ||
                                              alamatController.text == "" ||
                                              kelurahan == "init" ||
                                              tpsController.text == "" ||
                                              rwController.text == "" ||
                                              rtController.text == "") {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    backgroundColor: Colors.red,
                                                    content: Text(
                                                        "Lengkapi form terlebih dahulu")));
                                          } else {
                                            context
                                                .read<UpdateDataDptCubit>()
                                                .updateDataDpt(
                                                  updateDataDptModel:
                                                      UpdateDataDptModel(
                                                    uuid: uuid,
                                                    tps: tpsController.text,
                                                    nik: nikController.text,
                                                    nama: namaController.text,
                                                    tempatLahir:
                                                        tempatLahirController
                                                            .text,
                                                    tanggalLahir: tanggalLahir,
                                                    jenisKelamin: jenisKelamin,
                                                    noKk: noKkController.text,
                                                    statusKawin: statusKawin,
                                                    alamat:
                                                        alamatController.text,
                                                    kelurahan: kelurahan,
                                                    rt: rtController.text,
                                                    rw: rwController.text,
                                                    idDesa:
                                                        idKelurahan.toString(),
                                                  ),
                                                );
                                          }
                                        }
                                      });
                                },
                              )
                            ],
                          );
                        } else {
                          return const Center(
                            child: Text("Ada Kesalahan !"),
                          );
                        }
                      },
                    ),
                  );
                }
                //type="-" (Bukan DPT)
                else {
                  //dari menu tambah suara
                  return BlocBuilder<TambahDataSuaraSementaraCubit,
                      TambahDataSuaraSementaraState>(
                    builder: (context, state) {
                      if (state is TambahDataSuaraSementaraSuccess) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/ic_nik.png",
                                  height: 46,
                                  width: 46,
                                ),
                                const SizedBox(
                                  width: 24,
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "NIK",
                                      style: blackTextStyle.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      state.tambahDataSuaraSementaraModel.nik,
                                      style: blackTextStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ))
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  "assets/ic_nik.png",
                                  height: 46,
                                  width: 46,
                                ),
                                const SizedBox(
                                  width: 24,
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "No KK",
                                      style: blackTextStyle.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      state.tambahDataSuaraSementaraModel.noKK,
                                      style: blackTextStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ))
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  "assets/ic_name.png",
                                  height: 46,
                                  width: 46,
                                ),
                                const SizedBox(
                                  width: 24,
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Nama Lengkap",
                                      style: blackTextStyle.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      state.tambahDataSuaraSementaraModel.name,
                                      style: blackTextStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ))
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  "assets/ic_jk.png",
                                  height: 46,
                                  width: 46,
                                ),
                                const SizedBox(
                                  width: 24,
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Jenis Kelamin",
                                      style: blackTextStyle.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      state.tambahDataSuaraSementaraModel
                                                  .jenisKelamin ==
                                              "L"
                                          ? "Laki-Laki"
                                          : "Perempuan",
                                      style: blackTextStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ))
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  "assets/ic_name.png",
                                  height: 46,
                                  width: 46,
                                ),
                                const SizedBox(
                                  width: 24,
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Status Pernikahan",
                                      style: blackTextStyle.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      state.tambahDataSuaraSementaraModel
                                          .statusPerkawinan,
                                      style: blackTextStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ))
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  "assets/ic_date_blue.png",
                                  height: 46,
                                  width: 46,
                                ),
                                const SizedBox(
                                  width: 24,
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Tempat Tanggal Lahir",
                                      style: blackTextStyle.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      "${state.tambahDataSuaraSementaraModel.tempatLahir}, ${state.tambahDataSuaraSementaraModel.tanggalLahir}",
                                      style: blackTextStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ))
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  "assets/ic_forward.png",
                                  height: 46,
                                  width: 46,
                                ),
                                const SizedBox(
                                  width: 24,
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Alamat",
                                      style: blackTextStyle.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      state.tambahDataSuaraSementaraModel
                                          .address,
                                      style: blackTextStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ))
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            // Row(
                            //   children: [
                            //     Image.asset(
                            //       "assets/ic_gps.png",
                            //       height: 46,
                            //       width: 46,
                            //     ),
                            //     const SizedBox(
                            //       width: 24,
                            //     ),
                            //     Expanded(
                            //         child: Column(
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //         Text(
                            //           "Provinsi",
                            //           style: blackTextStyle.copyWith(
                            //               fontSize: 12,
                            //               fontWeight: FontWeight.w400),
                            //         ),
                            //         Text(
                            //           state.tambahDataSuaraSementaraModel
                            //               .provinsi,
                            //           style: blackTextStyle.copyWith(
                            //               fontSize: 16,
                            //               fontWeight: FontWeight.w400),
                            //         ),
                            //       ],
                            //     ))
                            //   ],
                            // ),
                            // const SizedBox(
                            //   height: 16,
                            // ),
                            // Row(
                            //   children: [
                            //     Image.asset(
                            //       "assets/ic_gps.png",
                            //       height: 46,
                            //       width: 46,
                            //     ),
                            //     const SizedBox(
                            //       width: 24,
                            //     ),
                            //     Expanded(
                            //         child: Column(
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //         Text(
                            //           "Kabupaten",
                            //           style: blackTextStyle.copyWith(
                            //               fontSize: 12,
                            //               fontWeight: FontWeight.w400),
                            //         ),
                            //         Text(
                            //           state.tambahDataSuaraSementaraModel
                            //               .kabupaten,
                            //           style: blackTextStyle.copyWith(
                            //               fontSize: 16,
                            //               fontWeight: FontWeight.w400),
                            //         ),
                            //       ],
                            //     ))
                            //   ],
                            // ),
                            // const SizedBox(
                            //   height: 16,
                            // ),
                            // Row(
                            //   children: [
                            //     Image.asset(
                            //       "assets/ic_gps.png",
                            //       height: 46,
                            //       width: 46,
                            //     ),
                            //     const SizedBox(
                            //       width: 24,
                            //     ),
                            //     Expanded(
                            //         child: Column(
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //         Text(
                            //           "Kecamatan",
                            //           style: blackTextStyle.copyWith(
                            //               fontSize: 12,
                            //               fontWeight: FontWeight.w400),
                            //         ),
                            //         Text(
                            //           state.tambahDataSuaraSementaraModel
                            //               .kecamatan,
                            //           style: blackTextStyle.copyWith(
                            //               fontSize: 16,
                            //               fontWeight: FontWeight.w400),
                            //         ),
                            //       ],
                            //     ))
                            //   ],
                            // ),
                            // const SizedBox(
                            //   height: 16,
                            // ),
                            Row(
                              children: [
                                Image.asset(
                                  "assets/ic_gps.png",
                                  height: 46,
                                  width: 46,
                                ),
                                const SizedBox(
                                  width: 24,
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Kelurahan/Desa",
                                      style: blackTextStyle.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      state.tambahDataSuaraSementaraModel
                                          .kelurahan,
                                      style: blackTextStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ))
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  "assets/ic_maps.png",
                                  height: 46,
                                  width: 46,
                                ),
                                const SizedBox(
                                  width: 24,
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "TPS/RW/RT",
                                      style: blackTextStyle.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      "${state.tambahDataSuaraSementaraModel.tps} - ${state.tambahDataSuaraSementaraModel.rw} - ${state.tambahDataSuaraSementaraModel.rt}",
                                      style: blackTextStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ))
                              ],
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            CustomPrimaryButton(
                                title: "Selanjutnya",
                                onPressed: () {
                                  context
                                      .read<ConfirmPhotoSwafotoCubit>()
                                      .deletePicture();
                                  context
                                      .read<ConfirmPhotoRumahCubit>()
                                      .deletePicture();
                                  Navigator.pushNamed(context, "tambah-suara");
                                })
                          ],
                        );
                      } else if (state is TambahDataSuaraSementaraFailed) {
                        return const Center(
                          child: Text("Gagal memuat data"),
                        );
                      } else if (state is TambahDataSuaraSementaraLoading) {
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: kPrimaryColor,
                            color: kSecondaryColor,
                          ),
                        );
                      } else {
                        return const Center(
                          child: Text("Ada Kesalahan"),
                        );
                      }
                    },
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
