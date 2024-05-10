part of 'confirm_photo_swafoto_cubit.dart';

abstract class ConfirmPhotoSwafotoState extends Equatable {
  const ConfirmPhotoSwafotoState();

  @override
  List<Object> get props => [];
}

class ConfirmPhotoSwafotoInitial extends ConfirmPhotoSwafotoState {}

class ConfirmPhotoSwafotoLoading extends ConfirmPhotoSwafotoState {}

class ConfirmPhotoSwafotoSuccess extends ConfirmPhotoSwafotoState {
  final XFile xFile;

  ConfirmPhotoSwafotoSuccess(
    this.xFile,
  );

  @override
  List<Object> get props => [xFile];
}

class ConfirmPhotoSwafotoFailed extends ConfirmPhotoSwafotoState {
  final String error;

  ConfirmPhotoSwafotoFailed(
    this.error,
  );

  @override
  List<Object> get props => [error];
}

class ConfirmPhotoSwafotoDelete extends ConfirmPhotoSwafotoState {}
