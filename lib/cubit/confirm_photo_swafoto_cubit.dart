import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';

part 'confirm_photo_swafoto_state.dart';

class ConfirmPhotoSwafotoCubit extends Cubit<ConfirmPhotoSwafotoState> {
  ConfirmPhotoSwafotoCubit() : super(ConfirmPhotoSwafotoInitial());

  void getPhotoSwafotoFile({required XFile file}) async {
    try {
      emit(ConfirmPhotoSwafotoLoading());

      emit(ConfirmPhotoSwafotoSuccess(file));
    } catch (e) {
      emit(ConfirmPhotoSwafotoFailed("Gagal mengambil gambar"));
    }
  }

  void deletePicture() {
    emit(ConfirmPhotoSwafotoDelete());
  }
}
