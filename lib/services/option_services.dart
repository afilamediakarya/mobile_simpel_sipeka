import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:simpel/models/list_provinsi_model.dart';

import 'base_url.dart' as base_url;
import 'package:http/http.dart' as http;
import 'package:simpel/shared/shared_prefrences.dart';

class OptionServices {
  String token = SharedPreference.login.getString("token");

  Future<List<DataListProvinsi>> getDataListProvinsi() async {
    var url = '${base_url.Url}/master/provinsi';
    var header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(Uri.parse(url), headers: header);

    var data = jsonDecode(response.body);
    debugPrint("Status Get Data List Provinsi =${data['success']}");

    try {
      List allProvinsi = json.decode(response.body)['data'];
      List<DataListProvinsi> allNameProvinsi = [];

      for (var item in allProvinsi) {
        allNameProvinsi.add(DataListProvinsi.fromJson(item));
      }

      return allNameProvinsi;
    } catch (e) {
      rethrow;
    }
  }

  Future<List> getDataListKabupaten() async {
    var url =
        '${base_url.Url}/master/kabupaten/27'; //defult = 27 (Sulawesi Selatan)
    var header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(Uri.parse(url), headers: header);

    var data = jsonDecode(response.body);
    debugPrint("Status Get Data List Kabupaten =${data['success']}");

    try {
      if (data['success'] == true) {
        List allKabupaten = jsonDecode(response.body)['data'];
        return allKabupaten;
      } else {
        throw data['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List> getDataListKecamatan({required int idKabupaten}) async {
    var url = '${base_url.Url}/master/kecamatan/$idKabupaten';
    var header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(Uri.parse(url), headers: header);

    var data = jsonDecode(response.body);
    debugPrint("Status Get Data List Kecamatan =${data['success']}");

    try {
      if (data['success'] == true) {
        List allKecamatan = jsonDecode(response.body)['data'];
        return allKecamatan;
      } else {
        throw data['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List> getDataListKelurahanProfile({required int idKecamatan}) async {
    var url = '${base_url.Url}/master/kelurahan/$idKecamatan';
    var header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(Uri.parse(url), headers: header);

    var data = jsonDecode(response.body);
    debugPrint("Status Get Data List Kelurahan Profile=${data['success']}");

    try {
      if (data['success'] == true) {
        List allKelurahan = jsonDecode(response.body)['data'];
        return allKelurahan;
      } else {
        throw data['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List> getDataListKelurahan({required int idCalon}) async {
    var url = '${base_url.Url}/master/kelurahan-all?calon=$idCalon';
    var header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(Uri.parse(url), headers: header);

    var data = jsonDecode(response.body);
    debugPrint("Status Get Data List Kelurahan =${data['success']}");

    try {
      if (data['success'] == true) {
        List allKelurahan = jsonDecode(response.body)['data'];
        return allKelurahan;
      } else {
        throw data['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List> getDataListTps({required int idKelurahan}) async {
    var url = '${base_url.Url}/master/tps/$idKelurahan';
    var header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(Uri.parse(url), headers: header);

    var data = jsonDecode(response.body);
    debugPrint("Status Get Data List TPS =${data['success']}");

    try {
      if (data['success'] == true) {
        List allTps = jsonDecode(response.body)['data'];
        return allTps;
      } else {
        throw data['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List> getDataKomunitas() async {
    var url = '${base_url.Url}/master/komunitas';
    var header = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var response = await http.get(Uri.parse(url), headers: header);

    var data = jsonDecode(response.body);
    debugPrint("Status Get Data Komunitas =${data['success']}");

    try {
      if (data['success'] == true) {
        List allKomunitas = jsonDecode(response.body)['data'];
        return allKomunitas;
      } else {
        throw data['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}
