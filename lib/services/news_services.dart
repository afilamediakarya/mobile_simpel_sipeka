import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:simpel/models/news_model.dart';

import 'base_url.dart' as base_url;
import 'package:http/http.dart' as http;
import 'package:simpel/shared/shared_prefrences.dart';

class NewsServices {
  String token = SharedPreference.login.getString("token");
  String idCalon = SharedPreference.login.getString("id_calon");

  Future<List<DataNews>> getDataNews() async {
    var url = '${base_url.Url}/get-berita?id_calon=$idCalon';
    var header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(
      Uri.parse(url),
      headers: header,
    );

    var data = jsonDecode(response.body);
    debugPrint("Status Get Data Total Suara=${data['success']}");

    try {
      List allNews = json.decode(response.body)['data'];
      List<DataNews> allNameNews = [];

      for (var item in allNews) {
        allNameNews.add(DataNews.fromJson(item));
      }

      return allNameNews;
    } catch (e) {
      rethrow;
    }
  }
}