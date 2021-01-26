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

class __Form extends StatefulWidget {
  @override
  ___FormState createState() => ___FormState();
}

class ___FormState extends State<__Form> {
  final nameCtrl = TextEditingController();

  final emailCtrl = TextEditingController();

  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final scrollService = Provider.of<ScrollService>(context);
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
            icon: Icons.account_circle_outlined,
            placeholder: 'Nombre',
            textController: nameCtrl,
            onChanged: (text) {
              if (text.toString().length > 0) {
                setState(() {
                  validatorService.nameRegisterValidator = true;
                });
              } else {
                setState(() {
                  validatorService.nameRegisterValidator = false;
                });
              }
            },
            keyboardType: TextInputType.emailAddress,
          ),
          TextFieldCustomized(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            textController: emailCtrl,
            onChanged:(text) {
              if (text.toString().length > 0) {
                setState(() {
                  validatorService.emailRegisterValidator = true;
                });
              } else {
                setState(() {
                  validatorService.emailRegisterValidator = false;
                });
              }
              } ,
            keyboardType: TextInputType.emailAddress,
          ),
          TextFieldCustomized(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            textController: passCtrl,
            onChanged: (text) {
              if (text.toString().length > 0) {
                setState(() {
                  validatorService.passRegisterValidator = true;
                });
              } else {
                setState(() {
                  validatorService.passRegisterValidator = false;
                });
              }
              } ,
            isPassword: true,
          ),
          RaisedPersonalizado(
            backgroundColor: Color.fromRGBO(66, 141, 255, 1),
            fontFamiliy: 'GlegooRegular',
            onPressed: validatorService.canRegister?
            authService.autenticando
                    ? null
                    :
            () async {
              
              FocusScope.of(context).unfocus();
              final registerOk = await authService.register(
                  nameCtrl.text.trim(),
                  emailCtrl.text.trim(),
                  passCtrl.text.trim());
              if (registerOk==true) {
                socketService.connect(emailCtrl.text.trim().toString());
                Navigator.pushReplacementNamed(context, 'menu');
                SweetAlert.show(context,
                    title: 'Bienvenido',
                    subtitle: nameCtrl.text.trim(),
                    style: SweetAlertStyle.success);
                    nameCtrl.clear();
                    emailCtrl.clear();
                    passCtrl.clear();
              } else {
                SweetAlert.show(context,
                    title: 'Incorrecto',
                    subtitle: registerOk,
                    style: SweetAlertStyle.error);
              }

              
            }
            :null,
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
              FocusScope.of(context).unfocus();
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
