import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simpel/models/kandidat_model.dart';
import 'package:simpel/services/kandidat_services.dart';

part 'kandidat_state.dart';

class KandidatCubit extends Cubit<KandidatState> {
  KandidatCubit() : super(KandidatInitial());

  void getDataKandidat({required String idCalon}) async {
    try {
      emit(KandidatLoading());

      KandidatModel dataDetailSuaraModel =
          await KandidatServices().getDataKandidat(idCalon: idCalon);

      emit(KandidatSuccess(dataDetailSuaraModel));
    } catch (e) {
      emit(KandidatFailed(e.toString()));
    }
  }
}
