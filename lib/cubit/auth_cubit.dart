import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:simpel/services/auth_services.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void loginUser({
    required String username,
    required String password,
  }) async {
    try {
      emit(LoginUserLoading());

      String status = await AuthServices()
          .loginUser(username: username, password: password);

      emit(LoginUserSuccess(status));
    } catch (e) {
      emit(LoginUserFailed(e.toString()));
    }
  }
}
