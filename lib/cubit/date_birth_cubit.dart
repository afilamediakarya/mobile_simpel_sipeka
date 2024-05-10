import 'package:flutter_bloc/flutter_bloc.dart';

class DateBirthCubit extends Cubit<String> {
  DateBirthCubit() : super("Masukkan Tanggal Lahir");

  void setDate(String date) {
    emit(date);
  }

  void setinitDate() {
    emit("Masukkan Tanggal Lahir");
  }
}
