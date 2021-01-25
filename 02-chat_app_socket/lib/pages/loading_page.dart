import 'package:chat_app_socket/services/auth_service.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
 
class LoadingPage extends StatelessWidget {
  const LoadingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future:checkLoginState(context), 
        builder: (context, snapshot){
         return Center(
        child: Text('Cargando..' ,style: TextStyle(fontSize: 20),),
    );
        } ,
              
      ),
    );
  }

  Future checkLoginState(BuildContext context) async{
    final authService = Provider.of<AuthService>(context, listen: false);

    final bool autenticado = await authService.isLoggedIn();

    if (autenticado) {
      //TODO: conectar al Server Socket
      Navigator.pushReplacementNamed(context, 'menu');
    
    } else {
      Navigator.pushReplacementNamed(context, 'scroll');
    }
  }
}