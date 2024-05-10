// To parse this JSON data, do
//
//     final loginUserModel = loginUserModelFromJson(jsonString);

import 'dart:convert';

LoginUserModel loginUserModelFromJson(String str) =>
    LoginUserModel.fromJson(json.decode(str));

String loginUserModelToJson(LoginUserModel data) => json.encode(data.toJson());

class LoginUserModel {
  LoginUserModel({
    required this.success,
    required this.data,
    required this.message,
  });

  bool success;
  Data data;
  String message;

  factory LoginUserModel.fromJson(Map<String, dynamic> json) => LoginUserModel(
        success: json["success"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "message": message,
      };
}

class Data {
  Data({
    required this.token,
    required this.name,
    required this.uuid,
    required this.id,
  });

  String token;
  String name;
  String uuid;
  int id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        name: json["name"],
        uuid: json["uuid"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "name": name,
        "uuid": uuid,
        "id": id,
      };
}
