import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';

part 'confirm_photo_profile_state.dart';

class ConfirmPhotoProfileCubit extends Cubit<ConfirmPhotoProfileState> {
  ConfirmPhotoProfileCubit() : super(ConfirmPhotoProfileInitial());

  void getPhotoProfileFile({required XFile file}) async {
    try {
      emit(ConfirmPhotoProfileLoading());

      emit(ConfirmPhotoProfileSuccess(file));
    } catch (e) {
      emit(ConfirmPhotoProfileFailed("Gagal mengambil gambar"));
    }
  }

  void deletePicture() {
    emit(ConfirmPhotoProfileDelete());
  }
}
