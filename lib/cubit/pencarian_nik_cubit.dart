import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simpel/models/pencarian_nik_model.dart';
import 'package:simpel/services/tambah_suara_services.dart';

part 'pencarian_nik_state.dart';

class PencarianNikCubit extends Cubit<PencarianNikState> {
  PencarianNikCubit() : super(PencarianNikInitial());

  void getPencarianNik({required String nik}) async {
    try {
      emit(PencarianNikLoading());

      PencarianNikModel pencarianNikModel =
          await TambahSuaraServices().getDataPencarianNik(nik: nik);

      emit(PencarianNikSuccess(pencarianNikModel));
    } catch (e) {
      emit(PencarianNikFailed(e.toString()));
    }
  }
}
