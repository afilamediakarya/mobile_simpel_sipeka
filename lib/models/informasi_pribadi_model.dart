// To parse this JSON data, do
//
//     final informasiPribadiModel = informasiPribadiModelFromJson(jsonString);

import 'dart:convert';

InformasiPribadiModel informasiPribadiModelFromJson(String str) =>
    InformasiPribadiModel.fromJson(json.decode(str));

String informasiPribadiModelToJson(InformasiPribadiModel data) =>
    json.encode(data.toJson());

class InformasiPribadiModel {
  InformasiPribadiModel({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  Data data;
  String message;

  factory InformasiPribadiModel.fromJson(Map<String, dynamic> json) =>
      InformasiPribadiModel(
        success: json["success"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "message": message,
      };
}

class Data {
  Data({
    required this.id,
    required this.nama,
    required this.nik,
    required this.jenisKelamin,
    required this.statusPernikahan,
    required this.ttl,
    required this.alamat,
    required this.kecamatan,
    required this.kelurahan,
    required this.tps,
    required this.rw,
    required this.rt,
    required this.noTelp,
  });

  int id;
  String nama;
  String nik;
  String jenisKelamin;
  String statusPernikahan;
  String ttl;
  String alamat;
  String kecamatan;
  String kelurahan;
  String tps;
  String rw;
  String rt;
  String noTelp;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        nama: json["nama"],
        nik: json["nik"],
        jenisKelamin: json["jenis_kelamin"],
        statusPernikahan: json["status_pernikahan"],
        ttl: json["ttl"],
        alamat: json["alamat"],
        kecamatan: json["kecamatan"],
        kelurahan: json["kelurahan"],
        tps: json["tps"],
        rw: json["rw"],
        rt: json["rt"],
        noTelp: json["no_telp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "nik": nik,
        "jenis_kelamin": jenisKelamin,
        "status_pernikahan": statusPernikahan,
        "ttl": ttl,
        "alamat": alamat,
        "kecamatan": kecamatan,
        "kelurahan": kelurahan,
        "tps": tps,
        "rw": rw,
        "rt": rt,
        "no_telp": noTelp,
      };
}
