// To parse this JSON data, do
//
//     final listProvinsiModel = listProvinsiModelFromJson(jsonString);

import 'dart:convert';

ListProvinsiModel listProvinsiModelFromJson(String str) =>
    ListProvinsiModel.fromJson(json.decode(str));

String listProvinsiModelToJson(ListProvinsiModel data) =>
    json.encode(data.toJson());

class ListProvinsiModel {
  ListProvinsiModel({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  List<DataListProvinsi> data;

  factory ListProvinsiModel.fromJson(Map<String, dynamic> json) =>
      ListProvinsiModel(
        success: json["success"],
        message: json["message"],
        data: List<DataListProvinsi>.from(
            json["data"].map((x) => DataListProvinsi.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataListProvinsi {
  DataListProvinsi({
    required this.id,
    required this.value,
  });

  int id;
  String value;

  factory DataListProvinsi.fromJson(Map<String, dynamic> json) =>
      DataListProvinsi(
        id: json["id"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
      };
}
