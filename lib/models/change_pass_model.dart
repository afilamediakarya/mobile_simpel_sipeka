// To parse this JSON data, do
//
//     final changePassModel = changePassModelFromJson(jsonString);

import 'dart:convert';

ChangePassModel changePassModelFromJson(String str) =>
    ChangePassModel.fromJson(json.decode(str));

String changePassModelToJson(ChangePassModel data) =>
    json.encode(data.toJson());

class ChangePassModel {
  ChangePassModel({
    required this.success,
    required this.message,
  });

  bool success;
  String message;

  factory ChangePassModel.fromJson(Map<String, dynamic> json) =>
      ChangePassModel(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
