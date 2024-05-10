part of 'search_suara_cubit.dart';

abstract class SearchSuaraState extends Equatable {
  const SearchSuaraState();

  @override
  List<Object> get props => [];
}

class SearchSuaraInitial extends SearchSuaraState {}

class SearchSuaraLoading extends SearchSuaraState {}

class SearchSuaraSuccess extends SearchSuaraState {
  final List<DataSearchSuara> dataSearchSuara;

  SearchSuaraSuccess(
    this.dataSearchSuara,
  );

  @override
  List<Object> get props => [dataSearchSuara];
}

class SearchSuaraFailed extends SearchSuaraState {
  final String error;

  SearchSuaraFailed(this.error);

  @override
  List<Object> get props => [error];
}
