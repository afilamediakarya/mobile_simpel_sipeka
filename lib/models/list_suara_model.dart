// To parse this JSON data, do
//
//     final listSuaraModel = listSuaraModelFromJson(jsonString);

import 'dart:convert';

ListSuaraModel listSuaraModelFromJson(String str) =>
    ListSuaraModel.fromJson(json.decode(str));

String listSuaraModelToJson(ListSuaraModel data) => json.encode(data.toJson());

class ListSuaraModel {
  bool success;
  String message;
  Data data;

  ListSuaraModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ListSuaraModel.fromJson(Map<String, dynamic> json) => ListSuaraModel(
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
  int currentPage;
  List<DataListSuara> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  Data({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: List<DataListSuara>.from(
            json["data"].map((x) => DataListSuara.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class DataListSuara {
  int id;
  String uuid;
  String nama;
  String nik;
  int tps;
  int idDesa;
  String swafoto;
  Kelurahan kelurahan;

  DataListSuara({
    required this.id,
    required this.uuid,
    required this.nama,
    required this.nik,
    required this.tps,
    required this.idDesa,
    required this.swafoto,
    required this.kelurahan,
  });

  factory DataListSuara.fromJson(Map<String, dynamic> json) => DataListSuara(
        id: json["id"],
        uuid: json["uuid"],
        nama: json["nama"],
        nik: json["nik"],
        tps: json["tps"],
        idDesa: json["id_desa"],
        swafoto: json["swafoto"],
        kelurahan: Kelurahan.fromJson(json["kelurahan"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "nama": nama,
        "nik": nik,
        "tps": tps,
        "id_desa": idDesa,
        "swafoto": swafoto,
        "kelurahan": kelurahan.toJson(),
      };
}

class Kelurahan {
  int id;
  int kecamatanId;
  String kelurahan;
  String kdPos;
  dynamic kode;
  dynamic createdAt;
  dynamic updatedAt;
  Kecamatan kecamatan;

  Kelurahan({
    required this.id,
    required this.kecamatanId,
    required this.kelurahan,
    required this.kdPos,
    this.kode,
    this.createdAt,
    this.updatedAt,
    required this.kecamatan,
  });

  factory Kelurahan.fromJson(Map<String, dynamic> json) => Kelurahan(
        id: json["id"],
        kecamatanId: json["kecamatan_id"],
        kelurahan: json["kelurahan"],
        kdPos: json["kd_pos"],
        kode: json["kode"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        kecamatan: Kecamatan.fromJson(json["kecamatan"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kecamatan_id": kecamatanId,
        "kelurahan": kelurahan,
        "kd_pos": kdPos,
        "kode": kode,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "kecamatan": kecamatan.toJson(),
      };
}

class Kecamatan {
  int id;
  int kabkotId;
  String kecamatan;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic kode;
  Kabupaten kabupaten;

  Kecamatan({
    required this.id,
    required this.kabkotId,
    required this.kecamatan,
    this.createdAt,
    this.updatedAt,
    this.kode,
    required this.kabupaten,
  });

  factory Kecamatan.fromJson(Map<String, dynamic> json) => Kecamatan(
        id: json["id"],
        kabkotId: json["kabkot_id"],
        kecamatan: json["kecamatan"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        kode: json["kode"],
        kabupaten: Kabupaten.fromJson(json["kabupaten"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kabkot_id": kabkotId,
        "kecamatan": kecamatan,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "kode": kode,
        "kabupaten": kabupaten.toJson(),
      };
}

class Kabupaten {
  int id;
  int provinsiId;
  String kabupatenKota;
  String ibukota;
  String kode;
  dynamic createdAt;
  dynamic updatedAt;
  Provinsi provinsi;

  Kabupaten({
    required this.id,
    required this.provinsiId,
    required this.kabupatenKota,
    required this.ibukota,
    required this.kode,
    this.createdAt,
    this.updatedAt,
    required this.provinsi,
  });

  factory Kabupaten.fromJson(Map<String, dynamic> json) => Kabupaten(
        id: json["id"],
        provinsiId: json["provinsi_id"],
        kabupatenKota: json["kabupaten_kota"],
        ibukota: json["ibukota"],
        kode: json["kode"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        provinsi: Provinsi.fromJson(json["provinsi"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "provinsi_id": provinsiId,
        "kabupaten_kota": kabupatenKota,
        "ibukota": ibukota,
        "kode": kode,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "provinsi": provinsi.toJson(),
      };
}

class Provinsi {
  int id;
  String provinsi;
  String ibukota;
  String kode;
  dynamic createdAt;
  dynamic updatedAt;

  Provinsi({
    required this.id,
    required this.provinsi,
    required this.ibukota,
    required this.kode,
    this.createdAt,
    this.updatedAt,
  });

  factory Provinsi.fromJson(Map<String, dynamic> json) => Provinsi(
        id: json["id"],
        provinsi: json["provinsi"],
        ibukota: json["ibukota"],
        kode: json["kode"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "provinsi": provinsi,
        "ibukota": ibukota,
        "kode": kode,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class Link {
  String? url;
  String label;
  bool active;

  Link({
    this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
