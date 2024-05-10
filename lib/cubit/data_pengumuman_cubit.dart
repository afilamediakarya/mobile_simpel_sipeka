import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simpel/models/list_pengumuman_model.dart';
import 'package:simpel/services/pengumuman_service.dart';

part 'data_pengumuman_state.dart';

class DataPengumumanCubit extends Cubit<DataPengumumanState> {
  DataPengumumanCubit() : super(DataPengumumanInitial());

    void getDataListPengumuman() async {
    try {
      emit(DataPengumumanLoading());

      List<DataPengumuman> dataPengumuman =
          await PengumumanServices().getDataPengumuman();

      emit(DataPengumumanSuccess(dataPengumuman));
    } catch (e) {
      emit(DataPengumumanFailed(e.toString()));
    }
  }
}
