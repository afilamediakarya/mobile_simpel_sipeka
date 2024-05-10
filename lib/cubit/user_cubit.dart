import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simpel/models/user_model.dart';
import 'package:simpel/services/user_services.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  void getDataUser({required String uuid}) async {
    try {
      emit(DataUserLoading());

      UserModel dataUserModel = await UserServices().getDataUser(uuid: uuid);

      emit(DataUserSuccess(dataUserModel));
    } catch (e) {
      emit(DataUserFailed(e.toString()));
    }
  }
}
