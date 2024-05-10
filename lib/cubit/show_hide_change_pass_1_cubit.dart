import 'package:flutter_bloc/flutter_bloc.dart';

class ShowHideChangePass_1Cubit extends Cubit<bool> {
  ShowHideChangePass_1Cubit() : super(true);

  void setShowHidePass(bool obscure) {
    emit(obscure);
  }
}
