// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simpel/cubit/auth_cubit.dart';
import 'package:simpel/cubit/change_pass_cubit.dart';
import 'package:simpel/cubit/change_profile_cubit.dart';
import 'package:simpel/cubit/confirm_photo_rumah_cubit.dart';
import 'package:simpel/cubit/confirm_photo_profile_cubit.dart';
import 'package:simpel/cubit/confirm_photo_swafoto_cubit.dart';
import 'package:simpel/cubit/data_news_cubit.dart';
import 'package:simpel/cubit/data_pengumuman_cubit.dart';
import 'package:simpel/cubit/date_birth_cubit.dart';
import 'package:simpel/cubit/detail_suara_cubit.dart';
import 'package:simpel/cubit/informasi_pribadi_cubit.dart';
import 'package:simpel/cubit/jenis_kelamin_cubit.dart';
import 'package:simpel/cubit/kandidat_cubit.dart';
import 'package:simpel/cubit/kinerja_percent_cubit.dart';
import 'package:simpel/cubit/komunitas_cubit.dart';
import 'package:simpel/cubit/list_kabupaten_cubit.dart';
import 'package:simpel/cubit/list_kecamatan_cubit.dart';
import 'package:simpel/cubit/list_kelurahan_cubit.dart';
import 'package:simpel/cubit/list_kelurahan_profile_cubit.dart';
import 'package:simpel/cubit/list_suara_cubit.dart';
import 'package:simpel/cubit/list_tps_cubit.dart';
import 'package:simpel/cubit/navbar_cubit.dart';
import 'package:simpel/cubit/pencarian_nik_cubit.dart';
import 'package:simpel/cubit/search_suara_cubit.dart';
import 'package:simpel/cubit/show_hide_change_pass_1_cubit.dart';
import 'package:simpel/cubit/show_hide_change_pass_2_cubit.dart';
import 'package:simpel/cubit/show_hide_change_pass_3_cubit.dart';
import 'package:simpel/cubit/show_hide_pass_cubit.dart';
import 'package:simpel/cubit/tambah_data_suara_sementara_cubit.dart';
import 'package:simpel/cubit/tambah_suara_bukan_dpt_cubit.dart';
import 'package:simpel/cubit/tambah_suara_dpt_cubit.dart';
import 'package:simpel/cubit/total_suara_cubit.dart';
import 'package:simpel/cubit/type_user_cubit.dart';
import 'package:simpel/cubit/update_data_dpt_cubit.dart';
import 'package:simpel/cubit/user_cubit.dart';
import 'package:simpel/ui/pages/akun/camera_profile_page.dart';
import 'package:simpel/ui/pages/main_page.dart';
import 'package:simpel/ui/pages/akun/bantuan_page.dart';
import 'package:simpel/ui/pages/akun/edit_profile_page.dart';
import 'package:simpel/ui/pages/akun/ubah_password_page.dart';
import 'package:simpel/ui/pages/auth/login_page.dart';
import 'package:simpel/ui/pages/auth/splash_first_page.dart';
import 'package:simpel/ui/pages/auth/splash_second_page.dart';
import 'package:simpel/ui/pages/suara/detail_suara_page.dart';
import 'package:simpel/ui/pages/suara/search_suara_page.dart';
import 'package:simpel/ui/pages/tambah/rumah/camera_rumah_page.dart';
import 'package:simpel/ui/pages/tambah/informasi_data_pribadi_page.dart';
import 'package:simpel/ui/pages/tambah/swafoto/camera_swafoto_page.dart';
import 'package:simpel/ui/pages/tambah/tambah_data_pribadi_page.dart';
import 'package:simpel/ui/pages/tambah/tambah_suara_page.dart';

List<CameraDescription> cameras = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    cameras = await availableCameras();
    // ignore: unused_catch_clause
  } on CameraException catch (e) {
    //  logError(e.code, e.description);
  }
  runApp(MyApp(
    camera: cameras,
  ));
}

class MyApp extends StatefulWidget {
  List<CameraDescription> camera;
  MyApp({super.key, required this.camera});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    HttpOverrides.global = MyHttpOverrides();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ((context) => NavbarCubit())),
        BlocProvider(create: ((context) => JenisKelaminCubit())),
        BlocProvider(create: ((context) => AuthCubit())),
        BlocProvider(create: ((context) => UserCubit())),
        BlocProvider(create: ((context) => ChangePassCubit())),
        BlocProvider(create: ((context) => TotalSuaraCubit())),
        BlocProvider(create: ((context) => ListSuaraCubit())),
        BlocProvider(create: ((context) => DetailSuaraCubit())),
        BlocProvider(create: ((context) => InformasiPribadiCubit())),
        BlocProvider(create: ((context) => SearchSuaraCubit())),
        BlocProvider(create: ((context) => PencarianNikCubit())),
        BlocProvider(create: ((context) => ShowHidePassCubit())),
        BlocProvider(create: ((context) => ListKabupatenCubit())),
        BlocProvider(create: ((context) => ListKecamatanCubit())),
        BlocProvider(create: ((context) => ListKelurahanCubit())),
        BlocProvider(create: ((context) => ChangeProfileCubit())),
        BlocProvider(create: ((context) => TypeUserCubit())),
        BlocProvider(create: ((context) => ConfirmPhotoRumahCubit())),
        BlocProvider(create: ((context) => ConfirmPhotoSwafotoCubit())),
        BlocProvider(create: ((context) => TambahSuaraDptCubit())),
        BlocProvider(create: ((context) => TambahDataSuaraSementaraCubit())),
        BlocProvider(create: ((context) => DateBirthCubit())),
        BlocProvider(create: ((context) => TambahSuaraBukanDptCubit())),
        BlocProvider(create: ((context) => ListTpsCubit())),
        BlocProvider(create: ((context) => ShowHideChangePass_1Cubit())),
        BlocProvider(create: ((context) => ShowHideChangePass_2Cubit())),
        BlocProvider(create: ((context) => ShowHideChangePass_3Cubit())),
        BlocProvider(create: ((context) => KandidatCubit())),
        BlocProvider(create: ((context) => KomunitasCubit())),
        BlocProvider(create: ((context) => ConfirmPhotoProfileCubit())),
        BlocProvider(create: ((context) => ListKelurahanProfileCubit())),
        BlocProvider(create: ((context) => UpdateDataDptCubit())),
        BlocProvider(create: ((context) => DataNewsCubit())),
        BlocProvider(create: ((context) => KinerjaPercentCubit())),
        BlocProvider(create: ((context) => DataPengumumanCubit())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashFirstPage(),
          'splash-second': (context) => const SplashSecondPage(),
          'login': (context) => const LoginPage(),
          'main': (context) => const MainPage(),
          'detail-suara': (context) => const DetailSuaraPage(),
          'edit-profile': (context) => const EditProfilePage(),
          'bantuan': (context) => const BantuanPage(),
          'ubah-password': (context) => const UbahPasswordPage(),
          'tambah-data-pribadi': (context) => const TambahDataPribadiPage(),
          'info-data-pribadi': (context) => const InformasiDataPribadiPage(),
          'tambah-suara': (context) => const TambahSuaraPage(),
          'search-suara': (context) => const SearchSuaraPage(),
          'camera-rumah': (context) => CameraRumahPage(cameras: widget.camera),
          'camera-swafoto': (context) =>
              CameraSwafotoPage(cameras: widget.camera),
          'camera-profile': (context) =>
              CameraProfilePage(cameras: widget.camera)
        },
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
