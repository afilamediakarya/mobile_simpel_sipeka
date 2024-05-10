import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:simpel/cubit/kandidat_cubit.dart';
import 'package:simpel/shared/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../../services/base_url.dart' as base_url;

class KandidatPage extends StatelessWidget {
  const KandidatPage({super.key});

  @override
  Widget build(BuildContext context) {
    var markdownStyle = MarkdownStyleSheet(
      textAlign: WrapAlignment.spaceAround,
    );

    String dataVisi = """
Terwujudnya Dewan Perwakilan Rakyat Daerah Kota Salatiga yang aspiratif, demokratis, profesional, dan proporsional dalam rangka memperkuat Tata Pemerintahan Daerah Otonomi yang harmonis, dinamis, adil, dan sejahtera
""";

    String dataMisi = """
1. Mewujudkan DPRD Kota Salatiga sebagai soko guru kehidupan demokrasi bagi penyelenggaraan tata pemerintahan daerah yang kokoh.
2. Mewujudkan DPRD Kota Salatiga sebagai lembaga yang profesional, proporsional dan berkualitas.
3. Mewujudkan DPRD Kota Salatiga sebagai lembaga yang aspiratif untuk menunjang tata kehidupan berkeadilan dan sejahtera bag! masyarakat Salatiga.
4. Menjadikan DPRD Kota Salatiga sebagai lembaga perjuangan untuk optimalisasi pelayanan publik.
5. Menjadikan DPRD Kota Salatiga sebagai lembaga pengambil kebijakan publik dan keputusan politik yang berkualitas.
""";

    String dataPendidikan = """
* SD Inpres Mawang (2006 - 2012)
* SMP Negeri 1 Bontomarannu (2012 - 2015)
* SMK Negeri 1 Somba Opu (2015 - 2018)
* S1 Sistem Informasi (2018 - 2023)
""";

    String dataPekerjaan = """
* Afila Media Karya (2023 - Sekarang)
* DPRD Provinsi Sulawesi Selatan, Sebagai Ketua Fraksi PKB (2023 - 2028)
""";

    return Scaffold(
        backgroundColor: kPureWhiteColor,
        body: SafeArea(child: BlocBuilder<KandidatCubit, KandidatState>(
          builder: (context, state) {
            if (state is KandidatLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is KandidatFailed) {
              return Center(
                child: Text(state.error),
              );
            } else if (state is KandidatSuccess) {
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 24, bottom: 8),
                    width: double.infinity,
                    color: kPureWhiteColor,
                    child: Center(
                      child: Text(
                        "Kandidat",
                        style: blackTextStyle.copyWith(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [
                        FadeInImage.memoryNetwork(
                          image:
                              "${base_url.urlPhoto}${state.kandidatModel.data.foto}",
                          placeholder: kTransparentImage,
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/ic_error_img.png',
                              width: double.infinity,
                              height: 180,
                              fit: BoxFit.contain,
                            );
                          },
                          width: double.infinity,
                          height: 180,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                    "assets/ic_name.png",
                                    height: 36,
                                    width: 36,
                                  ),
                                  const SizedBox(
                                    width: 24,
                                  ),
                                  Expanded(
                                      child: SingleChildScrollView(
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
                                        Text(
                                          state.kandidatModel.data.nama,
                                          style: blackTextStyle.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Visibility(
                                visible: false,
                                child: Row(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Tempat Tanggal Lahir",
                                          style: blackTextStyle.copyWith(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        Text(
                                          "Makassar, 09 April 2000",
                                          style: blackTextStyle.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ))
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              HtmlWidget(state.kandidatModel.data.deskripsi),
                              Visibility(
                                visible: false,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Visi",
                                      style: blackTextStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Container(
                                        height: 75,
                                        color: kPureWhiteColor,
                                        child: Markdown(
                                            styleSheet: markdownStyle,
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.zero,
                                            data: dataVisi)),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    Text(
                                      "Misi",
                                      style: blackTextStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Container(
                                        height: 250,
                                        color: kPureWhiteColor,
                                        child: Markdown(
                                            styleSheet: markdownStyle,
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.zero,
                                            data: dataMisi)),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    Text(
                                      "Riwayat Pendidikan",
                                      style: blackTextStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Container(
                                        height: 100,
                                        color: kPureWhiteColor,
                                        child: Markdown(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.zero,
                                            data: dataPendidikan)),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    Text(
                                      "Riwayat Pekerjaan",
                                      style: blackTextStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Container(
                                        height: 75,
                                        color: kPureWhiteColor,
                                        child: Markdown(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.zero,
                                            data: dataPekerjaan)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ))
                ],
              );
            } else {
              return const Center(
                child: Text("Ada kesalahan"),
              );
            }
          },
        )));
  }
}
