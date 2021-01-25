import 'package:flutter/material.dart';

class ScrollService with ChangeNotifier {
  PageController _controller = PageController(initialPage: 1);
  PageController _controllerLogin = PageController(initialPage: 0);
  PageController _controllerregister = PageController(initialPage: 2);

  

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _controllerLogin.dispose();
  }

  PageController get controller => this._controller;
  PageController get controllerLogin => this._controllerLogin;
  PageController get controllerRegister => this._controllerregister;

  
}
