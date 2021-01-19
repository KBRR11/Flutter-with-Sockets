import 'dart:convert';

import 'package:chat_app_socket/models/login_response.dart';
import 'package:chat_app_socket/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chat_app_socket/global/enviroment.dart';

class AuthService with ChangeNotifier {
  Usuario usuario;
  bool _autenticando = false;
  // Create storage
  final _storage = new FlutterSecureStorage();

  bool get autenticando => this._autenticando;

  set autenticando(bool valor) {
    this._autenticando = valor;
    notifyListeners();
  }

  //getter del token de forma estatica

  static Future<String> getToken() async{
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }
  static Future<void> deleteToken() async{
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
   
  }

  Future<bool> login(String email, String password) async {
    this.autenticando = true;
    final data = {'email': email, 'password': password};

    final resp = await http.post('${Enviroment.apiUrl}/login/',
        body: jsonEncode(data), headers: {'Content-type': 'application/json'});

    print(resp.body);
    this.autenticando = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      //Guardar Token
      await this._saveToken(loginResponse.token);
      return true;
    } else {
      return false;
    }
  }

  // Read value 
  //String value = await storage.read(key: key);

  // Read all values
  //Map<String, String> allValues = await storage.readAll();

  // Delete value 
  //await storage.delete(key: key);

  // Delete all 
  //await storage.deleteAll();

  // Write value 
  //await storage.write(key: key, value: value);

  Future _saveToken(String token) async{
    // Write value 
    return await _storage.write(key: 'token', value: token);
  }

  Future logOut() async{
  // Delete value 
   await _storage.delete(key: 'token');
  }
}
