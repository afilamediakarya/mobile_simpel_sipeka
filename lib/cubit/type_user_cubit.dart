import 'package:flutter_bloc/flutter_bloc.dart';

class TypeUserCubit extends Cubit<String> {
  TypeUserCubit() : super("init");

  void setTypeUser(String typeUser) {
    emit(typeUser);
  }
}
