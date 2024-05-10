part of 'total_suara_cubit.dart';

abstract class TotalSuaraState extends Equatable {
  const TotalSuaraState();

  @override
  List<Object> get props => [];
}

class TotalSuaraInitial extends TotalSuaraState {}

class TotalSuaraLoading extends TotalSuaraState {}

class TotalSuaraSuccess extends TotalSuaraState {
  final TotalSuaraModel dataTotalSuaraModel;

  TotalSuaraSuccess(
    this.dataTotalSuaraModel,
  );

  @override
  List<Object> get props => [dataTotalSuaraModel];
}

class TotalSuaraFailed extends TotalSuaraState {
  final String error;

  TotalSuaraFailed(this.error);

  @override
  List<Object> get props => [error];
}
