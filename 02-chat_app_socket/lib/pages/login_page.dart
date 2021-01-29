import 'package:chat_app_socket/services/auth_service.dart';
import 'package:chat_app_socket/services/scroll_service.dart';
import 'package:chat_app_socket/services/socket_service.dart';
import 'package:chat_app_socket/services/validator_service.dart';
import 'package:chat_app_socket/widgets/fondo.dart';
import 'package:chat_app_socket/widgets/logo.dart';
import 'package:chat_app_socket/widgets/raised_button.dart';
import 'package:chat_app_socket/widgets/textField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweetalert/sweetalert.dart';

class LoginPage extends StatelessWidget {
  //const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Fondo(
            background: Color.fromRGBO(24, 121, 153, 1),
          ),
          // Logo(
          //   text: 'login',
          //   assetImage: 'assets/usuario.png',
          // ),
          // __Form(),
          SingleChildScrollView(child: LoginForm())
        ],
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 60,
        ),
        Logo(
          text: 'login',
          assetImage: 'assets/caja-de-seguridad.png',
        ),
        SizedBox(
          height: 50,
        ),
        __Form(),
      ],
    );
  }
}

class __Form extends StatefulWidget {
  @override
  ___FormState createState() => ___FormState();
}

class ___FormState extends State<__Form> {
  final emailCtrl = TextEditingController();

  final passCtrl = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailCtrl.dispose();
    passCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scrollService = Provider.of<ScrollService>(context);
    final authService = Provider.of<AuthService>(context);
    final validatorService = Provider.of<ValidatorService>(context);
    final socketService = Provider.of<SocketService>(context, listen: false);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50.0),
      width: MediaQuery.of(context).size.width,
      //height: 150,
      //color: Colors.red,
      child: Column(
        children: [
          TextFieldCustomized(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            textController: emailCtrl,
            onChanged: (text) {
              if (text.toString().length > 0) {
                setState(() {
                  validatorService.emailLoginValidator = true;
                });
              } else {
                setState(() {
                  validatorService.emailLoginValidator = false;
                });
              }
            },
            keyboardType: TextInputType.emailAddress,
          ),
          TextFieldCustomized(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            textController: passCtrl,
            onChanged: (text) {
              if (text.toString().length > 0) {
                setState(() {
                  validatorService.passLoginValidator = true;
                });
              } else {
                setState(() {
                  validatorService.passLoginValidator = false;
                });
              }
            },
            isPassword: true,
          ),
          RaisedPersonalizado(
            backgroundColor: Color.fromRGBO(66, 141, 255, 1),
            fontFamiliy: 'GlegooRegular',
            onPressed: validatorService.canLogin
                ? authService.autenticando
                    ? null
                    : () async {
                        //Navigator.pushReplacementNamed(context, 'menu');
                        FocusScope.of(context).unfocus();
                        final loginOk = await authService.login(
                            emailCtrl.text.trim(), passCtrl.text.trim());

                        if (loginOk) {
                          socketService.connect(emailCtrl.text.trim().toString());
                          //socketService.socket.emit('userConnected','funciona');    
                          emailCtrl.clear();
                          passCtrl.clear();
                          Navigator.pushReplacementNamed(context, 'menu');

                          SweetAlert.show(context,
                              title: 'Bienvenido',
                              style: SweetAlertStyle.success);
                        } else {
                          SweetAlert.show(context,
                              title: 'Incorrecto',
                              subtitle: 'Usuario y/o Contraseña incorrectos.',
                              style: SweetAlertStyle.error);
                        }
                        //emailCtrl.clear();
                        //passCtrl.clear();
                      }
                : null,
            text: 'Ingresar',
            textColor: Colors.white,
            weight: FontWeight.bold,
          ),
          SizedBox(
            height: 90,
          ),
          RawMaterialButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              scrollService.controller.animateToPage(1,
                  duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              width: 100,
              //color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  Text(
                    'Regresar',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
