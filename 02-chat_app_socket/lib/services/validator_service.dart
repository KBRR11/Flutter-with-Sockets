import 'package:flutter/material.dart';

class ValidatorService extends ChangeNotifier {
  bool _estaEscribiendo = false;
  bool _emailLoginValidator = false;
  bool _passLoginValidator = false;
  bool _canLogin = false;


  bool _nameRegisterValidator = false;
  bool _emailRegisterValidator = false;
  bool _passRegisterValidator = false;
  bool _canRegister = false;
  

  bool get emailLoginValidator => this._emailLoginValidator;
  bool get passLoginValidator => this._passLoginValidator;
  bool get canLogin => this._canLogin;
  

  set emailLoginValidator(bool valor){
    this._emailLoginValidator=valor;
    loginValidator();
  }
   set passLoginValidator(bool valor){
    this._passLoginValidator=valor;
    loginValidator();
  }

  loginValidator(){
    if(_emailLoginValidator && _passLoginValidator){
     _canLogin=true;
     notifyListeners();
    }else{
      _canLogin=false;
     notifyListeners();
    }
    
  }

  bool get nameRegisterValidator => this._nameRegisterValidator;
  bool get emailRegisterValidator => this._emailRegisterValidator;
  bool get passRegisterValidator => this._passRegisterValidator;
  bool get canRegister => this._canRegister;

  set nameRegisterValidator(bool valor){
    this._nameRegisterValidator=valor;
    registerValidator();
  }
  set emailRegisterValidator(bool valor){
    this._emailRegisterValidator=valor;
    registerValidator();
  }
   set passRegisterValidator(bool valor){
    this._passRegisterValidator=valor;
    registerValidator();
  }

  registerValidator(){
  if(_nameRegisterValidator && _emailRegisterValidator && _passRegisterValidator){
     _canRegister=true;
     notifyListeners();
    }else{
      _canRegister=false;
     notifyListeners();
    }
  }
  
  
  
  

  bool get estaEscribiendo => this._estaEscribiendo;

  escribiendoValidator(bool resp) {
    _estaEscribiendo = resp;

    notifyListeners();
  }

  

}
