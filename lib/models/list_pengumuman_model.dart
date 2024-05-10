import 'dart:convert';

ListPengumumanModel listPengumumanModelFromJson(String str) => ListPengumumanModel.fromJson(json.decode(str));

String listPengumumanModelToJson(ListPengumumanModel data) => json.encode(data.toJson());

class ListPengumumanModel {
    bool success;
    String message;
    List<DataPengumuman> data;

    ListPengumumanModel({
        required this.success,
        required this.message,
        required this.data,
    });

    factory ListPengumumanModel.fromJson(Map<String, dynamic> json) => ListPengumumanModel(
        success: json["success"],
        message: json["message"],
        data: List<DataPengumuman>.from(json["data"].map((x) => DataPengumuman.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class DataPengumuman {
    int id;
    String uuid;
    String judul;
    String deskripsi;
    DateTime tanggalAwal;
    DateTime tanggalAkhir;
    int idCalon;
    DateTime createdAt;
    DateTime updatedAt;

    DataPengumuman({
      required this.id,
      required this.uuid,
      required this.judul,
      required this.deskripsi,
      required this.tanggalAwal,
      required this.tanggalAkhir,
      required this.idCalon,
      required this.createdAt,
      required this.updatedAt,
    });

    factory DataPengumuman.fromJson(Map<String, dynamic> json) => DataPengumuman(
        id: json["id"],
        uuid: json["uuid"],
        judul: json["judul"],
        deskripsi: json["deskripsi"],
        tanggalAwal: DateTime.parse(json["tanggal_awal"]),
        tanggalAkhir: DateTime.parse(json["tanggal_akhir"]),
        idCalon: json["id_calon"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "judul": judul,
        "deskripsi": deskripsi,
        "tanggal_awal": "${tanggalAwal.year.toString().padLeft(4, '0')}-${tanggalAwal.month.toString().padLeft(2, '0')}-${tanggalAwal.day.toString().padLeft(2, '0')}",
        "tanggal_akhir": "${tanggalAkhir.year.toString().padLeft(4, '0')}-${tanggalAkhir.month.toString().padLeft(2, '0')}-${tanggalAkhir.day.toString().padLeft(2, '0')}",
        "id_calon": idCalon,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
