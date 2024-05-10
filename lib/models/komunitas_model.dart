// To parse this JSON data, do
//
//     final komunitasModel = komunitasModelFromJson(jsonString);

import 'dart:convert';

KomunitasModel komunitasModelFromJson(String str) => KomunitasModel.fromJson(json.decode(str));

String komunitasModelToJson(KomunitasModel data) => json.encode(data.toJson());

class KomunitasModel {
    bool success;
    String message;
    List<DataKomunitas> data;

    KomunitasModel({
        required this.success,
        required this.message,
        required this.data,
    });

    factory KomunitasModel.fromJson(Map<String, dynamic> json) => KomunitasModel(
        success: json["success"],
        message: json["message"],
        data: List<DataKomunitas>.from(json["data"].map((x) => DataKomunitas.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class DataKomunitas {
    int id;
    String value;

    DataKomunitas({
        required this.id,
        required this.value,
    });

    factory DataKomunitas.fromJson(Map<String, dynamic> json) => DataKomunitas(
        id: json["id"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
    };
}
