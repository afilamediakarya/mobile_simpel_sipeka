part of 'informasi_pribadi_cubit.dart';

abstract class InformasiPribadiState extends Equatable {
  const InformasiPribadiState();

  @override
  List<Object> get props => [];
}

class InformasiPribadiInitial extends InformasiPribadiState {}

class InformasiPribadiLoading extends InformasiPribadiState {}

class InformasiPribadiSuccess extends InformasiPribadiState {
  final InformasiPribadiModel informasiPribadiModel;

  InformasiPribadiSuccess(
    this.informasiPribadiModel,
  );

  @override
  List<Object> get props => [informasiPribadiModel];
}

class InformasiPribadiFailed extends InformasiPribadiState {
  final String error;

  InformasiPribadiFailed(this.error);

  @override
  List<Object> get props => [error];
}
