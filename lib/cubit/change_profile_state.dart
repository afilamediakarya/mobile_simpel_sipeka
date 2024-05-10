part of 'change_profile_cubit.dart';

abstract class ChangeProfileState extends Equatable {
  const ChangeProfileState();

  @override
  List<Object> get props => [];
}

class ChangeProfileInitial extends ChangeProfileState {}

class ChangeProfileLoading extends ChangeProfileState {}

class ChangeProfileSuccess extends ChangeProfileState {
  final bool status;

  const ChangeProfileSuccess(
    this.status,
  );

  @override
  List<Object> get props => [status];
}

class ChangeProfileFailed extends ChangeProfileState {
  final String error;

  const ChangeProfileFailed(this.error);

  @override
  List<Object> get props => [error];
}
