import 'package:flutter/material.dart';
import 'package:simpel/cubit/detail_suara_cubit.dart';
import 'package:simpel/shared/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../../services/base_url.dart' as base_url;

class DetailSuaraPage extends StatelessWidget {
  const DetailSuaraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<DetailSuaraCubit, DetailSuaraState>(
          builder: (context, state) {
            if (state is DetailSuaraSuccess) {
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                        left: 16, top: 16, bottom: 8, right: 24),
                    decoration:
                        BoxDecoration(color: kPureWhiteColor, boxShadow: [
                      BoxShadow(
                          color: kGreyColor,
                          blurRadius: 5,
                          spreadRadius: 1,
                          offset: const Offset(3, 0)),
                    ]),
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
                            "Detail Suara",
                            style: blackTextStyle.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                          child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: FadeInImage.memoryNetwork(
                                height: 150,
                                width: 150,
                                fit: BoxFit.cover,
                                image:
                                    "${base_url.urlPhoto}${state.dataDetailSuara.data.swafoto}",
                                placeholder: kTransparentImage,
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/ic_error_img.png',
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.contain,
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Text(
                          "Profile",
                          style: blackTextStyle.copyWith(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/ic_nik.png",
                              height: 36,
                              width: 36,
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
                                  state.dataDetailSuara.data.nik,
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
                              height: 36,
                              width: 36,
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
                                  state.dataDetailSuara.data.noKk,
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
                              height: 36,
                              width: 36,
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
                                  state.dataDetailSuara.data.nama,
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
                              height: 36,
                              width: 36,
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
                                  state.dataDetailSuara.data.jenisKelamin == "L"
                                      ? "Laki-laki"
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
                              height: 36,
                              width: 36,
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
                                  state.dataDetailSuara.data.statusKawin,
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
                              height: 36,
                              width: 36,
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
                                  "${state.dataDetailSuara.data.tempatLahir}, ${state.dataDetailSuara.data.tanggalLahir}",
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
                              height: 36,
                              width: 36,
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
                                  state.dataDetailSuara.data.alamat,
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
                              "assets/ic_gps.png",
                              height: 36,
                              width: 36,
                            ),
                            const SizedBox(
                              width: 24,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Provinsi",
                                  style: blackTextStyle.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  state.dataDetailSuara.data.kelurahan.kecamatan
                                      .kabupaten.provinsi.provinsi,
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
                              "assets/ic_gps.png",
                              height: 36,
                              width: 36,
                            ),
                            const SizedBox(
                              width: 24,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Kabupaten",
                                  style: blackTextStyle.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  state.dataDetailSuara.data.kelurahan.kecamatan
                                      .kabupaten.kabupatenKota,
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
                              "assets/ic_gps.png",
                              height: 36,
                              width: 36,
                            ),
                            const SizedBox(
                              width: 24,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Kecamatan",
                                  style: blackTextStyle.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  state.dataDetailSuara.data.kelurahan.kecamatan
                                      .kecamatan,
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
                              "assets/ic_gps.png",
                              height: 36,
                              width: 36,
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
                                  state
                                      .dataDetailSuara.data.kelurahan.kelurahan,
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
                              height: 36,
                              width: 36,
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
                                  "${state.dataDetailSuara.data.tps} - ${state.dataDetailSuara.data.rw} - ${state.dataDetailSuara.data.rt}",
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
                              "assets/ic_phone.png",
                              height: 36,
                              width: 36,
                            ),
                            const SizedBox(
                              width: 24,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Nomor Telepon",
                                  style: blackTextStyle.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  state.dataDetailSuara.data.noTelp,
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
                              height: 36,
                              width: 36,
                            ),
                            const SizedBox(
                              width: 24,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hubungan dengan Tim",
                                  style: blackTextStyle.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  state.dataDetailSuara.data.hdt!,
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
                              height: 36,
                              width: 36,
                            ),
                            const SizedBox(
                              width: 24,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Status Pemilih",
                                  style: blackTextStyle.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  state.dataDetailSuara.data.statusPemilih=="aktif"?"Pemilih Aktif":(state.dataDetailSuara.data.statusPemilih=="pasif"?"Pemilih Pasif":"-") ,
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
                        Text(
                          "Alasan Memilih",
                          style: blackTextStyle.copyWith(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          state.dataDetailSuara.data.alasan,
                          style: blackTextStyle.copyWith(
                              fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 40,
                        )
                      ],
                    ),
                  )))
                ],
              );
            } else if (state is DetailSuaraLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is DetailSuaraFailed) {
              return Center(
                child: Text(state.error, textAlign: TextAlign.center),
              );
            } else {
              return const Center(
                child: Text("Ada Kesalahan !"),
              );
            }
          },
        ),
      ),
    );
  }
}
