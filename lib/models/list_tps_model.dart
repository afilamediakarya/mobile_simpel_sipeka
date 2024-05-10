// To parse this JSON data, do
//
//     final listTpsModel = listTpsModelFromJson(jsonString);

import 'dart:convert';

ListTpsModel listTpsModelFromJson(String str) =>
    ListTpsModel.fromJson(json.decode(str));

String listTpsModelToJson(ListTpsModel data) => json.encode(data.toJson());

class ListTpsModel {
  ListTpsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  List<DataListTps> data;

  factory ListTpsModel.fromJson(Map<String, dynamic> json) => ListTpsModel(
        success: json["success"],
        message: json["message"],
        data: List<DataListTps>.from(
            json["data"].map((x) => DataListTps.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataListTps {
  DataListTps({
    required this.id,
    required this.value,
    required this.idDesa,
    required this.kelurahan,
  });

  int id;
  String value;
  int idDesa;
  Kelurahan kelurahan;

  factory DataListTps.fromJson(Map<String, dynamic> json) => DataListTps(
        id: json["id"],
        value: json["value"],
        idDesa: json["id_desa"],
        kelurahan: Kelurahan.fromJson(json["kelurahan"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
        "id_desa": idDesa,
        "kelurahan": kelurahan.toJson(),
      };
}

class Kelurahan {
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

  int id;
  int kecamatanId;
  String kelurahan;
  String kdPos;
  dynamic kode;
  dynamic createdAt;
  dynamic updatedAt;
  Kecamatan kecamatan;

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
  Kecamatan({
    required this.id,
    required this.kabkotId,
    required this.kecamatan,
    this.createdAt,
    this.updatedAt,
    this.kode,
    required this.kabupaten,
  });

  int id;
  int kabkotId;
  String kecamatan;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic kode;
  Kabupaten kabupaten;

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

  int id;
  int provinsiId;
  String kabupatenKota;
  String ibukota;
  String kode;
  dynamic createdAt;
  dynamic updatedAt;
  Provinsi provinsi;

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
  Provinsi({
    required this.id,
    required this.provinsi,
    required this.ibukota,
    required this.kode,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String provinsi;
  String ibukota;
  String kode;
  dynamic createdAt;
  dynamic updatedAt;

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
