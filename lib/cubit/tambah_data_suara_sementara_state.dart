part of 'tambah_data_suara_sementara_cubit.dart';

abstract class TambahDataSuaraSementaraState extends Equatable {
  const TambahDataSuaraSementaraState();

  @override
  List<Object> get props => [];
}

class TambahDataSuaraSementaraInitial extends TambahDataSuaraSementaraState {}

class TambahDataSuaraSementaraLoading extends TambahDataSuaraSementaraState {}

class TambahDataSuaraSementaraSuccess extends TambahDataSuaraSementaraState {
  final TambahDataSuaraSementaraModel tambahDataSuaraSementaraModel;

  TambahDataSuaraSementaraSuccess(
    this.tambahDataSuaraSementaraModel,
  );

  @override
  List<Object> get props => [tambahDataSuaraSementaraModel];
}

class TambahDataSuaraSementaraFailed extends TambahDataSuaraSementaraState {
  final String error;

  TambahDataSuaraSementaraFailed(this.error);

  @override
  List<Object> get props => [error];
}
