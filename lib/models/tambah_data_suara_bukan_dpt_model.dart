class TambahDataSuaraBukanDptModel {
  String nik;
  String noKK;
  String nama;
  String jenisKelamin;
  String statusKawin;
  String tempatLahir;
  String tanggalLahir;
  String noTelp;
  String alamat;
  String idKelurahan;
  String rt;
  String rw;
  String tps;
  String alasan;
  String idUser;
  String pathPhotoSwafoto;
  String pathPhotoRumah;
  String type;
  String username;
  String password;
  String hdt;
  String tkp;
  String statusPemilih;

  TambahDataSuaraBukanDptModel({
    required this.nik,
    required this.noKK,
    required this.nama,
    required this.jenisKelamin,
    required this.statusKawin,
    required this.tempatLahir,
    required this.tanggalLahir,
    required this.noTelp,
    required this.alamat,
    required this.idKelurahan,
    required this.rt,
    required this.rw,
    required this.tps,
    required this.alasan,
    required this.idUser,
    required this.pathPhotoSwafoto,
    required this.pathPhotoRumah,
    required this.type,
    this.username="",
    this.password="",
    required this.hdt,
    required this.tkp,
    required this.statusPemilih
  });
}