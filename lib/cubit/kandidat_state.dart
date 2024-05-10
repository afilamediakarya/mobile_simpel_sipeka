part of 'kandidat_cubit.dart';

abstract class KandidatState extends Equatable {
  const KandidatState();

  @override
  List<Object> get props => [];
}

class KandidatInitial extends KandidatState {}

class KandidatLoading extends KandidatState {}

class KandidatSuccess extends KandidatState {
  final KandidatModel kandidatModel;

  KandidatSuccess(
    this.kandidatModel,
  );

  @override
  List<Object> get props => [kandidatModel];
}

class KandidatFailed extends KandidatState {
  final String error;

  KandidatFailed(this.error);

  @override
  List<Object> get props => [error];
}
