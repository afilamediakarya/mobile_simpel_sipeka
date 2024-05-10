import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:simpel/models/informasi_pribadi_model.dart';
import 'package:simpel/models/pencarian_nik_model.dart';
import 'package:simpel/models/tambah_data_suara_bukan_dpt_model.dart';
import 'package:simpel/models/tambah_data_suara_dpt_model.dart';
import 'package:simpel/models/update_dpt_model.dart';
import 'package:simpel/models/tambah_data_suara_sementara_model.dart';
import 'package:simpel/shared/shared_prefrences.dart';
import 'base_url.dart' as base_url;
import 'package:http/http.dart' as http;

class TambahSuaraServices {
  String token = SharedPreference.login.getString("token");

  String idCalon = SharedPreference.login.getString("id_calon");
  String refferal = SharedPreference.login.getString("refferal");

  String roleSuara = SharedPreference.choosedRoleSuara.getString("role");

  Future<InformasiPribadiModel> getDataInformasiPribadi(
      {required String nik}) async {
    // var url = '${base_url.Url}/suara/total-suara';
    var header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(
      Uri.parse('${base_url.Url}/suara/informasi-pribadi?nik=$nik'),
      headers: header,
    );

    var data = jsonDecode(response.body);
    debugPrint("Status Get Data Informasi Pribadi=${data['success']}");

    try {
      if (data['success'] == true) {
        InformasiPribadiModel informasiPribadiModel =
            InformasiPribadiModel.fromJson(data);

        return informasiPribadiModel;
      } else {
        throw data['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<PencarianNikModel> getDataPencarianNik({required String nik}) async {
    var url = '${base_url.Url}/suara/find-nik?nik=$nik&calon=$idCalon';
    var header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(
      Uri.parse(url),
      headers: header,
    );

    var data = jsonDecode(response.body);
    print("Status Get Pencarian Nik=${data['success']}");

    try {
      if (data['success'] == true) {
        PencarianNikModel pencarianNikModel = PencarianNikModel.fromJson(data);

        return pencarianNikModel;
      } else {
        throw data['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateDataDpt(
      {required UpdateDataDptModel dataSuara}) async {
        debugPrint("data dpt : ${dataSuara.tps}");
    var url = '${base_url.Url}/dpt/${dataSuara.uuid}';
    var header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var body = {
      'tps': dataSuara.tps,
      'nik': dataSuara.nik,
      'nama': dataSuara.nama,
      'tempat_lahir': dataSuara.tempatLahir,
      'tanggal_lahir': dataSuara.tanggalLahir,
      'jenis_kelamin': dataSuara.jenisKelamin,
      'no_kk': dataSuara.noKk,
      'status_kawin': dataSuara.statusKawin,
      'status': "DPT",
      'alamat': dataSuara.alamat,
      'kelurahan': dataSuara.kelurahan,
      'rt': dataSuara.rt,
      'rw': dataSuara.rw,
      'id_desa': dataSuara.idDesa,
    };

    var response = await http.post(Uri.parse(url), headers: header, body: body);

    var data = jsonDecode(response.body);
    debugPrint("Status Get Update data DPT=${data['success']}");

    try {
      if (data['success'] == true) {
        return true;
      } else {
        throw data['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<TambahDataSuaraSementaraModel> tambahDataSuaraSementara({
    required TambahDataSuaraSementaraModel data}) async {

    try {
      TambahDataSuaraSementaraModel tambahDataSuaraSementaraModel =
        TambahDataSuaraSementaraModel(
            nik: data.nik,
            noKK: data.noKK,
            name: data.name,
            jenisKelamin: data.jenisKelamin,
            statusPerkawinan: data.statusPerkawinan,
            tempatLahir: data.tempatLahir,
            tanggalLahir: data.tanggalLahir,
            address: data.address,
            idKelurahan: data.idKelurahan,
            kelurahan: data.kelurahan,
            rt: data.rt,
            rw: data.rw,
            tps: data.tps,);

      return tambahDataSuaraSementaraModel;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> tambahSuaraDpt(
      {required TambahDataSuaraDptModel dataSuara}) async {
    var url = '${base_url.Url}/suara/store';

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll({
      "Authorization": "Bearer $token",
      'Accept': 'application/json',
    });

    request.fields["nik_dpt"] = dataSuara.nik;
    request.fields["no_telp"] = dataSuara.noTelp;
    request.fields["alasan"] = dataSuara.alasan;
    request.fields["id_user"] = dataSuara.idUser;
    request.fields["type"] = dataSuara.type;
    request.fields["id_calon"] = idCalon;
    request.fields["refferal_invite"] = refferal;
    request.fields["hubungan_dengan_tim"] = dataSuara.hdt;
    request.fields["tingkat_kepercayaan_pemilih"] = dataSuara.tkp;
    request.fields["status_pemilih"] = dataSuara.statusPemilih;

    if (roleSuara == "pin") {
      request.fields["username"] = dataSuara.username;
      request.fields["password"] = dataSuara.password;
    }

    if ((dataSuara.pathPhotoSwafoto != "") || (dataSuara.pathPhotoRumah != "")) {
      request.files
          .add(await http.MultipartFile.fromPath("swafoto", dataSuara.pathPhotoSwafoto));
      request.files
          .add(await http.MultipartFile.fromPath("foto_rumah", dataSuara.pathPhotoRumah));
    }

    var response = await request.send();

    var responsed = await http.Response.fromStream(response);

    var data = jsonDecode(responsed.body);
    debugPrint("Status Tambah Suara DPT=${data['success']}");

    try {
      if (data['success'] == true) {
        return true;
      } else {
        throw data['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> tambahSuaraBukanDpt({
    required TambahDataSuaraBukanDptModel dataSuara
      }) async {
    var url = '${base_url.Url}/suara/store';

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll({
      "Authorization": "Bearer $token",
      'Accept': 'application/json',
    });

    request.fields["nik"] = dataSuara.nik;
    request.fields["no_kk"] = dataSuara.noKK;
    request.fields["nama"] = dataSuara.nama;
    request.fields["jenis_kelamin"] = dataSuara.jenisKelamin;
    request.fields["status_kawin"] = dataSuara.statusKawin;
    request.fields["tempat_lahir"] = dataSuara.tempatLahir;
    request.fields["tanggal_lahir"] = dataSuara.tanggalLahir;
    request.fields["no_telp"] = dataSuara.noTelp;
    request.fields["alamat"] = dataSuara.alamat;
    request.fields["id_desa"] = dataSuara.idKelurahan;
    request.fields["rt"] = dataSuara.rt;
    request.fields["rw"] = dataSuara.rw;
    request.fields["tps"] = dataSuara.tps;
    request.fields["alasan"] = dataSuara.alasan;
    request.fields["id_user"] = dataSuara.idUser;
    request.fields["type"] = dataSuara.type;
    request.fields["id_calon"] = idCalon;
    request.fields["refferal_invite"] = refferal;
    request.fields["hubungan_dengan_tim"] = dataSuara.hdt;
    request.fields["tingkat_kepercayaan_pemilih"] = dataSuara.tkp;
    request.fields["status_pemilih"] = dataSuara.statusPemilih;

    if (roleSuara == "pin") {
      request.fields["username"] = dataSuara.username;
      request.fields["password"] = dataSuara.password;
    }
    if ((dataSuara.pathPhotoSwafoto != "") || (dataSuara.pathPhotoRumah != "")) {
      request.files
          .add(await http.MultipartFile.fromPath("swafoto", dataSuara.pathPhotoSwafoto));
      request.files
          .add(await http.MultipartFile.fromPath("foto_rumah", dataSuara.pathPhotoRumah));
    }

    var response = await request.send();

    var responsed = await http.Response.fromStream(response);

    var data = jsonDecode(responsed.body);
    debugPrint("Status Tambah Suara Bukan DPT=${data['success']}");

    try {
      if (data['success'] == true) {
        return true;
      } else {
        throw "Status code = ${response.statusCode}";
      }
    } catch (e) {
      rethrow;
    }
  }
}
