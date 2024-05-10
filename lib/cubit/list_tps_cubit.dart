import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simpel/services/option_services.dart';

part 'list_tps_state.dart';

class ListTpsCubit extends Cubit<ListTpsState> {
  ListTpsCubit() : super(ListTpsInitial());

  void getTpsData({required int idKelurahan}) async {
    try {
      emit(ListTpsLoading());

      List listKelurahan =
          await OptionServices().getDataListTps(idKelurahan: idKelurahan);

      emit(ListTpsSuccess(listKelurahan));
    } catch (e) {
      emit(ListTpsFailed(e.toString()));
    }
  }
}
