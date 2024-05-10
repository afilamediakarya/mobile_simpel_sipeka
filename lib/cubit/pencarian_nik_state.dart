part of 'pencarian_nik_cubit.dart';

abstract class PencarianNikState extends Equatable {
  const PencarianNikState();

  @override
  List<Object> get props => [];
}

class PencarianNikInitial extends PencarianNikState {}

class PencarianNikLoading extends PencarianNikState {}

class PencarianNikSuccess extends PencarianNikState {
  final PencarianNikModel pencarianNikModel;

  PencarianNikSuccess(
    this.pencarianNikModel,
  );

  @override
  List<Object> get props => [pencarianNikModel];
}

class PencarianNikFailed extends PencarianNikState {
  final String error;

  PencarianNikFailed(this.error);

  @override
  List<Object> get props => [error];
}
