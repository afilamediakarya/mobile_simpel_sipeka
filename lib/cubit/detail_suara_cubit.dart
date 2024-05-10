import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simpel/models/detail_suara_model.dart';
import 'package:simpel/services/suara_services.dart';

part 'detail_suara_state.dart';

class DetailSuaraCubit extends Cubit<DetailSuaraState> {
  DetailSuaraCubit() : super(DetailSuaraInitial());

  void getDataDetailSuara({required String id}) async {
    try {
      emit(DetailSuaraLoading());

      DetailSuaraModel dataDetailSuaraModel =
          await SuaraServices().getDataDetailSuara(id: id);

      emit(DetailSuaraSuccess(dataDetailSuaraModel));
    } catch (e) {
      emit(DetailSuaraFailed(e.toString()));
    }
  }
}
