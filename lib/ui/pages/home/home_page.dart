// ignore_for_file: unnecessary_overrides, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:simpel/cubit/data_news_cubit.dart';
import 'package:simpel/cubit/data_pengumuman_cubit.dart';
import 'package:simpel/cubit/kandidat_cubit.dart';
import 'package:simpel/cubit/kinerja_percent_cubit.dart';
import 'package:simpel/cubit/list_suara_cubit.dart';
import 'package:simpel/cubit/navbar_cubit.dart';
import 'package:simpel/cubit/total_suara_cubit.dart';
import 'package:simpel/cubit/user_cubit.dart';
import 'package:simpel/models/list_pengumuman_model.dart';
import 'package:simpel/models/list_suara_model.dart';
import 'package:simpel/shared/shared_prefrences.dart';
import 'package:simpel/shared/theme.dart';
import 'package:simpel/ui/widgets/card_daftar_suara_home.dart';
import 'package:simpel/ui/widgets/card_kandidat_home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simpel/ui/widgets/card_news.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../../services/base_url.dart' as base_url;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String uuid = SharedPreference.login.getString("uuid");
    late int targetSuara = 0;
    late String name, foto;
    String role = "init";

    final RefreshController refreshController =
        RefreshController(initialRefresh: false);

    void onRefresh() async {
      // monitor network fetch
      await Future.delayed(const Duration(milliseconds: 1000));
      context.read<UserCubit>().getDataUser(uuid: uuid);
      refreshController.refreshCompleted();
    }

    super.build(context);
    return Scaffold(
        body: SafeArea(
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        footer: const SizedBox(),
        controller: refreshController,
        onRefresh: onRefresh,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //header
              Container(
                decoration: BoxDecoration(color: kPureWhiteColor, boxShadow: [
                  BoxShadow(
                      color: kGreyColor,
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: const Offset(3, 0)),
                ]),
                width: double.infinity,
                padding: const EdgeInsets.only(
                    right: 24, left: 24, bottom: 8, top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<UserCubit, UserState>(
                      builder: (context, state) {
                        if (state is DataUserSuccess) {
                          name = state.dataUserModel.data.nama;
                          role = state.dataUserModel.data.role;
                          foto = state.dataUserModel.data.foto;
                          context.read<KandidatCubit>().getDataKandidat(
                              idCalon:
                                  SharedPreference.login.getString("id_calon"));
                          context.read<DataNewsCubit>().getDataListNews();
                          context
                              .read<DataPengumumanCubit>()
                              .getDataListPengumuman();
                          context.read<TotalSuaraCubit>().getDataTotalSuara();
                          context
                              .read<ListSuaraCubit>()
                              .getDataListSuara(page: "");
                        } else if (state is DataUserFailed) {
                          name = "Gagal";
                          role = "Gagal";
                          foto = "";
                        } else if (state is DataUserLoading) {
                          name = "?";
                          role = "?";
                          foto = "";
                        } else {
                          name = "-";
                          role = "-";
                          foto = "-";
                        }
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            foto == ""
                                ? Image.asset(
                                    "assets/ic_avatar.png",
                                    width: 36,
                                    height: 36,
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: FadeInImage.memoryNetwork(
                                      image: "${base_url.urlPhoto}$foto",
                                      placeholder: kTransparentImage,
                                      height: 36,
                                      width: 36,
                                      imageErrorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          'assets/ic_error_img.png',
                                          width: 36,
                                          height: 36,
                                        );
                                      },
                                    )),
                            const SizedBox(
                              width: 12,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  style: blackTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "Akun $role",
                                  style: greyTextStyle.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            )
                          ],
                        );
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "search-suara");
                      },
                      child: Image.asset(
                        "assets/ic_search.png",
                        height: 24,
                        width: 24,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              BlocBuilder<KandidatCubit, KandidatState>(
                builder: (context, state) {
                  if (state is KandidatFailed) {
                    return Center(
                      child: Text(state.error),
                    );
                  } else if (state is KandidatLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: kPrimaryColor,
                        color: kSecondaryColor,
                      ),
                    );
                  } else if (state is KandidatSuccess) {
                    return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: CardKandidatHome(
                            img:
                                "${base_url.urlPhoto}${state.kandidatModel.data.foto}"));
                  } else {
                    return const Center(
                      child: Text(""),
                    );
                  }
                },
              ),

              // SizedBox(
              //   height: 176,
              //   child: ListView.separated(
              //     shrinkWrap: true,
              //     scrollDirection: Axis.horizontal,
              //     itemCount: 3,
              //     itemBuilder: (context, index) {
              //       return const CardKandidatHome(
              //         img: ,
              //       );
              //     },
              //     separatorBuilder: (context, index) {
              //       return const SizedBox(
              //         width: 8,
              //       );
              //     },
              //   ),
              // ),

              const SizedBox(
                height: 24,
              ),

              ///section marquee text
              BlocBuilder<DataPengumumanCubit, DataPengumumanState>(
                builder: (context, state) {
                  if (state is DataPengumumanSuccess) {
                    if (state.dataPengumuman.isEmpty) {
                      return const Center(
                        child: Text("-"),
                      );
                    } else {
                      List valuePengumuman = [];

                      for (var item in state.dataPengumuman) {
                        valuePengumuman.add('${item.deskripsi} - ');
                      }
                      String pengumumanFormatted = valuePengumuman.join('');
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        height: 24,
                        child: Marquee(
                          text: pengumumanFormatted,
                          style: primaryTextStyle.copyWith(
                              fontWeight: FontWeight.w600),
                        ),
                      );
                    }
                  } else if (state is DataPengumumanFailed) {
                    return Center(
                      child: Text(state.error),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: kPrimaryColor,
                        color: kSecondaryColor,
                      ),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 24,
              ),
              GestureDetector(
                onTap: () {
                  // context.read<NavbarCubit>().setPage(3)
                },
                child: BlocBuilder<UserCubit, UserState>(
                  builder: (context, state) {
                    if (state is DataUserSuccess) {
                      role = state.dataUserModel.data.role;
                      targetSuara = state.dataUserModel.data.targetSuara;
                      context.read<TotalSuaraCubit>().getDataTotalSuara();
                    }
                    if (role == "pin") {
                      return const SizedBox();
                    } else {
                      return BlocBuilder<TotalSuaraCubit, TotalSuaraState>(
                        builder: (context, state) {
                          if (state is TotalSuaraSuccess) {
                            int suara =
                                state.dataTotalSuaraModel.data.jumlahSuara;
                            int suaraKomunitas = state
                                .dataTotalSuaraModel.data.totalSuaraKomunitas;
                            debugPrint(
                                "suara : $suara | target suara : $targetSuara");
                            late int kinerja =
                                ((suara * 100) / targetSuara).round();
                            context
                                .read<KinerjaPercentCubit>()
                                .setKinerjaPercent(kinerja: kinerja);
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: Column(
                                children: [
                                  Container(
                                      padding: const EdgeInsets.all(18),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: kBorderPrimaryColor),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Target TIM",
                                            style: blackTextStyle.copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            height: 22,
                                          ),
                                          SizedBox(
                                            height: 20,
                                            width: double.infinity,
                                            child: Stack(
                                              children: [
                                                BlocBuilder<KinerjaPercentCubit,
                                                    double>(
                                                  builder: (context, state) {
                                                    return LinearPercentIndicator(
                                                      padding: EdgeInsets.zero,
                                                      barRadius:
                                                          const Radius.circular(
                                                              8),
                                                      lineHeight: 20.0,
                                                      percent: state > 1.0
                                                          ? 1.0
                                                          : state,
                                                      progressColor:
                                                          kGreenColor,
                                                      backgroundColor:
                                                          kSecondGreenColor,
                                                    );
                                                  },
                                                ),
                                                Container(
                                                  height: 20,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 16),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "$suara of ${targetSuara.toString()}",
                                                        style: kinerja > 20
                                                            ? whiteTextStyle
                                                                .copyWith(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500)
                                                            : blackTextStyle
                                                                .copyWith(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                      ),
                                                      Text(
                                                        "$kinerja%",
                                                        style: kinerja < 95
                                                            ? blackTextStyle
                                                                .copyWith(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500)
                                                            : whiteTextStyle
                                                                .copyWith(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 22,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    suara.toString(),
                                                    style:
                                                        blackTextStyle.copyWith(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    "Suara",
                                                    style:
                                                        blackTextStyle.copyWith(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    targetSuara.toString(),
                                                    style:
                                                        blackTextStyle.copyWith(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    "Target",
                                                    style:
                                                        blackTextStyle.copyWith(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    "$kinerja%",
                                                    style:
                                                        blackTextStyle.copyWith(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    "Kinerja",
                                                    style:
                                                        blackTextStyle.copyWith(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      )),
                                  const SizedBox(
                                    height: 18,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                            padding: const EdgeInsets.all(12),
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: kBorderPrimaryColor),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  "assets/ic_jumlah_suara.png",
                                                  height: 50,
                                                  width: 50,
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      suara.toString(),
                                                      style: blackTextStyle
                                                          .copyWith(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                    ),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    Text(
                                                      "Jumlah Suara",
                                                      style: blackTextStyle
                                                          .copyWith(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            )),
                                      ),
                                      const SizedBox(
                                        width: 18,
                                      ),
                                      Expanded(
                                        child: Container(
                                            padding: const EdgeInsets.all(12),
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: kBorderPrimaryColor),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  "assets/ic_total_suara.png",
                                                  height: 50,
                                                  width: 50,
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      suaraKomunitas.toString(),
                                                      style: blackTextStyle
                                                          .copyWith(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                    ),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    Text(
                                                      "Total Suara Komunitas",
                                                      style: blackTextStyle
                                                          .copyWith(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            )),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          } else if (state is TotalSuaraLoading) {
                            return Center(
                              child: CircularProgressIndicator(
                                backgroundColor: kPrimaryColor,
                                color: kSecondaryColor,
                              ),
                            );
                          } else if (state is TotalSuaraFailed) {
                            return Center(
                              child: Text(state.error),
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                backgroundColor: kPrimaryColor,
                                color: kSecondaryColor,
                              ),
                            );
                          }
                        },
                      );
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Daftar Suaraku",
                      style: deepBlackTextStyle.copyWith(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<NavbarCubit>().setPage(3);
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Lihat Semua",
                            style: primaryTextStyle.copyWith(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: kPrimaryColor,
                            size: 18,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                height: 156,
                child: BlocBuilder<ListSuaraCubit, ListSuaraState>(
                  builder: (context, state) {
                    if (state is ListSuaraLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: kPrimaryColor,
                          color: kSecondaryColor,
                        ),
                      );
                    } else if (state is ListSuaraFailed) {
                      return Center(
                        child: Text(state.error),
                      );
                    } else if (state is ListSuaraSuccess) {
                      if (state.dataListSuara.isEmpty) {
                        return const Center(
                          child: Text("Data Suara Kosong"),
                        );
                      } else {
                        List<DataListSuara> listSuara = [];

                        listSuara.addAll(state.dataListSuara);

                        return ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: state.dataListSuara.length > 3
                              ? 3
                              : state.dataListSuara.length,
                          itemBuilder: (context, index) {
                            return CardDaftarSuaraHome(
                                img: listSuara[index].swafoto,
                                uuid: listSuara[index].uuid,
                                name: listSuara[index].nama,
                                kecamatan: listSuara[index]
                                    .kelurahan
                                    .kecamatan
                                    .kecamatan,
                                kelurahan: listSuara[index].kelurahan.kelurahan,
                                nik: listSuara[index].nik,
                                tps: listSuara[index].tps.toString());
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 8,
                          ),
                        );
                      }
                    } else {
                      return const Center(
                        child: Text("API List Suara tidak terhit !"),
                      );
                    }
                  },
                ),
              ),
              Visibility(
                visible: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Berita",
                            style: deepBlackTextStyle.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          BlocBuilder<DataNewsCubit, DataNewsState>(
                            builder: (context, state) {
                              if (state is DataNewsSuccess) {
                                return ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) => CardNews(
                                          image: state.dataNews[index].gambar,
                                          title: state.dataNews[index].judul,
                                          link: state.dataNews[index].link,
                                        ),
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(height: 12),
                                    itemCount: state.dataNews.length < 3
                                        ? state.dataNews.length
                                        : 3);
                              } else if (state is DataNewsLoading) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: kPrimaryColor,
                                    color: kSecondaryColor,
                                  ),
                                );
                              } else if (state is DataNewsFailed) {
                                return Center(
                                  child: Text(state.error),
                                );
                              } else if (state is DataNewsInitial) {
                                return const Center(
                                  child: Text("Memuat berita ..."),
                                );
                              } else {
                                return const Center(
                                  child: Text("API Berita tidak terhit !"),
                                );
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              )
            ],
          ),
        ),
      ),
    ));
  }

  @override
  bool get wantKeepAlive => true;
}
