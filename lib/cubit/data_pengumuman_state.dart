part of 'data_pengumuman_cubit.dart';

abstract class DataPengumumanState extends Equatable {
  const DataPengumumanState();

  @override
  List<Object> get props => [];
}

class DataPengumumanInitial extends DataPengumumanState {}

class DataPengumumanLoading extends DataPengumumanState {}

class DataPengumumanSuccess extends DataPengumumanState {
  final List<DataPengumuman> dataPengumuman;

  const DataPengumumanSuccess(
    this.dataPengumuman,
  );

  @override
  List<Object> get props => [dataPengumuman];
}

class DataPengumumanFailed extends DataPengumumanState {
  final String error;

  const DataPengumumanFailed(this.error);

  @override
  List<Object> get props => [error];
}