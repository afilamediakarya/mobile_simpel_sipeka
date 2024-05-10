part of 'detail_suara_cubit.dart';

abstract class DetailSuaraState extends Equatable {
  const DetailSuaraState();

  @override
  List<Object> get props => [];
}

class DetailSuaraInitial extends DetailSuaraState {}

class DetailSuaraLoading extends DetailSuaraState {}

class DetailSuaraSuccess extends DetailSuaraState {
  final DetailSuaraModel dataDetailSuara;

  DetailSuaraSuccess(
    this.dataDetailSuara,
  );

  @override
  List<Object> get props => [dataDetailSuara];
}

class DetailSuaraFailed extends DetailSuaraState {
  final String error;

  DetailSuaraFailed(this.error);

  @override
  List<Object> get props => [error];
}
