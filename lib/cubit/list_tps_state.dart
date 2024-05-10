part of 'list_tps_cubit.dart';

abstract class ListTpsState extends Equatable {
  const ListTpsState();

  @override
  List<Object> get props => [];
}

class ListTpsInitial extends ListTpsState {}

class ListTpsLoading extends ListTpsState {}

class ListTpsSuccess extends ListTpsState {
  final List listTps;

  ListTpsSuccess(this.listTps);

  @override
  List<Object> get props => [listTps];
}

class ListTpsFailed extends ListTpsState {
  final String error;

  ListTpsFailed(this.error);

  @override
  List<Object> get props => [error];
}
