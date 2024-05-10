import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simpel/models/update_dpt_model.dart';
import 'package:simpel/services/tambah_suara_services.dart';

part 'update_data_dpt_state.dart';

class UpdateDataDptCubit extends Cubit<UpdateDataDptState> {
  UpdateDataDptCubit() : super(UpdateDataDptInitial());

  void updateDataDpt({
      required UpdateDataDptModel updateDataDptModel}) async {
    try {
      
      emit(UpdateDataDptLoading());

      bool status = await TambahSuaraServices().updateDataDpt(dataSuara: updateDataDptModel);

      emit(UpdateDataDptSuccess(status));
    } catch (e) {
      emit(UpdateDataDptFailed(e.toString()));
    }
  }
}
