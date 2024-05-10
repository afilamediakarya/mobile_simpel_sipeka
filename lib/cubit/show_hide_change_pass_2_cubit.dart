import 'package:flutter_bloc/flutter_bloc.dart';

class ShowHideChangePass_2Cubit extends Cubit<bool> {
  ShowHideChangePass_2Cubit() : super(true);

  void setShowHidePass(bool obscure) {
    emit(obscure);
  }
}
