
import 'package:chat_app_socket/global/enviroment.dart';
import 'package:chat_app_socket/models/usuarios_response.dart';
import 'package:chat_app_socket/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:chat_app_socket/models/usuario.dart';
import 'package:flutter/material.dart';

class UsuariosService with ChangeNotifier {
   
  List<Usuario> _usuarios = [];

  List<Usuario> get usuarios => this._usuarios;


  

 Future<List<Usuario>>refreshList() async{
   try{
     print('refresh');// Ya entendí porque funciona :v hace millones de peticiones 
    final resp = await http.get('${ Enviroment.apiUrl }/usuarios/',
    headers: {
      'Content-Type': 'application/json',
      'x-token': await AuthService.getToken()
    });
    final usuariosResponse = usuariosResponseFromJson(resp.body);
    this._usuarios = usuariosResponse.usuarios;
    notifyListeners();
    
    return usuariosResponse.usuarios;
    
   }catch(e){
     this._usuarios=[];
     notifyListeners();
    return [];
   }
 }



}