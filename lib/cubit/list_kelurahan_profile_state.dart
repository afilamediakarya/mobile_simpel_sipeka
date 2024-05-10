part of 'list_kelurahan_profile_cubit.dart';

abstract class ListKelurahanProfileState extends Equatable {
  const ListKelurahanProfileState();

  @override
  List<Object> get props => [];
}

class ListKelurahanProfileInitial extends ListKelurahanProfileState {}

class ListKelurahanProfileLoading extends ListKelurahanProfileState {}

class ListKelurahanProfileSuccess extends ListKelurahanProfileState {
  final List listKelurahan;

  ListKelurahanProfileSuccess(this.listKelurahan);

  @override
  List<Object> get props => [listKelurahan];
}

class ListKelurahanProfileFailed extends ListKelurahanProfileState {
  final String error;

  ListKelurahanProfileFailed(this.error);

  @override
  List<Object> get props => [error];
}
