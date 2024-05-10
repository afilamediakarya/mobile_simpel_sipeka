// To parse this JSON data, do
//
//     final pencarianNikModel = pencarianNikModelFromJson(jsonString);

import 'dart:convert';

PencarianNikModel pencarianNikModelFromJson(String str) =>
    PencarianNikModel.fromJson(json.decode(str));

String pencarianNikModelToJson(PencarianNikModel data) =>
    json.encode(data.toJson());

class PencarianNikModel {
  bool success;
  String message;
  Data data;

  PencarianNikModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory PencarianNikModel.fromJson(Map<String, dynamic> json) =>
      PencarianNikModel(
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
  String nik;
  String noKk;
  String nama;
  String jenisKelamin;
  String alamat;
  String statusKawin;
  String tempatLahir;
  String tanggalLahir;
  String tps;
  String rt;
  String rw;
  int idDesa;
  String type;
  String? hdt;
  String? tkp;
  String? statusPemilih;
  Kelurahan kelurahan;

  Data({
    required this.id,
    required this.uuid,
    required this.nik,
    required this.noKk,
    required this.nama,
    required this.jenisKelamin,
    required this.alamat,
    required this.statusKawin,
    required this.tempatLahir,
    required this.tanggalLahir,
    required this.tps,
    required this.rt,
    required this.rw,
    required this.idDesa,
    required this.type,
    required this.kelurahan,
    this.hdt,
    this.tkp,
    this.statusPemilih
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        uuid: json["uuid"],
        nik: json["nik"],
        noKk: json["no_kk"],
        nama: json["nama"],
        jenisKelamin: json["jenis_kelamin"],
        alamat: json["alamat"],
        statusKawin: json["status_kawin"],
        tempatLahir: json["tempat_lahir"],
        tanggalLahir: json["tanggal_lahir"],
        tps: json["tps"],
        rt: json["rt"],
        rw: json["rw"],
        idDesa: json["id_desa"],
        type: json["type"],
        hdt: json["hubungan_dengan_tim"] ?? "-",
        tkp: json["tingkat_kepercayaan_pemilih"] ?? "0",
        statusPemilih: json["status_pemilih"] ?? "-",
        kelurahan: Kelurahan.fromJson(json["kelurahan"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "nik": nik,
        "no_kk": noKk,
        "nama": nama,
        "jenis_kelamin": jenisKelamin,
        "alamat": alamat,
        "status_kawin": statusKawin,
        "tempat_lahir": tempatLahir,
        "tanggal_lahir": tanggalLahir,
        "tps": tps,
        "rt": rt,
        "rw": rw,
        "id_desa": idDesa,
        "type": type,
        "hubungan_dengan_tim": hdt,
        "tingkat_kepercayaan_pemilih": tkp,
        "status_pemilih": statusPemilih,
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
