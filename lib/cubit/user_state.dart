part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class DataUserLoading extends UserState {}

class DataUserSuccess extends UserState {
  final UserModel dataUserModel;

  DataUserSuccess(
    this.dataUserModel,
  );

  @override
  List<Object> get props => [dataUserModel];
}

class DataUserFailed extends UserState {
  final String error;

  DataUserFailed(this.error);

  @override
  List<Object> get props => [error];
}
