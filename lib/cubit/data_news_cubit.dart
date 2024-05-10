import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simpel/models/news_model.dart';
import 'package:simpel/services/news_services.dart';

part 'data_news_state.dart';

class DataNewsCubit extends Cubit<DataNewsState> {
  DataNewsCubit() : super(DataNewsInitial());

  void getDataListNews() async {
    try {
      emit(DataNewsLoading());

      List<DataNews> dataNews =
          await NewsServices().getDataNews();

      emit(DataNewsSuccess(dataNews));
    } catch (e) {
      emit(DataNewsFailed(e.toString()));
    }
  }
}
