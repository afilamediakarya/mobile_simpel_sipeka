// ignore_for_file: use_build_context_synchronously

import "package:flutter/material.dart";
import 'package:simpel/shared/theme.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:url_launcher/url_launcher.dart';

class BantuanPage extends StatelessWidget {
  const BantuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    launchWhatsAppUri({required noHp}) async {
      final link = WhatsAppUnilink(
        phoneNumber: noHp,
        text: "Hai, mau tanya-tanya soal SIPEKA dong?",
      );
      await launchUrl(Uri.parse(link.asUri().toString()));
    }

    Future<void> openMap(double latitude, double longitude) async {
      String googleUrl =
          'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
      if (await canLaunchUrl(Uri.parse(googleUrl))) {
        await launchUrl(Uri.parse(googleUrl));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.red,
            content: Text("Mohon install aplikasi maps")));
      }
    }

    Future<void> openPhone({required String no}) async {
      await launchUrl(Uri.parse("tel://$no"));
    }

    return Scaffold(
      backgroundColor: kPureWhiteColor,
      body: SafeArea(
        child: Column(
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
                  InkWell(
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
                      "Bantuan",
                      style: blackTextStyle.copyWith(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),
            Image.asset(
              "assets/ic_bantuan_banner_fix.png",
              width: double.infinity,
              height: 185,
              fit: BoxFit.fitWidth,
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Kontak Kami",
                    style: blackTextStyle.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  InkWell(
                    onTap: () {
                      openMap(-5.1778886040512795, 119.4794741116326);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/ic_location.png",
                          height: 40,
                          width: 40,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Alamat",
                              style: blackTextStyle.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "Jl. Pesona Prima Griya No.25, Bangkala, Kec. Manggala, Kota Makassar, Sulawesi Selatan 90235",
                              style: greyTextStyle.copyWith(
                                  fontSize: 12, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  InkWell(
                    onTap: () {
                      openPhone(no: "081144411201");
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/ic_phone_call.png",
                          height: 40,
                          width: 40,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "No Telepon",
                              style: blackTextStyle.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "CS SIPEKA (0811 444 11201)",
                              style: greyTextStyle.copyWith(
                                  fontSize: 12, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  InkWell(
                    onTap: () {
                      launchWhatsAppUri(noHp: "6281144411201");
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/ic_wa.png",
                          height: 40,
                          width: 40,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "WhatsApp",
                              style: blackTextStyle.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "CS SIPEKA (0811 444 11201)",
                              style: greyTextStyle.copyWith(
                                  fontSize: 12, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
