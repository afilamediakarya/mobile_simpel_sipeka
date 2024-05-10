import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:simpel/models/login_user_model.dart';
import 'package:simpel/shared/shared_prefrences.dart';
import 'base_url.dart' as base_url;

class AuthServices {
  Future<String> loginUser({
    required String username,
    required String password,
  }) async {
    var url = '${base_url.Url}/login';
    var header = {
      'Accept': 'application/json',
    };
    var body = {
      'username': username,
      'password': password,
    };

    var response = await http.post(
      Uri.parse(url),
      headers: header,
      body: body,
    );

    var data = jsonDecode(response.body);
    debugPrint("Status Login User=${data['success']}");

    try {
      if (data['success'] == true) {
        LoginUserModel loginUserModel = LoginUserModel.fromJson(data);

        SharedPreference.login?.setString("token", loginUserModel.data.token);
        SharedPreference.login?.setString("uuid", loginUserModel.data.uuid);
        SharedPreference.login
            ?.setString("idUser", loginUserModel.data.id.toString());

        return loginUserModel.message;
      } else {
        throw data['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}
