part of 'komunitas_cubit.dart';

abstract class KomunitasState extends Equatable {
  const KomunitasState();

  @override
  List<Object> get props => [];
}

class KomunitasInitial extends KomunitasState {}

class KomunitasLoading extends KomunitasState {}

class KomunitasSuccess extends KomunitasState {
  final List dataKomunitas;

  KomunitasSuccess(
    this.dataKomunitas,
  );

  @override
  List<Object> get props => [dataKomunitas];
}

class KomunitasFailed extends KomunitasState {
  final String error;

  KomunitasFailed(this.error);

  @override
  List<Object> get props => [error];
}
