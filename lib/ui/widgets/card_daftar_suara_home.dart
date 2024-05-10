import 'package:flutter/material.dart';
import 'package:simpel/cubit/detail_suara_cubit.dart';
import 'package:simpel/shared/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../../services/base_url.dart' as base_url;

class CardDaftarSuaraHome extends StatelessWidget {
  final String name;
  final String nik;
  final String kecamatan;
  final String kelurahan;
  final String tps;
  final String uuid;
  final String img;

  const CardDaftarSuaraHome(
      {super.key,
      required this.name,
      required this.kecamatan,
      required this.kelurahan,
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
        width: 312,
        height: 156,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            border: Border.all(color: kBorderColor),
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: FadeInImage.memoryNetwork(
                height: 50,
                width: 50,
                fit: BoxFit.cover,
                image: "${base_url.urlPhoto}$img",
                placeholder: kTransparentImage,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/ic_error_img.png',
                    width: 50,
                    height: 50,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: blackTextStyle.copyWith(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  nik,
                  style: blackTextStyle.copyWith(
                      fontSize: 12, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  "$kelurahan\n$kecamatan",
                  style: greyTextStyle.copyWith(
                      fontSize: 12, fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  width: 103,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: kPrimaryColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/ic_tps.png",
                        width: 16,
                        height: 16,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "TPS $tps",
                        style: whiteTextStyle.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
