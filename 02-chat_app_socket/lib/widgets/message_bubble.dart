import 'package:chat_app_socket/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageBubble extends StatelessWidget {
  final String texto;
  final String uid;
  final AnimationController animationController;

  const MessageBubble(
      {Key key,
      @required this.texto,
      @required this.uid,
      @required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
            curve: Curves.easeInOutBack, parent: animationController),
        child: Container(
          child: this.uid == authService.usuario.uid ? myMessage() : notMyMessage(),
        ),
      ),
    );
  }

  myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromRGBO(86, 122, 244, 1),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30))),
        padding:
            EdgeInsets.only(top: 8.0, bottom: 8.0, left: 13.0, right: 10.0),
        margin: EdgeInsets.only(bottom: 7, left: 20),
        child: Text(
          this.texto,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  notMyMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromRGBO(246, 248, 254, 1),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
                bottomRight: Radius.circular(30))),
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(bottom: 10, right: 20),
        child: Text(
          this.texto,
          style: TextStyle(color: Colors.black87),
        ),
      ),
    );
  }
}
