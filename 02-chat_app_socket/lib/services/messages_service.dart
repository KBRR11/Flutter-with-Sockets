import 'package:chat_app_socket/global/local_enviroment.dart';
import 'package:chat_app_socket/models/mensajes_response.dart';
import 'package:chat_app_socket/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:chat_app_socket/models/usuario.dart';
import 'package:http/http.dart' as http;

import 'package:chat_app_socket/widgets/message_bubble.dart';

class MessagesService extends ChangeNotifier {
  Usuario usuarioPara;
  TextEditingController _textController = new TextEditingController();
  List<MessageBubble> _messageBubble = [];
  AnimationController _animationController;

  TextEditingController get textController => this._textController;
  List<MessageBubble> get messageBubble => _messageBubble;
  AnimationController get animationController => _animationController;

  addMessage(
      String uid, String texto, AnimationController animationController) {
    final newMessage = new MessageBubble(
      uid: uid,
      texto: texto,
      animationController: animationController,
    );

    _messageBubble.insert(0, newMessage);
    newMessage.animationController.forward();
    notifyListeners();
  }

  

  Future<List<Mensaje>> getChat(String usuarioID)async{
   final resp = await http.get('${Enviroment.apiUrl}/mensajes/$usuarioID',
   headers: {
     'Content-Type':'application/json',
     'x-token': await AuthService.getToken()
   }
   );
   final mensajesResp = mensajesResponseFromJson(resp.body);

   return mensajesResp.mensajes;
  }
}
