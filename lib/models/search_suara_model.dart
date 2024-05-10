// To parse this JSON data, do
//
//     final searchSuaraModel = searchSuaraModelFromJson(jsonString);

import 'dart:convert';

SearchSuaraModel searchSuaraModelFromJson(String str) =>
    SearchSuaraModel.fromJson(json.decode(str));

String searchSuaraModelToJson(SearchSuaraModel data) =>
    json.encode(data.toJson());

class SearchSuaraModel {
  SearchSuaraModel({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  List<DataSearchSuara> data;

  factory SearchSuaraModel.fromJson(Map<String, dynamic> json) =>
      SearchSuaraModel(
        success: json["success"],
        message: json["message"],
        data: List<DataSearchSuara>.from(
            json["data"].map((x) => DataSearchSuara.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataSearchSuara {
  DataSearchSuara({
    required this.id,
    required this.uuid,
    required this.noKk,
    required this.nik,
    required this.nama,
    required this.tps,
    required this.swafoto,
  });

  int id;
  String uuid;
  String noKk;
  String nik;
  String nama;
  int tps;
  String swafoto;

  factory DataSearchSuara.fromJson(Map<String, dynamic> json) =>
      DataSearchSuara(
          id: json["id"],
          uuid: json["uuid"],
          noKk: json["no_kk"],
          nik: json["nik"],
          nama: json["nama"],
          tps: json["tps"],
          swafoto: json["swafoto"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "no_kk": noKk,
        "nik": nik,
        "nama": nama,
        "tps": tps,
        "swafoto": swafoto
      };
}
