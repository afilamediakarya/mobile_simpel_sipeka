import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simpel/models/informasi_pribadi_model.dart';
import 'package:simpel/services/tambah_suara_services.dart';

part 'informasi_pribadi_state.dart';

class InformasiPribadiCubit extends Cubit<InformasiPribadiState> {
  InformasiPribadiCubit() : super(InformasiPribadiInitial());

  void getDataInformasiPribadi({required String nik}) async {
    try {
      emit(InformasiPribadiLoading());

      InformasiPribadiModel informasiPribadiModel =
          await TambahSuaraServices().getDataInformasiPribadi(nik: nik);

      emit(InformasiPribadiSuccess(informasiPribadiModel));
    } catch (e) {
      emit(InformasiPribadiFailed(e.toString()));
    }
  }
}
