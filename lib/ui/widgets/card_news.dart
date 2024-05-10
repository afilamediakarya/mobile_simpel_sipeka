import 'package:flutter/material.dart';
import 'package:simpel/shared/theme.dart';
import 'package:simpel/ui/pages/home/detail_news_page.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../services/base_url.dart' as base_url;

class CardNews extends StatelessWidget {
  final String title;
  final String image;
  final String link;

  const CardNews(
      {super.key,
      required this.image,
      required this.title,
      required this.link});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (link.contains("https://www.")) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailNewsPage(link: link),
              ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.red,
              content: Text("Link berita tidak valid")));
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: kBorderColor)),
        child: Row(
          children: [
            Expanded(
                child: Text(
              title,
              style: blackTextStyle.copyWith(
                  fontSize: 15, fontWeight: FontWeight.w500),
            )),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: FadeInImage.memoryNetwork(
                height: 50,
                width: 50,
                fit: BoxFit.fill,
                image: "${base_url.urlPhoto}$image",
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
            )
          ],
        ),
      ),
    );
  }
}
