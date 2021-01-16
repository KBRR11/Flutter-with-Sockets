import 'package:flutter/material.dart';

class ScrollService with ChangeNotifier {
  PageController _controller = PageController(initialPage: 1);
  PageController _controllerIn = PageController(initialPage: 0);

  // @override
  // void initState() {
  //
  // }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _controllerIn.dispose();
  }

  PageController get controller => this._controller;
  PageController get controllerIn => this._controllerIn;
}
