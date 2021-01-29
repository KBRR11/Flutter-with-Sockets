import 'dart:io';
import 'dart:ui';

import 'package:chat_app_socket/services/messages_service.dart';
import 'package:chat_app_socket/services/validator_service.dart';
//import 'package:chat_app_socket/widgets/message_bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:chat_app_socket/widgets/fondo.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Fondo(
            background: Color.fromRGBO(233, 239, 253, 1),
          ),
          Header(),
          BackgrounChat(),
          //InputTextChat()
        ],
      ),
    );
  }
}

class InputTextChat extends StatefulWidget {
  @override
  _InputTextChatState createState() => _InputTextChatState();
}

class _InputTextChatState extends State<InputTextChat>
    with TickerProviderStateMixin {
  final _textController = new TextEditingController();

  final _focusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    final validatorService = Provider.of<ValidatorService>(context);
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(right: 50, left: 20),
            width: MediaQuery.of(context).size.width * 0.7,
            height: 48,
            decoration: BoxDecoration(
                color: Color.fromRGBO(247, 248, 253, 1),
                borderRadius: BorderRadius.circular(20)),
            child: TextField(
              controller: _textController,
              onSubmitted: (String texto) {
                if (texto.trim().length > 0) {
                  _handleSubmit(context, texto);
                  validatorService.escribiendoValidator(false);
                } else {
                  return null;
                }
              },
              onChanged: (String texto) {
                if (texto.trim().length > 0) {
                  validatorService.escribiendoValidator(true);
                } else {
                  validatorService.escribiendoValidator(false);
                }
              },
              focusNode: _focusNode,
              style: TextStyle(fontFamily: 'Rubik', fontSize: 18),
              autocorrect: false,
              keyboardType: TextInputType.text,
              obscureText: false,
              decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                  hintStyle: TextStyle(fontFamily: 'Rubik', fontSize: 18),
                  hintText: 'Escribe algo...'),
            ),
          ),
          Container(
            child: !Platform.isIOS
                ? CupertinoButton(
                    child: Text('Enviar'),
                    onPressed: validatorService.estaEscribiendo
                        ? () {
                            _handleSubmit(context, _textController.text.trim());
                            validatorService.escribiendoValidator(false);
                          }
                        : null,
                  )
                : IconButton(
                    icon: Icon(
                      Icons.send,
                      color: Color.fromRGBO(86, 122, 244, 1),
                    ),
                    onPressed: () {},
                  ),
          )
        ],
      ),
    );
  }

  _handleSubmit(BuildContext context, String texto) {
    final messageService = Provider.of<MessagesService>(context, listen: false);
    _focusNode.requestFocus();
    _textController.clear();
    messageService.addMessage(
        '123',
        texto,
        AnimationController(
            vsync: this, duration: Duration(milliseconds: 400)));

    //
  }
}

class BackgrounChat extends StatefulWidget {
  @override
  _BackgrounChatState createState() => _BackgrounChatState();
}

class _BackgrounChatState extends State<BackgrounChat> {
  @override
  Widget build(BuildContext context) {
    final messageService = Provider.of<MessagesService>(context);
    return Positioned(
      bottom: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: MediaQuery.of(context).size.height * 0.83,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40))),
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: messageService.messageBubble.length,
                itemBuilder: (_, i) => messageService.messageBubble[i],
                reverse: true,
              ),
            ),
            InputTextChat()
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final messagesService = Provider.of<MessagesService>(context);
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.08,
      child: Container(
        //padding: EdgeInsets.symmetric(horizontal: 0),
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RawMaterialButton(
              shape: CircleBorder(),
              onPressed: () {
                Navigator.pop(context, 'menu');
              },
              child: Container(
                  width: 50,
                  height: 50,
                  //color: Colors.red,
                  child: Icon(Icons.arrow_back, color: Colors.black54)),
            ),
            Text(
              messagesService.usuarioPara.nombre,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w500),
            ),
            RawMaterialButton(
              child: Container(
                  width: 50,
                  height: 50,
                  child:
                      Icon(Icons.info_outline_rounded, color: Colors.black54)),
              shape: CircleBorder(),
              onPressed: () {},//TODO: hacer page info de Usurario y navegación 
            )
          ],
        ),
      ),
    );
  }
}
