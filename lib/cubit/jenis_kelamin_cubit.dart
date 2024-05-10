import 'package:flutter_bloc/flutter_bloc.dart';

class JenisKelaminCubit extends Cubit<int> {
  JenisKelaminCubit() : super(0);

  void setGender(int gender) {
    emit(gender);
  }
}
