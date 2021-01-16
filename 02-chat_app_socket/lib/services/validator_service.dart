import 'package:flutter/material.dart';

class ValidatorService extends ChangeNotifier {
  bool _estaEscribiendo = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  bool get estaEscribiendo => this._estaEscribiendo;

  escribiendoValidator(bool resp) {
    _estaEscribiendo = resp;

    notifyListeners();
  }
}
