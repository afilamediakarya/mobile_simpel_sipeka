// ignore_for_file: use_build_context_synchronously, unnecessary_overrides

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:simpel/cubit/list_suara_cubit.dart';
import 'package:simpel/models/list_suara_model.dart';
import 'package:simpel/shared/theme.dart';
import 'package:simpel/ui/widgets/card_suara.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SuaraPage extends StatefulWidget {
  const SuaraPage({super.key});

  @override
  State<SuaraPage> createState() => _SuaraPageState();
}

class _SuaraPageState extends State<SuaraPage>
    with AutomaticKeepAliveClientMixin<SuaraPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    int page = 1;

    List<DataListSuara> listSuara = <DataListSuara>[];

    final RefreshController refreshController =
        RefreshController(initialRefresh: false);

    void onRefresh() async {
      // monitor network fetch
      await Future.delayed(const Duration(milliseconds: 1000));

      // condition if success refresh data
      page = 1;
      listSuara.clear();
      context.read<ListSuaraCubit>().getDataListSuara(page: "1");
      refreshController.refreshCompleted();

      // condition if failed refresh data
      // _refreshController.refreshFailed();

      debugPrint("onRefresh");
    }

    onLoading() async {
      // monitor network fetch
      await Future.delayed(const Duration(milliseconds: 1000));
      // if failed,use loadFailed(),if no data return,use LoadNodata()

      page = page + 1;

      context
          .read<ListSuaraCubit>()
          .getDataListSuaraLoad(page: page.toString());

      refreshController.loadComplete();

      debugPrint("onLoad");
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kPureWhiteColor,
        body: SafeArea(
            child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 24, bottom: 8),
              decoration: BoxDecoration(color: kPureWhiteColor, boxShadow: [
                BoxShadow(
                    color: kGreyColor,
                    blurRadius: 5,
                    spreadRadius: 1,
                    offset: const Offset(3, 0)),
              ]),
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      "Suara",
                      style: blackTextStyle.copyWith(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "search-suara");
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 16, bottom: 8),
                        child: Image.asset(
                          "assets/ic_search.png",
                          height: 24,
                          width: 24,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: BlocBuilder<ListSuaraCubit, ListSuaraState>(
                builder: (context, state) {
                  if (state is ListSuaraSuccess) {
                    listSuara.addAll(state.dataListSuara);
                    if (listSuara.isEmpty) {
                      return SmartRefresher(
                        enablePullDown: true,
                        footer: CustomFooter(
                          builder: (BuildContext context, LoadStatus? mode) {
                            Widget body;
                            if (mode == LoadStatus.idle) {
                              body = const Text("Data kosong");
                            } else if (mode == LoadStatus.loading) {
                              body = CircularProgressIndicator(backgroundColor: kPrimaryColor, color: kSecondaryColor,); //used CircularProgressIndicator(backgroundColor: kPrimaryColor,) for material design (android)
                            } else if (mode == LoadStatus.failed) {
                              body = const Text("Load Failed!Click retry!");
                            } else if (mode == LoadStatus.canLoading) {
                              body = const Text("release to load more");
                            } else {
                              body = const Text("Tidak ada data lagi");
                            }
                            return SizedBox(
                              height: 55.0,
                              child: Center(child: body),
                            );
                          },
                        ),
                        controller: refreshController,
                        onRefresh: onRefresh,
                        child: const Center(
                          child: Text("Data Suara Kosong"),
                        ),
                      );
                    } else {
                      return SmartRefresher(
                        enablePullDown: true,
                        enablePullUp: true,
                        footer: CustomFooter(
                          builder: (BuildContext context, LoadStatus? mode) {
                            Widget body;
                            if (mode == LoadStatus.idle) {
                              body = const Text("Data kosong");
                            } else if (mode == LoadStatus.loading) {
                              body = CircularProgressIndicator(backgroundColor: kPrimaryColor, color: kSecondaryColor,); //used CircularProgressIndicator(backgroundColor: kPrimaryColor,) for material design (android)
                            } else if (mode == LoadStatus.failed) {
                              body = const Text("Load Failed!Click retry!");
                            } else if (mode == LoadStatus.canLoading) {
                              body = const Text("release to load more");
                            } else {
                              body = const Text("Tidak ada data lagi");
                            }
                            return SizedBox(
                              height: 55.0,
                              child: Center(child: body),
                            );
                          },
                        ),
                        controller: refreshController,
                        onRefresh: onRefresh,
                        onLoading: onLoading,
                        child: ListView.separated(
                          itemCount: listSuara.length,
                          itemBuilder: (context, index) {
                            return CardSuara(
                                img: listSuara[index].swafoto,
                                uuid: listSuara[index].uuid,
                                name: listSuara[index].nama,
                                nik: listSuara[index].nik,
                                tps: listSuara[index].tps.toString());
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 16,
                          ),
                        ),
                      );
                    }
                  } else if (state is ListSuaraLoading) {
                    return Center(
                      child: CircularProgressIndicator(backgroundColor: kPrimaryColor, color: kSecondaryColor,),
                    );
                  } else if (state is ListSuaraFailed) {
                    return Center(
                      child: Text(state.error),
                    );
                  } else {
                    return const Center(
                      child: Text("Ada Kesalahan !"),
                    );
                  }
                },
              ),
            ))
          ],
        )));
  }

  @override
  bool get wantKeepAlive => true;
}
