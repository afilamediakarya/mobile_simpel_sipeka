import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simpel/models/total_suara_model.dart';
import 'package:simpel/services/suara_services.dart';

part 'total_suara_state.dart';

class TotalSuaraCubit extends Cubit<TotalSuaraState> {
  TotalSuaraCubit() : super(TotalSuaraInitial());

  void getDataTotalSuara() async {
    try {
      emit(TotalSuaraLoading());

      TotalSuaraModel dataTotalSuaraModel =
          await SuaraServices().getDataTotalSuara();

      emit(TotalSuaraSuccess(dataTotalSuaraModel));
    } catch (e) {
      emit(TotalSuaraFailed(e.toString()));
    }
  }
}
