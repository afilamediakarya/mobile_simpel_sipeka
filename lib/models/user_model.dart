// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  Data data;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
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
  Data({
    required this.id,
    required this.uuid,
    required this.username,
    required this.role,
    required this.nik,
    required this.nama,
    required this.jenisKelamin,
    required this.alamat,
    required this.refferal,
    required this.idCalon,
    required this.namaCalon,
    required this.kelurahan,
    required this.foto,
    required this.targetSuara,
    required this.kabupatenKota,
    required this.kecamatan,
    required this.idDesa,
  });

  int id;
  String uuid;
  String username;
  String role;
  String nik;
  String nama;
  String jenisKelamin;
  String alamat;
  String refferal;
  int idCalon;
  String namaCalon;
  String foto;
  dynamic targetSuara;
  String kelurahan;
  String kecamatan;
  String kabupatenKota;
  int idDesa;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        uuid: json["uuid"],
        username: json["username"],
        role: json["role"],
        nik: json["nik"],
        nama: json["nama"],
        jenisKelamin: json["jenis_kelamin"] ?? "",
        alamat: json["alamat"],
        refferal: json["refferal"],
        idCalon: json["id_calon"],
        namaCalon: json["nama_calon"],
        targetSuara: json["target_suara"] ?? 0,
        kelurahan: json["kelurahan"] ?? "",
        idDesa: json["id_desa"] ?? 0,
        kecamatan: json["kecamatan"] ?? "",
        kabupatenKota: json["kabupaten_kota"] ?? "",
        foto: json["foto"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "username": username,
        "role": role,
        "nik": nik,
        "nama": nama,
        "jenis_kelamin": jenisKelamin,
        "alamat": alamat,
        "target_suara": targetSuara,
        "refferal": refferal,
        "id_calon": idCalon,
        "nama_calon": namaCalon,
        "kelurahan": kelurahan,
        "id_desa": idDesa,
        "kecamatan": kecamatan,
        "kabupaten_kota": kabupatenKota,
        "foto": foto
      };
}
