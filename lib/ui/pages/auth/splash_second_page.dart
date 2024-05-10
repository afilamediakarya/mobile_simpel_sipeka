import 'package:flutter/material.dart';
import 'package:simpel/cubit/komunitas_cubit.dart';
import 'package:simpel/cubit/list_kabupaten_cubit.dart';
import 'package:simpel/cubit/list_suara_cubit.dart';
import 'package:simpel/cubit/navbar_cubit.dart';
import 'package:simpel/cubit/user_cubit.dart';
import 'package:simpel/shared/shared_prefrences.dart';
import 'package:simpel/shared/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashSecondPage extends StatefulWidget {
  const SplashSecondPage({super.key});

  @override
  State<SplashSecondPage> createState() => _SplashSecondPageState();
}

class _SplashSecondPageState extends State<SplashSecondPage>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {
          if (controller.value == 1.0) {
            dynamic session = SharedPreference.login.getBool("is_login");

            debugPrint(session.toString());

            if (session == null) {
              Navigator.pushNamedAndRemoveUntil(
                  context, 'login', (route) => false);
            } else {
              if (session) {
                String uuid = SharedPreference.login.getString("uuid");
                context
                    .read<UserCubit>()
                    .getDataUser(uuid: uuid); //get data user dari api
                 //get data total suara dari api
                context
                    .read<ListSuaraCubit>()
                    .getDataListSuara(page: ""); //get data list suara
                context
                    .read<ListKabupatenCubit>()
                    .getKabupatenData(); //get data kabupaten dari api
                context.read<KomunitasCubit>().getDataKomunitas();
                context.read<NavbarCubit>().setPage(0);

                Navigator.pushNamedAndRemoveUntil(
                    context, 'main', (route) => false);
              } else {
                Navigator.pushNamedAndRemoveUntil(
                    context, 'login', (route) => false);
              }
            }
          } else {
            null;
          }
        });
      });
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Image.asset("assets/background_splash.png", width: double.infinity, fit: BoxFit.fill,)),
                  const SizedBox(
                    height: 59,
                  ),
                  Text(
                    "Selamat Datang\nDIGIPAS",
                    textAlign: TextAlign.center,
                    style: primaryTextStyle.copyWith(
                        fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 58,)
                ],
              )),
        ],
      ),
    );
  }
}
