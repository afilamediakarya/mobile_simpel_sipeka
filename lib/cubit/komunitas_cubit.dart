import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simpel/services/option_services.dart';

part 'komunitas_state.dart';

class KomunitasCubit extends Cubit<KomunitasState> {
  KomunitasCubit() : super(KomunitasInitial());

  void getDataKomunitas() async {
    try {
      emit(KomunitasLoading());

      List dataKomunitas = await OptionServices().getDataKomunitas();

      emit(KomunitasSuccess(dataKomunitas));
    } catch (e) {
      emit(KomunitasFailed(e.toString()));
    }
  }
}
