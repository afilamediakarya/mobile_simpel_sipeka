part of 'tambah_suara_bukan_dpt_cubit.dart';

abstract class TambahSuaraBukanDptState extends Equatable {
  const TambahSuaraBukanDptState();

  @override
  List<Object> get props => [];
}

class TambahSuaraBukanDptInitial extends TambahSuaraBukanDptState {}

class TambahSuaraBukanDptLoading extends TambahSuaraBukanDptState {}

class TambahSuaraBukanDptSuccess extends TambahSuaraBukanDptState {
  final bool status;

  TambahSuaraBukanDptSuccess(
    this.status,
  );

  @override
  List<Object> get props => [status];
}

class TambahSuaraBukanDptFailed extends TambahSuaraBukanDptState {
  final String error;

  TambahSuaraBukanDptFailed(this.error);

  @override
  List<Object> get props => [error];
}
