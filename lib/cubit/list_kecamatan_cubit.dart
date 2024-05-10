import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simpel/services/option_services.dart';

part 'list_kecamatan_state.dart';

class ListKecamatanCubit extends Cubit<ListKecamatanState> {
  ListKecamatanCubit() : super(ListKecamatanInitial());

  void getKecamatanData({required int idKabupaten}) async {
    try {
      emit(ListKecamatanLoading());

      List listKecamatan =
          await OptionServices().getDataListKecamatan(idKabupaten: idKabupaten);

      emit(ListKecamatanSuccess(listKecamatan));
    } catch (e) {
      emit(ListKecamatanFailed(e.toString()));
    }
  }
}
