import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';

part 'confirm_photo_rumah_state.dart';

class ConfirmPhotoRumahCubit extends Cubit<ConfirmPhotoRumahState> {
  ConfirmPhotoRumahCubit() : super(ConfirmPhotoRumahInitial());

  void getPhotoRumahFile({required XFile file}) async {
    try {
      emit(ConfirmPhotoRumahLoading());

      emit(ConfirmPhotoRumahSuccess(file));
    } catch (e) {
      emit(ConfirmPhotoRumahFailed("Gagal mengambil gambar"));
    }
  }

  void deletePicture() {
    emit(ConfirmPhotoRumahDelete());
  }
}
