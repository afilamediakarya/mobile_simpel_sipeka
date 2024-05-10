part of 'confirm_photo_profile_cubit.dart';

abstract class ConfirmPhotoProfileState extends Equatable {
  const ConfirmPhotoProfileState();

  @override
  List<Object> get props => [];
}

class ConfirmPhotoProfileInitial extends ConfirmPhotoProfileState {}

class ConfirmPhotoProfileLoading extends ConfirmPhotoProfileState {}

class ConfirmPhotoProfileSuccess extends ConfirmPhotoProfileState {
  final XFile xFile;

  ConfirmPhotoProfileSuccess(
    this.xFile,
  );

  @override
  List<Object> get props => [xFile];
}

class ConfirmPhotoProfileFailed extends ConfirmPhotoProfileState {
  final String error;

  ConfirmPhotoProfileFailed(
    this.error,
  );

  @override
  List<Object> get props => [error];
}

class ConfirmPhotoProfileDelete extends ConfirmPhotoProfileState {}
