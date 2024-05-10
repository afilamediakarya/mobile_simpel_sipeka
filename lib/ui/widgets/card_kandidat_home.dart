import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simpel/cubit/navbar_cubit.dart';
import 'package:transparent_image/transparent_image.dart';

class CardKandidatHome extends StatelessWidget {
  final String img;

  const CardKandidatHome({required this.img, super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("img kandidat = $img");
    return InkWell(
      onTap: () {
        context.read<NavbarCubit>().setPage(1);
      },
      child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage, 
            image: img,
            width: double.infinity,
            fit: BoxFit.fill,
            imageErrorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'assets/ic_error_img.png',
                width: double.infinity,
                height: 160,
                fit: BoxFit.contain,
              );
            },
          )

          ),
    );
  }
}
