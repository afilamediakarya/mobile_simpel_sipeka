part of 'list_kabupaten_cubit.dart';

abstract class ListKabupatenState extends Equatable {
  const ListKabupatenState();

  @override
  List<Object> get props => [];
}

class ListKabupatenInitial extends ListKabupatenState {}

class ListKabupatenLoading extends ListKabupatenState {}

class ListKabupatenSuccess extends ListKabupatenState {
  final List listKabupaten;

  ListKabupatenSuccess(this.listKabupaten);

  @override
  List<Object> get props => [listKabupaten];
}

class ListKabupatenFailed extends ListKabupatenState {
  final String error;

  ListKabupatenFailed(this.error);

  @override
  List<Object> get props => [error];
}
