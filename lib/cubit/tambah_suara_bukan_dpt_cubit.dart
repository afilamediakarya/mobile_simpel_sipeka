import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simpel/models/tambah_data_suara_bukan_dpt_model.dart';
import 'package:simpel/services/tambah_suara_services.dart';

part 'tambah_suara_bukan_dpt_state.dart';

class TambahSuaraBukanDptCubit extends Cubit<TambahSuaraBukanDptState> {
  TambahSuaraBukanDptCubit() : super(TambahSuaraBukanDptInitial());

  void tambahSuaraBukanDpt({
    required TambahDataSuaraBukanDptModel tambahDataSuaraBukanDptModel
  }) async {
    try {
      emit(TambahSuaraBukanDptLoading());

      bool status = await TambahSuaraServices().tambahSuaraBukanDpt(
        dataSuara: tambahDataSuaraBukanDptModel
      );

      emit(TambahSuaraBukanDptSuccess(status));
    } catch (e) {
      emit(TambahSuaraBukanDptFailed(e.toString()));
    }
  }
}
