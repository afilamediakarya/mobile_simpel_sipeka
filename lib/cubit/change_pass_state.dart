part of 'change_pass_cubit.dart';

abstract class ChangePassState extends Equatable {
  const ChangePassState();

  @override
  List<Object> get props => [];
}

class ChangePassInitial extends ChangePassState {}

class ChangePassLoading extends ChangePassState {}

class ChangePassSuccess extends ChangePassState {
  final bool changePassModel;

  const ChangePassSuccess(
    this.changePassModel,
  );

  @override
  List<Object> get props => [changePassModel];
}

class ChangePassFailed extends ChangePassState {
  final String error;

  const ChangePassFailed(this.error);

  @override
  List<Object> get props => [error];
}
