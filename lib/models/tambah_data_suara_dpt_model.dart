class TambahDataSuaraDptModel {
  String nik;
  String noTelp;
  String alasan;
  String idUser;
  String pathPhotoSwafoto;
  String pathPhotoRumah;
  String type;
  String hdt;
  String tkp;
  String statusPemilih;
  String username;
  String password;

  TambahDataSuaraDptModel({
    required this.nik,
    required this.noTelp,
    required this.alasan,
    required this.idUser,
    required this.pathPhotoSwafoto,
    required this.pathPhotoRumah,
    required this.type,
    required this.hdt,
    required this.tkp,
    required this.statusPemilih,
    this.username="",
    this.password="",
  });
}