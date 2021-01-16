import 'package:chat_app_socket/pages/home_page.dart';
import 'package:chat_app_socket/pages/login_page.dart';
import 'package:chat_app_socket/pages/register_page.dart';
import 'package:chat_app_socket/services/scroll_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScrollPage extends StatefulWidget {
  @override
  _ScrollPageState createState() => _ScrollPageState();
}

class _ScrollPageState extends State<ScrollPage> {
  @override
  Widget build(BuildContext context) {
    final scrollService = Provider.of<ScrollService>(context);
    return Scaffold(
        body: PageView(
      physics: new NeverScrollableScrollPhysics(), // bloquea el scroll
      controller: scrollService.controller,
      scrollDirection: Axis.vertical,
      children: [LoginPage(), HomePage(), RegisterPage()],
    ));
  }
}
