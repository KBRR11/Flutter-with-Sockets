import 'package:chat_app_socket/pages/chat_page.dart';
import 'package:chat_app_socket/pages/home_page.dart';
import 'package:chat_app_socket/pages/login_page.dart';
import 'package:chat_app_socket/pages/register_page.dart';
import 'package:chat_app_socket/pages/usuarios_page.dart';
import 'package:chat_app_socket/widgets/navigation_bar.dart';
import 'package:chat_app_socket/widgets/page_scroll.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'scroll': (BuildContext context) => ScrollPage(),
  'home': (BuildContext context) => HomePage(),
  'login': (BuildContext context) => LoginPage(),
  'register': (BuildContext context) => RegisterPage(),
  'usuarios': (BuildContext context) => UsuariosPage(),
  'chat': (BuildContext context) => ChatPage(),
  'menu': (BuildContext context) => BottomNavBar(),
};
