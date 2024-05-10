import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simpel/models/tambah_data_suara_dpt_model.dart';
import 'package:simpel/services/tambah_suara_services.dart';

part 'tambah_suara_dpt_state.dart';

class TambahSuaraDptCubit extends Cubit<TambahSuaraDptState> {
  TambahSuaraDptCubit() : super(TambahSuaraDptInitial());

  void tambahSuaraDpt({
      required TambahDataSuaraDptModel tambahDataSuaraDptModel}) async {
    try {
      emit(TambahSuaraDptLoading());

      bool status = await TambahSuaraServices().tambahSuaraDpt(
          dataSuara: tambahDataSuaraDptModel);

      emit(TambahSuaraDptSuccess(status));
    } catch (e) {
      emit(TambahSuaraDptFailed(e.toString()));
    }
  }
}
