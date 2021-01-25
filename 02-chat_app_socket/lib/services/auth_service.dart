import 'dart:convert';
import 'dart:io';

import 'package:chat_app_socket/models/login_response.dart';
import 'package:chat_app_socket/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';

import 'package:chat_app_socket/global/enviroment.dart';

class AuthService with ChangeNotifier {
  Usuario _usuario;
  bool _autenticando = false;
  // Create storage
  final _storage = new FlutterSecureStorage();

  bool get autenticando => this._autenticando;

  Usuario get usuario => this._usuario; 

  

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

    
    this.autenticando = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this._usuario = loginResponse.usuario;
      //Guardar Token
      await this._saveToken(loginResponse.token);
      return true;
    } else {
      return false;
    }
  }

  Future register(String nombre, String email, String password) async {
    this.autenticando = true;
    final data = {'nombre': nombre, 'email':email, 'password': password};
    final resp = await http.post('${Enviroment.apiUrl}/login/new/',
    body: jsonEncode(data), headers: {'Content-type': 'application/json'});
    
    this.autenticando = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this._usuario = loginResponse.usuario;
      //Guardar Token
      await this._saveToken(loginResponse.token);
      return true;
    } else {
      final resBody = jsonDecode(resp.body);
      return resBody['msg'];
    }
  }

  Future<bool> isLoggedIn() async{
    final token = await this._storage.read(key: 'token');
    
    print(token);
    
    
    final resp = await http.get('${Enviroment.apiUrl}/login/renewtkn',
        headers: {'Content-type': 'application/json', 'x-token': token});
    
    print(resp.body);
    
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this._usuario = loginResponse.usuario;
      //Guardar Token
      
      //print(loginResponse.token);
      await this._saveToken(loginResponse.token);
      return true;
    } else {
       this.logOut();
      return false;
    }
  }
  
  Future _saveToken(String token) async{
    // Write value 
    return await _storage.write(key: 'token', value: token);
  }

  Future logOut() async{
  // Delete value 
   await _storage.delete(key: 'token');
  }

  Future subirImagen(File image) async{
    final url = Uri.parse('https://api.cloudinary.com/v1_1/dee9edshv/image/upload?upload_preset=wkptlfpz');
     final mimeType = mime(image.path).split('/'); //image/jpg lo separamos del / 

      final imageUploadRequest = http.MultipartRequest(
      'POST',
      url
    );

    final file = await http.MultipartFile.fromPath(
      'file',  
      image.path,
      contentType: MediaType( mimeType[0], mimeType[1] ) // pide el tipo y subtipo en este caso: tipo imagen subtipo jpg
      );

      imageUploadRequest.files.add(file);

      final streamResponse = await imageUploadRequest.send();
      final resp = await http.Response.fromStream(streamResponse);

      if( resp.statusCode!= 200 && resp.statusCode !=201){
        print('Algo salio Mal!');
        print(resp.body);
        return null;
      }

      final respData = json.decode(resp.body);

      print(respData['secure_url']);

     final fotoUrl = respData['secure_url'];

   final data = {'uid': _usuario.uid, 'fotoUrl': fotoUrl.toString()};

   final respuesta = await http.put('${Enviroment.apiUrl}/login/updatefoto',
        body: jsonEncode(data), headers: {'Content-type': 'application/json'});

      if (respuesta.statusCode == 200) {
      final loginResponse = loginResponseFromJson(respuesta.body);
      
      this._usuario = loginResponse.usuario;
      notifyListeners();
      //Guardar Token
      await this._saveToken(loginResponse.token);
      return true;
    } else {
      final resBody = jsonDecode(respuesta.body);
      return resBody['msg'];
    }  

  }

}
