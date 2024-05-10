// To parse this JSON data, do
//
//     final listKelurahanModel = listKelurahanModelFromJson(jsonString);

import 'dart:convert';

ListKelurahanModel listKelurahanModelFromJson(String str) =>
    ListKelurahanModel.fromJson(json.decode(str));

String listKelurahanModelToJson(ListKelurahanModel data) =>
    json.encode(data.toJson());

class ListKelurahanModel {
  bool success;
  String message;
  List<DataListKelurahanProfile> data;

  ListKelurahanModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ListKelurahanModel.fromJson(Map<String, dynamic> json) =>
      ListKelurahanModel(
        success: json["success"],
        message: json["message"],
        data: List<DataListKelurahanProfile>.from(
            json["data"].map((x) => DataListKelurahanProfile.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataListKelurahanProfile {
  int id;
  String text;

  DataListKelurahanProfile({
    required this.id,
    required this.text,
  });

  factory DataListKelurahanProfile.fromJson(Map<String, dynamic> json) =>
      DataListKelurahanProfile(
        id: json["id"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
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
