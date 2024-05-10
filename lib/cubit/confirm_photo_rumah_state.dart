part of 'confirm_photo_rumah_cubit.dart';

abstract class ConfirmPhotoRumahState extends Equatable {
  const ConfirmPhotoRumahState();

  @override
  List<Object> get props => [];
}

class ConfirmPhotoRumahInitial extends ConfirmPhotoRumahState {}

class ConfirmPhotoRumahLoading extends ConfirmPhotoRumahState {}

class ConfirmPhotoRumahSuccess extends ConfirmPhotoRumahState {
  final XFile xFile;

  ConfirmPhotoRumahSuccess(
    this.xFile,
  );

  @override
  List<Object> get props => [xFile];
}

class ConfirmPhotoRumahFailed extends ConfirmPhotoRumahState {
  final String error;

  ConfirmPhotoRumahFailed(
    this.error,
  );

  @override
  List<Object> get props => [error];
}

class ConfirmPhotoRumahDelete extends ConfirmPhotoRumahState {}
