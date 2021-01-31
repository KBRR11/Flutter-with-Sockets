import 'dart:io';
import 'dart:ui';

import 'package:chat_app_socket/models/mensajes_response.dart';
import 'package:chat_app_socket/services/auth_service.dart';
import 'package:chat_app_socket/services/messages_service.dart';
import 'package:chat_app_socket/services/socket_service.dart';
import 'package:chat_app_socket/services/validator_service.dart';
import 'package:chat_app_socket/widgets/message_bubble.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:chat_app_socket/widgets/fondo.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin{
  SocketService socketService;
  MessagesService messageService;
  @override
  void initState() {
    super.initState();
    this.messageService = Provider.of<MessagesService>(context, listen:false);
    this.socketService = Provider.of<SocketService>(context, listen:false);
    this.socketService.socket.on('mensaje-personal',_escucharMensaje);
    _cargarHistorial(this.messageService.usuarioPara.uid);
  }
  @override
  void dispose() {
    this.socketService.socket.off('mensaje-personal');
    this.messageService.messageBubble.clear();
    super.dispose();
  }
  void _cargarHistorial(String usuarioID)async{
   List<Mensaje> chat = await this.messageService.getChat(usuarioID);
   print(chat);
   final history = chat.map((m) => new MessageBubble(
     texto: m.mensaje, uid: m.de, 
     animationController: AnimationController(  duration: Duration(milliseconds: 0), vsync: this)..forward()));
     setState(() {
       this.messageService.messageBubble.insertAll(0, history);
     });
  }
  void _escucharMensaje(dynamic payload){
   messageService.addMessage(
     payload['de'],
     payload['mensaje'],
     AnimationController(  duration: Duration(milliseconds: 400), vsync: this),
);
  }
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
  //final _textController = new TextEditingController();

  final _focusNode = new FocusNode();
  MessagesService messageService;
  SocketService socketService;
  AuthService authService;
  ValidatorService validatorServices;
  
@override
  void initState() {
    this.messageService = Provider.of<MessagesService>(context, listen:false);
    this.messageService.textController.clear();
    //this.validatorServices = Provider.of<ValidatorService>(context, listen:false);//TODO: arreglar bug de los validators
    //this.validatorServices.escribiendoValidator(false);
    this.socketService = Provider.of<SocketService>(context, listen:false);
    this.authService = Provider.of<AuthService>(context, listen: false);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final validatorService = Provider.of<ValidatorService>(context);
    //final messagesService = Provider.of<MessagesService>(context);
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
              controller: this.messageService.textController,
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
                            _handleSubmit(context, this.messageService.textController.text.trim());
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
    //final messageService = Provider.of<MessagesService>(context, listen: false);
    //final authService = Provider.of<AuthService>(context, listen: false);
    //print("de: "+authService.usuario.uid+"\npara: "+messageService.usuarioPara.uid+"\nmensaje: "+texto);
    //print(texto.length);
    this.socketService.socket.emit('mensaje-personal',{
      'de':this.authService.usuario.uid,
      'para': this.messageService.usuarioPara.uid,
      'mensaje':texto
    });
    _focusNode.requestFocus();
    this.messageService.textController.clear();
    messageService.addMessage(
        this.authService.usuario.uid,//TODO: Cambiar a Id de verdad
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
  //SocketService socketService;
  //@override
  //void initState() { 
  //  this. socketService = Provider.of<SocketService>(context, listen: false);
  //  this.socketService.socket.on('mensaje-personal', (payload) => _escucharMensaje(payload));
  //  super.initState();
  //  
  //}
  //void _escucharMensaje( dynamic payload){
 //print('tengo mensaje');
  //}

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
