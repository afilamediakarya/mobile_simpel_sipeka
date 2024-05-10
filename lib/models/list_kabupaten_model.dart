// To parse this JSON data, do
//
//     final listKabupatenModel = listKabupatenModelFromJson(jsonString);

import 'dart:convert';

ListKabupatenModel listKabupatenModelFromJson(String str) =>
    ListKabupatenModel.fromJson(json.decode(str));

String listKabupatenModelToJson(ListKabupatenModel data) =>
    json.encode(data.toJson());

class ListKabupatenModel {
  ListKabupatenModel({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  List<DataListKabupaten> data;

  factory ListKabupatenModel.fromJson(Map<String, dynamic> json) =>
      ListKabupatenModel(
        success: json["success"],
        message: json["message"],
        data: List<DataListKabupaten>.from(
            json["data"].map((x) => DataListKabupaten.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataListKabupaten {
  DataListKabupaten({
    required this.id,
    required this.value,
    required this.provinsiId,
  });

  int id;
  String value;
  int provinsiId;

  factory DataListKabupaten.fromJson(Map<String, dynamic> json) =>
      DataListKabupaten(
        id: json["id"],
        value: json["value"],
        provinsiId: json["provinsi_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
        "provinsi_id": provinsiId,
      };
}
