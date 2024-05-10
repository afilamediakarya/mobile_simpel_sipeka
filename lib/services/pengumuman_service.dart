import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:simpel/models/list_pengumuman_model.dart';
import 'package:simpel/shared/shared_prefrences.dart';
import 'base_url.dart' as base_url;
import 'package:http/http.dart' as http;

class PengumumanServices {
  String token = SharedPreference.login.getString("token");
  String idCalon = SharedPreference.login.getString("id_calon");

  Future<List<DataPengumuman>> getDataPengumuman() async {
    var url = '${base_url.Url}/get-pengumuman?id_calon=$idCalon';
    var header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(
      Uri.parse(url),
      headers: header,
    );

    var data = jsonDecode(response.body);
    debugPrint("Status Get Data Pengumuman=${data['success']}");

    try {
      List allNews = json.decode(response.body)['data'];
      List<DataPengumuman> allNamePengumuman = [];

      for (var item in allNews) {
        allNamePengumuman.add(DataPengumuman.fromJson(item));
      }

      return allNamePengumuman;
    } catch (e) {
      rethrow;
    }
  }
}