part of 'list_suara_cubit.dart';

abstract class ListSuaraState extends Equatable {
  const ListSuaraState();

  @override
  List<Object> get props => [];
}

class ListSuaraInitial extends ListSuaraState {}

class ListSuaraLoading extends ListSuaraState {}

class ListSuaraSuccess extends ListSuaraState {
  final List<DataListSuara> dataListSuara;

  ListSuaraSuccess(
    this.dataListSuara,
  );

  @override
  List<Object> get props => [dataListSuara];
}

class ListSuaraFailed extends ListSuaraState {
  final String error;

  ListSuaraFailed(this.error);

  @override
  List<Object> get props => [error];
}
