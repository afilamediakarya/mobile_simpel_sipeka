// To parse this JSON data, do
//
//     final listKelurahanModel = listKelurahanModelFromJson(jsonString);

import 'dart:convert';

ListKelurahanModel listKelurahanModelFromJson(String str) =>
    ListKelurahanModel.fromJson(json.decode(str));

String listKelurahanModelToJson(ListKelurahanModel data) =>
    json.encode(data.toJson());

class ListKelurahanModel {
  ListKelurahanModel({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  List<DataListKelurahan> data;

  factory ListKelurahanModel.fromJson(Map<String, dynamic> json) =>
      ListKelurahanModel(
        success: json["success"],
        message: json["message"],
        data: List<DataListKelurahan>.from(
            json["data"].map((x) => DataListKelurahan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataListKelurahan {
  DataListKelurahan({
    required this.id,
    required this.text,
    this.kecamatan,
  });

  int id;
  String text;
  dynamic kecamatan;

  factory DataListKelurahan.fromJson(Map<String, dynamic> json) =>
      DataListKelurahan(
        id: json["id"],
        text: json["text"],
        kecamatan: json["kecamatan"] ?? "-",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "kecamatan": kecamatan,
      };
}
