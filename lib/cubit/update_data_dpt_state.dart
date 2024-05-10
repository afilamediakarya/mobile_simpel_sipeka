part of 'update_data_dpt_cubit.dart';

abstract class UpdateDataDptState extends Equatable {
  const UpdateDataDptState();

  @override
  List<Object> get props => [];
}

class UpdateDataDptInitial extends UpdateDataDptState {}

class UpdateDataDptLoading extends UpdateDataDptState {}

class UpdateDataDptSuccess extends UpdateDataDptState {
  final bool status;

  UpdateDataDptSuccess(
    this.status,
  );

  @override
  List<Object> get props => [status];
}

class UpdateDataDptFailed extends UpdateDataDptState {
  final String error;

  UpdateDataDptFailed(this.error);

  @override
  List<Object> get props => [error];
}
