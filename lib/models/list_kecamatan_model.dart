// To parse this JSON data, do
//
//     final listKecamatanModel = listKecamatanModelFromJson(jsonString);

import 'dart:convert';

ListKecamatanModel listKecamatanModelFromJson(String str) =>
    ListKecamatanModel.fromJson(json.decode(str));

String listKecamatanModelToJson(ListKecamatanModel data) =>
    json.encode(data.toJson());

class ListKecamatanModel {
  ListKecamatanModel({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  List<DataListKecamatan> data;

  factory ListKecamatanModel.fromJson(Map<String, dynamic> json) =>
      ListKecamatanModel(
        success: json["success"],
        message: json["message"],
        data: List<DataListKecamatan>.from(
            json["data"].map((x) => DataListKecamatan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataListKecamatan {
  DataListKecamatan({
    required this.id,
    required this.text,
    required this.kabkotId,
  });

  int id;
  String text;
  int kabkotId;

  factory DataListKecamatan.fromJson(Map<String, dynamic> json) =>
      DataListKecamatan(
        id: json["id"],
        text: json["text"],
        kabkotId: json["kabkot_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "kabkot_id": kabkotId,
      };
}
