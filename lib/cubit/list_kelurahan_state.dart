part of 'list_kelurahan_cubit.dart';

abstract class ListKelurahanState extends Equatable {
  const ListKelurahanState();

  @override
  List<Object> get props => [];
}

class ListKelurahanInitial extends ListKelurahanState {}

class ListKelurahanLoading extends ListKelurahanState {}

class ListKelurahanSuccess extends ListKelurahanState {
  final List listKelurahan;

  ListKelurahanSuccess(this.listKelurahan);

  @override
  List<Object> get props => [listKelurahan];
}

class ListKelurahanFailed extends ListKelurahanState {
  final String error;

  ListKelurahanFailed(this.error);

  @override
  List<Object> get props => [error];
}
