// To parse this JSON data, do
//
//     final kandidatModel = kandidatModelFromJson(jsonString);

import 'dart:convert';

KandidatModel kandidatModelFromJson(String str) =>
    KandidatModel.fromJson(json.decode(str));

String kandidatModelToJson(KandidatModel data) => json.encode(data.toJson());

class KandidatModel {
  bool success;
  String message;
  Data data;

  KandidatModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory KandidatModel.fromJson(Map<String, dynamic> json) => KandidatModel(
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
  String nama;
  String deskripsi;
  String foto;
  DateTime createdAt;
  DateTime updatedAt;
  int userInsert;
  int userUpdate;
  List<Dapil> dapil;

  Data({
    required this.id,
    required this.uuid,
    required this.nama,
    required this.deskripsi,
    required this.foto,
    required this.createdAt,
    required this.updatedAt,
    required this.userInsert,
    required this.userUpdate,
    required this.dapil,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        uuid: json["uuid"],
        nama: json["nama"],
        deskripsi: json["deskripsi"],
        foto: json["foto"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        userInsert: json["user_insert"],
        userUpdate: json["user_update"],
        dapil: List<Dapil>.from(json["dapil"].map((x) => Dapil.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "nama": nama,
        "deskripsi": deskripsi,
        "foto": foto,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user_insert": userInsert,
        "user_update": userUpdate,
        "dapil": List<dynamic>.from(dapil.map((x) => x.toJson())),
      };
}

class Dapil {
  int id;
  int idCalon;
  int idKecamatan;
  String dapil;
  int kabkotId;

  Dapil({
    required this.id,
    required this.idCalon,
    required this.idKecamatan,
    required this.dapil,
    required this.kabkotId,
  });

  factory Dapil.fromJson(Map<String, dynamic> json) => Dapil(
        id: json["id"],
        idCalon: json["id_calon"],
        idKecamatan: json["id_kecamatan"],
        dapil: json["dapil"],
        kabkotId: json["kabkot_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_calon": idCalon,
        "id_kecamatan": idKecamatan,
        "dapil": dapil,
        "kabkot_id": kabkotId,
      };
}
