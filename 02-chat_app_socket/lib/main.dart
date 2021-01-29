import 'package:chat_app_socket/services/usuarios_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app_socket/routes/routes.dart';
import 'package:chat_app_socket/services/scroll_service.dart';
import 'package:chat_app_socket/services/validator_service.dart';
import 'package:chat_app_socket/services/messages_service.dart';
import 'package:chat_app_socket/services/auth_service.dart';
import 'package:chat_app_socket/services/socket_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ScrollService()),
        ChangeNotifierProvider(create: (_) => ValidatorService()),
        ChangeNotifierProvider(create: (_) => MessagesService()),
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => SocketService()),
        ChangeNotifierProvider(create: (_) => UsuariosService()),
        
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Messenger',
        initialRoute: 'loading',/*'scroll',*/
        routes: appRoutes,
      ),
    );
  }
}
