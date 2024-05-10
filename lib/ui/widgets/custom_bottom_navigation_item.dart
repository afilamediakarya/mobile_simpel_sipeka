import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simpel/cubit/navbar_cubit.dart';
import 'package:simpel/shared/theme.dart';

class CustomBottomNavigationItem extends StatelessWidget {
  final String imageNavbar0;
  final String titleNavbar;
  final int index;
  final String imageNavbar1;

  const CustomBottomNavigationItem(
      {Key? key,
      required this.imageNavbar0,
      required this.titleNavbar,
      required this.index,
      required this.imageNavbar1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (index == 0) {
        } else if (index == 1) {
        } else if (index == 3) {
        } else if (index == 4) {}
        context.read<NavbarCubit>().setPage(index);
      },
      child: Container(
        color: kPureWhiteColor,
        width: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 6),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: context.read<NavbarCubit>().state == index
                          ? AssetImage(imageNavbar1)
                          : AssetImage(imageNavbar0))),
            ),
            Text(
              titleNavbar,
              style: context.read<NavbarCubit>().state == index
                  ? primaryTextStyle.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5)
                  : greyTextStyle.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.5),
            )
          ],
        ),
      ),
    );
  }
}
