// To parse this JSON data, do
//
//     final totalSuaraModel = totalSuaraModelFromJson(jsonString);

import 'dart:convert';

TotalSuaraModel totalSuaraModelFromJson(String str) =>
    TotalSuaraModel.fromJson(json.decode(str));

String totalSuaraModelToJson(TotalSuaraModel data) =>
    json.encode(data.toJson());

class TotalSuaraModel {
  TotalSuaraModel({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  Data data;

  factory TotalSuaraModel.fromJson(Map<String, dynamic> json) =>
      TotalSuaraModel(
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
    required this.jumlahSuara,
    required this.totalSuaraKomunitas,
  });

  int jumlahSuara;
  int totalSuaraKomunitas;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        jumlahSuara: json["jumlah_suara"],
        totalSuaraKomunitas: json["total_suara_komunitas"],
      );

  Map<String, dynamic> toJson() => {
        "jumlah_suara": jumlahSuara,
        "total_suara_komunitas": totalSuaraKomunitas,
      };
}
