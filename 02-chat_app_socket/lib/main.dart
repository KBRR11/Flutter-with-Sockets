import 'package:chat_app_socket/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app_socket/routes/routes.dart';
import 'package:chat_app_socket/services/scroll_service.dart';
import 'package:chat_app_socket/services/validator_service.dart';
import 'package:chat_app_socket/services/messages_service.dart';

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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Messenger',
        initialRoute: 'scroll',
        routes: appRoutes,
      ),
    );
  }
}
