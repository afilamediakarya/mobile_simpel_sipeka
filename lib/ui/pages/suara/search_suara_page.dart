import 'package:flutter/material.dart';
import 'package:simpel/cubit/search_suara_cubit.dart';
import 'package:simpel/shared/screen_tap.dart';
import 'package:simpel/shared/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simpel/ui/widgets/card_suara.dart';

import '../../widgets/custom_text_form_field_icon_left.dart';

class SearchSuaraPage extends StatelessWidget {
  const SearchSuaraPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController searchController =
        TextEditingController(text: '');

    return Form(
      key: formKey,
      child: GestureDetector(
        onTap: screenTap,
        child: Scaffold(
            backgroundColor: kPureWhiteColor,
            body: SafeArea(
                child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 8, right: 16, left: 16),
                  decoration: BoxDecoration(color: kPureWhiteColor, boxShadow: [
                    BoxShadow(
                        color: kGreyColor,
                        blurRadius: 5,
                        spreadRadius: 1,
                        offset: const Offset(3, 0)),
                  ]),
                  child: Row(
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
                      Expanded(
                        child: Container(
                            padding: const EdgeInsets.only(left: 16),
                            width: double.infinity,
                            child: CustomTextFormFieldIconLeft(
                                validator: (value) {
                                  return null;
                                },
                                onFieldSubmitted: (String str) {
                                  if (formKey.currentState!.validate()) {
                                    context
                                        .read<SearchSuaraCubit>()
                                        .getDataSearchSuara(value: str);
                                  }
                                },
                                hintText: "Cari Nama...",
                                image: "assets/ic_search_grey.png",
                                controller: searchController,
                                backgroundColor: kPureWhiteColor,
                                borderColor: kBorderColor,
                                textInputType: TextInputType.text,
                                maxLines: 1,
                                obscureText: false,
                                hintStyle: greyTextStyle.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                                textStyle: blackTextStyle.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                                enabled: true)),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: BlocBuilder<SearchSuaraCubit, SearchSuaraState>(
                    builder: (context, state) {
                      if (state is SearchSuaraSuccess) {
                        if (state.dataSearchSuara.isEmpty) {
                          return const Center(
                            child: Text("Data tidak ditemukan"),
                          );
                        } else {
                          return ListView.separated(
                            itemCount: state.dataSearchSuara.length,
                            itemBuilder: (context, index) {
                              return CardSuara(
                                  img: state.dataSearchSuara[index].swafoto,
                                  uuid: state.dataSearchSuara[index].uuid,
                                  name: state.dataSearchSuara[index].nama,
                                  nik: state.dataSearchSuara[index].nik,
                                  tps: state.dataSearchSuara[index].tps
                                      .toString());
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 16,
                            ),
                          );
                        }
                      } else if (state is SearchSuaraLoading) {
                        return Center(
                          child: CircularProgressIndicator(
                backgroundColor: kPrimaryColor,
                color: kSecondaryColor,
              ),
                        );
                      } else if (state is SearchSuaraFailed) {
                        return Center(
                          child: Text(state.error),
                        );
                      } else {
                        return const Center(
                          child: Text(""),
                        );
                      }
                    },
                  ),
                ))
              ],
            ))),
      ),
    );
  }
}
