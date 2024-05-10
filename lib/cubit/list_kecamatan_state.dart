part of 'list_kecamatan_cubit.dart';

abstract class ListKecamatanState extends Equatable {
  const ListKecamatanState();

  @override
  List<Object> get props => [];
}

class ListKecamatanInitial extends ListKecamatanState {}

class ListKecamatanLoading extends ListKecamatanState {}

class ListKecamatanSuccess extends ListKecamatanState {
  final List listKecamatan;

  ListKecamatanSuccess(this.listKecamatan);

  @override
  List<Object> get props => [listKecamatan];
}

class ListKecamatanFailed extends ListKecamatanState {
  final String error;

  ListKecamatanFailed(this.error);

  @override
  List<Object> get props => [error];
}
