import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simpel/models/list_suara_model.dart';
import 'package:simpel/services/suara_services.dart';

part 'list_suara_state.dart';

class ListSuaraCubit extends Cubit<ListSuaraState> {
  ListSuaraCubit() : super(ListSuaraInitial());

  void getDataListSuara({required String page}) async {
    try {
      emit(ListSuaraLoading());

      List<DataListSuara> dataListSuara =
          await SuaraServices().getDataListSuara(page: page);

      emit(ListSuaraSuccess(dataListSuara));
    } catch (e) {
      emit(ListSuaraFailed(e.toString()));
    }
  }

  void getDataListSuaraLoad({required String page}) async {
    try {

      List<DataListSuara> dataListSuara =
          await SuaraServices().getDataListSuara(page: page);

      emit(ListSuaraSuccess(dataListSuara));
    } catch (e) {
      emit(ListSuaraFailed(e.toString()));
    }
  }
}
