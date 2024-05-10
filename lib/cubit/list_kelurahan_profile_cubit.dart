import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simpel/services/option_services.dart';

part 'list_kelurahan_profile_state.dart';

class ListKelurahanProfileCubit extends Cubit<ListKelurahanProfileState> {
  ListKelurahanProfileCubit() : super(ListKelurahanProfileInitial());

  void getKelurahanProfileData({required int idKecamatan}) async {
    try {
      emit(ListKelurahanProfileLoading());

      List listKelurahan = await OptionServices()
          .getDataListKelurahanProfile(idKecamatan: idKecamatan);

      emit(ListKelurahanProfileSuccess(listKelurahan));
    } catch (e) {
      emit(ListKelurahanProfileFailed(e.toString()));
    }
  }
}
