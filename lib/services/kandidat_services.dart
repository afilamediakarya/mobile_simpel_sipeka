import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:simpel/models/kandidat_model.dart';
import 'package:simpel/shared/shared_prefrences.dart';
import 'base_url.dart' as base_url;
import 'package:http/http.dart' as http;

class KandidatServices {
  String token = SharedPreference.login.getString("token");

  Future<KandidatModel> getDataKandidat({required String idCalon}) async {
    var url = '${base_url.Url}/calon/$idCalon';
    var header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(
      Uri.parse(url),
      headers: header,
    );

    var data = jsonDecode(response.body);
    debugPrint("Status Get Data Kandidat=${data['success']}");

    try {
      if (data['success'] == true) {
        KandidatModel kandidatModel = KandidatModel.fromJson(data);

        //shared preferences untuk foto

        return kandidatModel;
      } else {
        throw data['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}
