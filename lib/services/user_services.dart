// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:simpel/models/user_model.dart';
import 'package:simpel/shared/shared_prefrences.dart';
import 'base_url.dart' as base_url;

class UserServices {
  String token = SharedPreference.login.getString("token");
  String uuid = SharedPreference.login.getString("uuid");

  Future<UserModel> getDataUser({required String uuid}) async {
    var url = '${base_url.Url}/profile/current-user/$uuid';
    var header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(
      Uri.parse(url),
      headers: header,
    );

    var data = jsonDecode(response.body);
    debugPrint("Status Get Data User=${data['success']}");

    try {
      if (data['success'] == true) {
        UserModel userModel = UserModel.fromJson(data);

        SharedPreference.login
            ?.setString("id_calon", userModel.data.idCalon.toString());
        SharedPreference.login?.setString("refferal", userModel.data.refferal);

        return userModel;
      } else {
        throw data['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> changeProfile({
    required String nik,
    required String nama,
    required String jenisKelamin,
    required String alamat,
    required String idDesa,
    required String foto,
  }) async {
    var url = '${base_url.Url}/profile/ubah-profile?uuid=$uuid';

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll({
      "Authorization": "Bearer $token",
      'Accept': 'application/json',
    });

    request.fields["nik"] = nik;
    request.fields["nama"] = nama;
    request.fields["jenis_kelamin"] = jenisKelamin;
    request.fields["alamat"] = alamat;
    request.fields["id_desa"] = idDesa;

    if (foto != "") {
      request.files.add(await http.MultipartFile.fromPath("foto", foto));
    }

    var response = await request.send();

    var responsed = await http.Response.fromStream(response);

    var data = jsonDecode(responsed.body);
    debugPrint("Status Edit Profile=${data['success']}");

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


  Future<bool> changePassword({
    required String oldPass,
    required String newPass,
  }) async {
    var url = '${base_url.Url}/ubah-password?user=$uuid';
    var header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var body = {
      'password_lama': oldPass,
      'password_baru_confirmed': newPass,
    };

    var response = await http.post(
      Uri.parse(url),
      headers: header,
      body: body,
    );

    var data = jsonDecode(response.body);
    debugPrint("Status Change Pass=${data['success']}");

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
}
