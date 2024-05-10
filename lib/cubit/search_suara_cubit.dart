import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simpel/models/search_suara_model.dart';
import 'package:simpel/services/suara_services.dart';

part 'search_suara_state.dart';

class SearchSuaraCubit extends Cubit<SearchSuaraState> {
  SearchSuaraCubit() : super(SearchSuaraInitial());

  void getDataSearchSuara({required String value}) async {
    try {
      emit(SearchSuaraLoading());

      List<DataSearchSuara> dataSearchSuara =
          await SuaraServices().getSearchSuara(value: value);

      emit(SearchSuaraSuccess(dataSearchSuara));
    } catch (e) {
      emit(SearchSuaraFailed(e.toString()));
    }
  }
}
