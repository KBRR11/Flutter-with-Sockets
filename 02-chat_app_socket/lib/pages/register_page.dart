import 'package:chat_app_socket/services/scroll_service.dart';
import 'package:chat_app_socket/widgets/fondo.dart';
import 'package:chat_app_socket/widgets/logo.dart';
import 'package:chat_app_socket/widgets/raised_button.dart';
import 'package:chat_app_socket/widgets/textField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  //const RegisterPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Fondo(
          background: Color.fromRGBO(13, 160, 154, 1),
        ),
        SingleChildScrollView(child: RegisterForm())
      ],
    ));
  }
}

class RegisterForm extends StatelessWidget {
  const RegisterForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 60,
        ),
        Logo(
          text: 'register',
          assetImage: 'assets/usuario.png',
        ),
        SizedBox(
          height: 50,
        ),
        __Form(),
      ],
    );
  }
}

class __Form extends StatelessWidget {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final scrollService = Provider.of<ScrollService>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50.0),
      width: MediaQuery.of(context).size.width,
      //height: 150,
      //color: Colors.red,
      child: Column(
        children: [
          TextFieldCustomized(
            icon: Icons.account_circle_outlined,
            placeholder: 'Nombre',
            textController: nameCtrl,
            keyboardType: TextInputType.emailAddress,
          ),
          TextFieldCustomized(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            textController: emailCtrl,
            keyboardType: TextInputType.emailAddress,
          ),
          TextFieldCustomized(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            textController: passCtrl,
            isPassword: true,
          ),
          RaisedPersonalizado(
            backgroundColor: Color.fromRGBO(66, 141, 255, 1),
            fontFamiliy: 'GlegooRegular',
            onPressed: () {
              //scrollService.controller.animateToPage(0,
              //    duration: Duration(seconds: 1),
              //    curve: Curves.fastOutSlowIn);
              print(nameCtrl.text);
              print(emailCtrl.text);
              print(passCtrl.text);
              //emailCtrl.clear();
            },
            text: 'Registrar',
            textColor: Colors.white,
            weight: FontWeight.bold,
          ),
          SizedBox(
            height: 60,
          ),
          RawMaterialButton(
            onPressed: () {
              scrollService.controller.animateToPage(1,
                  duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              margin: EdgeInsets.only(bottom: 25),
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
