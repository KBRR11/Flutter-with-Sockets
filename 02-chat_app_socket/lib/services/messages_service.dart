import 'package:chat_app_socket/models/usuario.dart';
import 'package:flutter/material.dart';

import 'package:chat_app_socket/widgets/message_bubble.dart';

class MessagesService extends ChangeNotifier {
  Usuario usuarioPara;
  List<MessageBubble> _messageBubble = [];
  AnimationController _animationController;

  List<MessageBubble> get messageBubble => _messageBubble;
  AnimationController get animationController => _animationController;

  addMessage(
      String uid, String texto, AnimationController _animationController) {
    final newMessage = new MessageBubble(
      uid: uid,
      texto: texto,
      animationController: _animationController,
    );

    _messageBubble.insert(0, newMessage);
    newMessage.animationController.forward();
    notifyListeners();
  }
}
