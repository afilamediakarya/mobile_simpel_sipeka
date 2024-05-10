import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:simpel/models/detail_suara_model.dart';
import 'package:simpel/models/list_suara_model.dart';
import 'package:simpel/models/search_suara_model.dart';
import 'package:simpel/models/total_suara_model.dart';

import 'base_url.dart' as base_url;
import 'package:http/http.dart' as http;
import 'package:simpel/shared/shared_prefrences.dart';

class SuaraServices {
  String token = SharedPreference.login.getString("token");
  String idUser = SharedPreference.login.getString("idUser");
  String idCalon = SharedPreference.login.getString("id_calon");

  Future<TotalSuaraModel> getDataTotalSuara() async {
    var url = '${base_url.Url}/suara/total-suara?user=$idUser';
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
      if (data['success'] == true) {
        TotalSuaraModel totalSuaraModel = TotalSuaraModel.fromJson(data);

        return totalSuaraModel;
      } else {
        throw data['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<DataListSuara>> getDataListSuara({required String page}) async {
    var url = '${base_url.Url}/suara/list?user=$idUser&page=$page';
    var header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(Uri.parse(url), headers: header);

    var data = jsonDecode(response.body);
    debugPrint("Status Get Data List Suara =${data['success']}");

    try {
      List allSuara = json.decode(response.body)['data']['data'];
      List<DataListSuara> allNameSuara = [];

      for (var item in allSuara) {
        allNameSuara.add(DataListSuara.fromJson(item));
      }

      return allNameSuara;
    } catch (e) {
      rethrow;
    }
  }

  Future<DetailSuaraModel> getDataDetailSuara({required String id}) async {
    var url = '${base_url.Url}/suara/show/$id';
    var header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(
      Uri.parse(url),
      headers: header,
    );

    var data = jsonDecode(response.body);
    debugPrint("Status Get Data Detail Suara=${data['success']}");

    try {
      if (data['success'] == true) {
        DetailSuaraModel detailSuaraModel = DetailSuaraModel.fromJson(data);

        return detailSuaraModel;
      } else {
        throw data['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<DataSearchSuara>> getSearchSuara({required String value}) async {
    var url =
        '${base_url.Url}/suara/search?search=$value&calon=$idCalon&user=$idUser';
    var header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(
      Uri.parse(url),
      headers: header,
    );

    var data = jsonDecode(response.body);
    debugPrint("Status Get Search Suara=${data['success']}");

    try {
      List allSearch = json.decode(response.body)['data'];
      List<DataSearchSuara> allNameSearch = [];

      for (var item in allSearch) {
        allNameSearch.add(DataSearchSuara.fromJson(item));
      }

      return allNameSearch;
    } catch (e) {
      rethrow;
    }
  }
}
