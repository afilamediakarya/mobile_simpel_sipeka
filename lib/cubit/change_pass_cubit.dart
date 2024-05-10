import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simpel/services/user_services.dart';

part 'change_pass_state.dart';

class ChangePassCubit extends Cubit<ChangePassState> {
  ChangePassCubit() : super(ChangePassInitial());

  void changePass({required String oldPass, required String newPass}) async {
    try {
      emit(ChangePassLoading());

      bool status = await UserServices()
          .changePassword(oldPass: oldPass, newPass: newPass);

      emit(ChangePassSuccess(status));
    } catch (e) {
      emit(ChangePassFailed(e.toString()));
    }
  }
}
