// To parse this JSON data, do
//
//     final newsModel = newsModelFromJson(jsonString);

import 'dart:convert';

NewsModel newsModelFromJson(String str) => NewsModel.fromJson(json.decode(str));

String newsModelToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel {
    bool success;
    String message;
    List<DataNews> data;

    NewsModel({
        required this.success,
        required this.message,
        required this.data,
    });

    factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        success: json["success"],
        message: json["message"],
        data: List<DataNews>.from(json["data"].map((x) => DataNews.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class DataNews {
    int id;
    String uuid;
    String link;
    String judul;
    String gambar;

    DataNews({
        required this.id,
        required this.uuid,
        required this.link,
        required this.gambar,
        required this.judul
    });

    factory DataNews.fromJson(Map<String, dynamic> json) => DataNews(
        id: json["id"],
        uuid: json["uuid"],
        link: json["link"],
        gambar: json["gambar"],
        judul: json["judul"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "link": link,
        "gambar": gambar,
        "judul": judul
    };
}
