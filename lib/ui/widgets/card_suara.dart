import 'package:flutter/material.dart';
import 'package:simpel/cubit/detail_suara_cubit.dart';
import 'package:simpel/shared/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../../services/base_url.dart' as base_url;

class CardSuara extends StatelessWidget {
  final String name;
  final String tps;
  final String nik;
  final String uuid;
  final String img;

  const CardSuara(
      {super.key,
      required this.name,
      required this.nik,
      required this.tps,
      required this.img,
      required this.uuid});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "detail-suara");
        context.read<DetailSuaraCubit>().getDataDetailSuara(id: uuid);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10),
        color: kPureWhiteColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: FadeInImage.memoryNetwork(
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                image: "${base_url.urlPhoto}$img",
                placeholder: kTransparentImage,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/ic_error_img.png',
                    width: 40,
                    height: 40,
                    fit: BoxFit.contain,
                  );
                },
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
                child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: primaryTextStyle.copyWith(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "TPS",
                      style: blackTextStyle.copyWith(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      nik,
                      style: greyTextStyle.copyWith(
                          fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      tps,
                      style: blackTextStyle.copyWith(
                          fontSize: 12, fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ],
            )),
            const SizedBox(
              width: 16,
            ),
            Image.asset(
              "assets/ic_arrow_right.png",
              height: 24,
              width: 24,
              color: kBlackColor,
            )
          ],
        ),
      ),
    );
  }
}
