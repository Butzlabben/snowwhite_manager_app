import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

final prefix = "https://naegele.dev/snowwhite_manager/";

Future<bool> verifyWithUsername(String token, String pin) async {
  if (token == null) return false;
  String url = prefix + "verify_pin.dart";
  Map body = {'token': token, 'pin': pin};
  http.Response response = await http.post(url, body: body);

  return false;
}

Future<bool> verify(String pin) async {
  String token = await FlutterSecureStorage().read(key: 'token');
  return verifyWithUsername(token, pin);
}

Future<String> logIn(String name, String pin) async {
  Future<String> token;
  String url = prefix + "login.dart";
  Map body = {'name': name, 'pin': pin};
  http.Response response = await http.post(url, body: body);
  if (response.statusCode != 200) {
    token = Future.error("error");
  } else {
    token = Future.value(jsonDecode(response.body)["token"]);
  }
  return token;
}
