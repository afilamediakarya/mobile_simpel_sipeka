import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simpel/services/user_services.dart';

part 'change_profile_state.dart';

class ChangeProfileCubit extends Cubit<ChangeProfileState> {
  ChangeProfileCubit() : super(ChangeProfileInitial());

  void changeProfile({
    required String nik,
    required String nama,
    required String jenisKelamin,
    required String alamat,
    required int idDesa,
    required String foto,
  }) async {
    try {
      emit(ChangeProfileLoading());

      bool status = await UserServices().changeProfile(
          nik: nik,
          nama: nama,
          jenisKelamin: jenisKelamin,
          alamat: alamat,
          foto: foto,
          idDesa: idDesa.toString());

      emit(ChangeProfileSuccess(status));
    } catch (e) {
      emit(ChangeProfileFailed(e.toString()));
    }
  }
}
