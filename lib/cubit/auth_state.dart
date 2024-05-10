part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class LoginUserLoading extends AuthState {}

class LoginUserSuccess extends AuthState {
  final String status;

  const LoginUserSuccess(
    this.status,
  );

  @override
  List<Object> get props => [status];
}

class LoginUserFailed extends AuthState {
  final String error;

  const LoginUserFailed(this.error);

  @override
  List<Object> get props => [error];
}
