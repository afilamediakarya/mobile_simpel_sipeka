import 'package:flutter_bloc/flutter_bloc.dart';

class ShowHidePassCubit extends Cubit<bool> {
  ShowHidePassCubit() : super(true);

  void setShowHidePass(bool obscure) {
    emit(obscure);
  }
}
