import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simpel/services/option_services.dart';

part 'list_kabupaten_state.dart';

class ListKabupatenCubit extends Cubit<ListKabupatenState> {
  ListKabupatenCubit() : super(ListKabupatenInitial());

  void getKabupatenData() async {
    try {
      emit(ListKabupatenLoading());

      List listKabupaten = await OptionServices().getDataListKabupaten();

      emit(ListKabupatenSuccess(listKabupaten));
    } catch (e) {
      emit(ListKabupatenFailed(e.toString()));
    }
  }
}
