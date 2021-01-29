import 'dart:io';

import 'package:chat_app_socket/services/auth_service.dart';
import 'package:chat_app_socket/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sweetalert/sweetalert.dart';

class ConfigUsuario extends StatefulWidget {
  @override
  _ConfigUsuarioState createState() => _ConfigUsuarioState();
}

class _ConfigUsuarioState extends State<ConfigUsuario> {
  ///const ConfigUsuario({Key key}) : super(key: key);
  final picker = ImagePicker();

  File _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        //color: Colors.red,
        child: Column(
          children: [
            _profilePhoto(context),
            _infoEdit(context),
            // _logOut(),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Configuraciones',
        style:
            TextStyle(fontFamily: 'Rubik', fontSize: 29, color: Colors.black87),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: MediaQuery.of(context).size.height * .13,
    );
  }

  Stack _profilePhoto(context) {
    final authService = Provider.of<AuthService>(context);

    return Stack(
      children: [
        Container(
          height: 200,
          width: 200,
          margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200),
            //color: Colors.blue,
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(200),
              child: FadeInImage(
                placeholder: AssetImage('assets/preload.gif'),
                image: (authService.usuario.fotoUrl == "")
                    ? AssetImage('assets/usuario.png')
                    : NetworkImage(authService.usuario.fotoUrl),
                fit: BoxFit.cover,
              )),
          //Image(image: AssetImage('assets/usuario.png'),),
        ),
        Positioned(
          top: 20,
          left: 50,
          child: RawMaterialButton(
            onPressed: () {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                      opaque: false,
                      barrierColor: Colors.white.withOpacity(0),
                      pageBuilder: (BuildContext context, _, __) {
                        return FullScreenPage(
                          child: Center(
                            child: Hero(
                              tag: 'smallImage',
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image(
                                  image: (authService.usuario.fotoUrl == "")
                                      ? AssetImage('assets/usuario.png')
                                      : NetworkImage(
                                          authService.usuario.fotoUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          backgroundColor: Colors.black,
                          backgroundIsTransparent: true,
                          disposeLevel: DisposeLevel.Medium,
                        );
                      }));
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            //splashColor: Colors.black,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
                //color: Colors.blue,
              ),
            ),
          ),
        ),
        Positioned(
            top: 180,
            left: 105,
            child: MaterialButton(
              onPressed: () {
                showMaterialModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) => Container(
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        color: Colors.white),
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * .25, top: 60),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            print('abrir galeria');
                            _seleccionarFoto();
                            Navigator.pop(context);
                          },
                          child: Column(
                            children: [
                              Container(
                                height: 65,
                                width: 65,
                                child: Image(
                                  image: AssetImage('assets/imagen.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Galería',
                                style: TextStyle(fontFamily: 'GlegooRegular'),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        GestureDetector(
                          onTap: () {
                            print('abrir camara');
                            _tomarFoto();
                            Navigator.pop(context);
                          },
                          child: Column(
                            children: [
                              Container(
                                height: 65,
                                width: 65,
                                child: Image(
                                  image: AssetImage(
                                      'assets/camara-fotografica.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Cámara',
                                style: TextStyle(fontFamily: 'GlegooRegular'),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              color: Color.fromRGBO(24, 121, 153, 1),
              textColor: Colors.white,
              child: Icon(
                Icons.camera_alt,
                size: 24,
              ),
              padding: EdgeInsets.all(16),
              shape: CircleBorder(),
            ))
      ],
    );
  }

  _infoEdit(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context, listen: false);
    final usuario = authService.usuario;
    return Column(
      children: [
        ListTile(
          onTap: () {
            print('nombre');
          },
          leading: Icon(
            Icons.perm_identity_outlined,
            size: 40,
            color: Color.fromRGBO(24, 121, 153, 1),
          ),
          title: Text(
            'Nombre:',
            style: TextStyle(
              fontFamily: 'Rubik',
            ),
          ),
          subtitle: Text(
            usuario.nombre,
            style: TextStyle(
                fontFamily: 'Rubik', fontWeight: FontWeight.bold, fontSize: 16),
          ),
          trailing: IconButton(icon: Icon(Icons.edit), onPressed: () {}),
        ),
        Divider(),
        ListTile(
          onTap: () {
            print('email');
          },
          leading: Icon(
            Icons.email_outlined,
            size: 40,
          ),
          title: Text(
            'Email:',
            style: TextStyle(
              fontFamily: 'Rubik',
            ),
          ),
          subtitle: Text(
            usuario.email,
            style: TextStyle(
                fontFamily: 'Rubik', fontWeight: FontWeight.bold, fontSize: 16),
          ),
          trailing: IconButton(icon: Icon(Icons.edit), onPressed: () {}),
        ),
        Divider(),
        ListTile(
          onTap: () {
            print('password');
          },
          leading:
              Icon(Icons.lock_outline, size: 40, color: Colors.yellow[600]),
          //title: Text('Nombre:',style: TextStyle(fontFamily: 'Rubik',), ),
          title: Text(
            'Cambiar contraseña',
            style: TextStyle(
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.black54),
          ),
          trailing: IconButton(icon: Icon(Icons.edit), onPressed: () {}),
        ),
        Divider(),
        SizedBox(
          height: 10,
        ),
        ListTile(
          onTap: () {
            socketService.socket.emit('userConnected','desconectado');//TODO: ver la forma de retrasar el socket en el server
            socketService.disconnect();
            
            AuthService.deleteToken();
            
            Navigator.pushReplacementNamed(context, 'scroll');
          },
          leading: Icon(Icons.logout,
              size: 40, color: Color.fromRGBO(24, 121, 153, 1)),
          //title: Text('Nombre:',style: TextStyle(fontFamily: 'Rubik',), ),
          title: Text(
            'Cerrar Sesión',
            style: TextStyle(
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.black54),
          ),
        ),
      ],
    );
  }

  Future _seleccionarFoto() async {
    _procesarSolicitudImagen(ImageSource.gallery);
  }

  Future _tomarFoto() async {
    _procesarSolicitudImagen(ImageSource.camera);
  }

  Future _procesarSolicitudImagen(ImageSource origen) async {
    final pickedFile = await picker.getImage(source: origen);

    setState(() {
      if (pickedFile != null) {
        //producto.fotoUrl = null;
        _image = File(pickedFile.path);
        submit();
      } else {
        print('No image selected.');
      }
    });
  }

  void submit() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);
    final ok = await authService.subirImagen(_image);
    if (ok) {
      SweetAlert.show(context,
          title: 'Actualizado', style: SweetAlertStyle.success);
          socketService.socket.emit('userConnected', 'funciona');
    } else {
      SweetAlert.show(context,
          title: 'Error',
          subtitle: ok.toString(),
          style: SweetAlertStyle.error);
    }
  }
}
