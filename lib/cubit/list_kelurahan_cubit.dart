import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simpel/services/option_services.dart';

part 'list_kelurahan_state.dart';

class ListKelurahanCubit extends Cubit<ListKelurahanState> {
  ListKelurahanCubit() : super(ListKelurahanInitial());

  void getKelurahanData({required int idCalon}) async {
    try {
      emit(ListKelurahanLoading());

      List listKelurahan =
          await OptionServices().getDataListKelurahan(idCalon: idCalon);

      emit(ListKelurahanSuccess(listKelurahan));
    } catch (e) {
      emit(ListKelurahanFailed(e.toString()));
    }
  }
}
