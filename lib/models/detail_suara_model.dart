// To parse this JSON data, do
//
//     final detailSuaraModel = detailSuaraModelFromJson(jsonString);

import 'dart:convert';

DetailSuaraModel detailSuaraModelFromJson(String str) =>
    DetailSuaraModel.fromJson(json.decode(str));

String detailSuaraModelToJson(DetailSuaraModel data) =>
    json.encode(data.toJson());

class DetailSuaraModel {
  bool success;
  String message;
  Data data;

  DetailSuaraModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory DetailSuaraModel.fromJson(Map<String, dynamic> json) =>
      DetailSuaraModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  int id;
  String uuid;
  String noKk;
  String nik;
  String nama;
  String tempatLahir;
  String tanggalLahir;
  String statusKawin;
  String jenisKelamin;
  String alamat;
  String rt;
  int idKomunitas;
  String rw;
  int status;
  String refferalInvite;
  int idUser;
  int tps;
  int idDesa;
  int idKecamatan;
  int idKabupaten;
  DateTime createdAt;
  DateTime updatedAt;
  String alasan;
  int userInsert;
  int userUpdate;
  String noTelp;
  String swafoto;
  int idCalon;
  dynamic fotoRumah;
  String swafotoPath;
  Kelurahan kelurahan;
  String? hdt;
  String? statusPemilih;

  Data({
    required this.id,
    required this.uuid,
    required this.noKk,
    required this.nik,
    required this.nama,
    required this.tempatLahir,
    required this.tanggalLahir,
    required this.statusKawin,
    required this.jenisKelamin,
    required this.alamat,
    required this.rt,
    required this.idKomunitas,
    required this.rw,
    required this.status,
    required this.refferalInvite,
    required this.idUser,
    required this.tps,
    required this.idDesa,
    required this.idKecamatan,
    required this.idKabupaten,
    required this.createdAt,
    required this.updatedAt,
    required this.alasan,
    required this.userInsert,
    required this.userUpdate,
    required this.noTelp,
    required this.swafoto,
    required this.idCalon,
    this.fotoRumah,
    required this.swafotoPath,
    required this.kelurahan,
    required this.hdt,
    required this.statusPemilih,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        uuid: json["uuid"],
        noKk: json["no_kk"],
        nik: json["nik"],
        nama: json["nama"],
        tempatLahir: json["tempat_lahir"],
        tanggalLahir: json["tanggal_lahir"],
        statusKawin: json["status_kawin"],
        jenisKelamin: json["jenis_kelamin"],
        alamat: json["alamat"],
        rt: json["rt"],
        idKomunitas: json["id_komunitas"],
        rw: json["rw"],
        status: json["status"],
        refferalInvite: json["refferal_invite"],
        idUser: json["id_user"],
        tps: json["tps"],
        idDesa: json["id_desa"],
        idKecamatan: json["id_kecamatan"],
        idKabupaten: json["id_kabupaten"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        alasan: json["alasan"],
        userInsert: json["user_insert"],
        userUpdate: json["user_update"],
        noTelp: json["no_telp"],
        swafoto: json["swafoto"],
        idCalon: json["id_calon"],
        fotoRumah: json["foto_rumah"],
        swafotoPath: json["swafoto_path"],
        hdt: json["hubungan_dengan_tim"] ?? "-",
        statusPemilih: json["status_pemilih"] ?? "-",
        kelurahan: Kelurahan.fromJson(json["kelurahan"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "no_kk": noKk,
        "nik": nik,
        "nama": nama,
        "tempat_lahir": tempatLahir,
        "tanggal_lahir": tanggalLahir,
        "status_kawin": statusKawin,
        "jenis_kelamin": jenisKelamin,
        "alamat": alamat,
        "rt": rt,
        "id_komunitas": idKomunitas,
        "rw": rw,
        "status": status,
        "refferal_invite": refferalInvite,
        "id_user": idUser,
        "tps": tps,
        "id_desa": idDesa,
        "id_kecamatan": idKecamatan,
        "id_kabupaten": idKabupaten,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "alasan": alasan,
        "user_insert": userInsert,
        "user_update": userUpdate,
        "no_telp": noTelp,
        "swafoto": swafoto,
        "id_calon": idCalon,
        "foto_rumah": fotoRumah,
        "swafoto_path": swafotoPath,
        "kelurahan": kelurahan.toJson(),
      };
}

class Kelurahan {
  int id;
  int kecamatanId;
  String kelurahan;
  String kdPos;
  dynamic kode;
  dynamic createdAt;
  dynamic updatedAt;
  Kecamatan kecamatan;

  Kelurahan({
    required this.id,
    required this.kecamatanId,
    required this.kelurahan,
    required this.kdPos,
    this.kode,
    this.createdAt,
    this.updatedAt,
    required this.kecamatan,
  });

  factory Kelurahan.fromJson(Map<String, dynamic> json) => Kelurahan(
        id: json["id"],
        kecamatanId: json["kecamatan_id"],
        kelurahan: json["kelurahan"],
        kdPos: json["kd_pos"],
        kode: json["kode"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        kecamatan: Kecamatan.fromJson(json["kecamatan"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kecamatan_id": kecamatanId,
        "kelurahan": kelurahan,
        "kd_pos": kdPos,
        "kode": kode,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "kecamatan": kecamatan.toJson(),
      };
}

class Kecamatan {
  int id;
  int kabkotId;
  String kecamatan;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic kode;
  Kabupaten kabupaten;

  Kecamatan({
    required this.id,
    required this.kabkotId,
    required this.kecamatan,
    this.createdAt,
    this.updatedAt,
    this.kode,
    required this.kabupaten,
  });

  factory Kecamatan.fromJson(Map<String, dynamic> json) => Kecamatan(
        id: json["id"],
        kabkotId: json["kabkot_id"],
        kecamatan: json["kecamatan"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        kode: json["kode"],
        kabupaten: Kabupaten.fromJson(json["kabupaten"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kabkot_id": kabkotId,
        "kecamatan": kecamatan,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "kode": kode,
        "kabupaten": kabupaten.toJson(),
      };
}

class Kabupaten {
  int id;
  int provinsiId;
  String kabupatenKota;
  String ibukota;
  String kode;
  dynamic createdAt;
  dynamic updatedAt;
  Provinsi provinsi;

  Kabupaten({
    required this.id,
    required this.provinsiId,
    required this.kabupatenKota,
    required this.ibukota,
    required this.kode,
    this.createdAt,
    this.updatedAt,
    required this.provinsi,
  });

  factory Kabupaten.fromJson(Map<String, dynamic> json) => Kabupaten(
        id: json["id"],
        provinsiId: json["provinsi_id"],
        kabupatenKota: json["kabupaten_kota"],
        ibukota: json["ibukota"],
        kode: json["kode"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        provinsi: Provinsi.fromJson(json["provinsi"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "provinsi_id": provinsiId,
        "kabupaten_kota": kabupatenKota,
        "ibukota": ibukota,
        "kode": kode,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "provinsi": provinsi.toJson(),
      };
}

class Provinsi {
  int id;
  String provinsi;
  String ibukota;
  String kode;
  dynamic createdAt;
  dynamic updatedAt;

  Provinsi({
    required this.id,
    required this.provinsi,
    required this.ibukota,
    required this.kode,
    this.createdAt,
    this.updatedAt,
  });

  factory Provinsi.fromJson(Map<String, dynamic> json) => Provinsi(
        id: json["id"],
        provinsi: json["provinsi"],
        ibukota: json["ibukota"],
        kode: json["kode"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "provinsi": provinsi,
        "ibukota": ibukota,
        "kode": kode,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
