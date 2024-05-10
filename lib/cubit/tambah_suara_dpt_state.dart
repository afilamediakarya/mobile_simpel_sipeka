part of 'tambah_suara_dpt_cubit.dart';

abstract class TambahSuaraDptState extends Equatable {
  const TambahSuaraDptState();

  @override
  List<Object> get props => [];
}

class TambahSuaraDptInitial extends TambahSuaraDptState {}

class TambahSuaraDptLoading extends TambahSuaraDptState {}

class TambahSuaraDptSuccess extends TambahSuaraDptState {
  final bool status;

  TambahSuaraDptSuccess(
    this.status,
  );

  @override
  List<Object> get props => [status];
}

class TambahSuaraDptFailed extends TambahSuaraDptState {
  final String error;

  TambahSuaraDptFailed(this.error);

  @override
  List<Object> get props => [error];
}
