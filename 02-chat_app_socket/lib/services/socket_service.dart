import 'package:chat_app_socket/services/auth_service.dart';
import 'package:flutter/material.dart';

import 'package:chat_app_socket/global/enviroment.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IconData _iconStatus = Icons.cloud_queue;
  Color _colorIcono = Colors.yellow[700];
  IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus;
  IconData get iconStatus => this._iconStatus;
  Color get colorIcono => this._colorIcono;
  IO.Socket get socket => this._socket;

  

  void connect(String userEmail) async{
    // Dart client
   final token =  await AuthService.getToken();

    this._socket = IO.io(Enviroment.socketUrl,
        /*IO.OptionBuilder().setTransports(['websocket']).build()*/
        {
          'transports'  : ['websocket'],
          'autoConnect' : true,
          'forceNew'    : true,
          'extraHeaders': {
            'useremail': userEmail,
            'x-token' : token
          }
        }
        );
    
    /// CUANDO EL SOCKET CONECTA
    this._socket.onConnect((_) {
      print('CONECTADO'); //TODO: Borrar Print
      
      this._serverStatus = ServerStatus.Online;
      this._iconStatus = Icons.cloud_done;
      this._colorIcono = Colors.blue[300];
      notifyListeners();
    });
    this._socket.onConnectError((data) => print('ERRORonConnect: $data'));
    this._socket.onError((data) => print('ERROR: $data'));

    this._socket.onDisconnect((_) {
      print('DESCONECTADO'); //TODO: Borrar Print
      this._serverStatus = ServerStatus.Offline;
      this._iconStatus = Icons.cloud_off;
      this._colorIcono = Colors.red;
      notifyListeners();
    });

    this._socket.emit('mensaje', {'user': 'mobile'});
  }


  void disconnect(){
    this._socket.disconnect();
  }
}