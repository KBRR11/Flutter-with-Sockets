import 'package:flutter/material.dart';

class ValidatorService extends ChangeNotifier {
  bool _estaEscribiendo = false;
  bool _emailValidator = false;
  bool _passValidator = false;
  bool _canLogin = false;
  

  bool get emailValidator => this._emailValidator;
  bool get passValidator => this._passValidator;
  bool get canLogin => this._canLogin;

  set emailValidator(bool valor){
    this._emailValidator=valor;
    loginValidator();
  }
   set passValidator(bool valor){
    this._passValidator=valor;
    loginValidator();
  }

  loginValidator(){
    if(_emailValidator && _passValidator){
     _canLogin=true;
     notifyListeners();
    }else{
      _canLogin=false;
     notifyListeners();
    }
    
  }
  
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
