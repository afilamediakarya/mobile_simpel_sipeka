import 'package:flutter_bloc/flutter_bloc.dart';

class ShowHideChangePass_3Cubit extends Cubit<bool> {
  ShowHideChangePass_3Cubit() : super(true);

  void setShowHidePass(bool obscure) {
    emit(obscure);
  }
}
