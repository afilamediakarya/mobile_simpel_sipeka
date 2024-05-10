import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simpel/models/tambah_data_suara_sementara_model.dart';
import 'package:simpel/services/tambah_suara_services.dart';

part 'tambah_data_suara_sementara_state.dart';

class TambahDataSuaraSementaraCubit
    extends Cubit<TambahDataSuaraSementaraState> {
  TambahDataSuaraSementaraCubit() : super(TambahDataSuaraSementaraInitial());

  void tambahDataSuaraSementara(
      {required TambahDataSuaraSementaraModel data}) async {
    try {
      emit(TambahDataSuaraSementaraLoading());

      TambahDataSuaraSementaraModel tambahDataSuaraSementaraModel = await TambahSuaraServices().tambahDataSuaraSementara(
        data: data
      );

      emit(TambahDataSuaraSementaraSuccess(tambahDataSuaraSementaraModel));
    } catch (e) {
      emit(TambahDataSuaraSementaraFailed(e.toString()));
    }
  }
}
