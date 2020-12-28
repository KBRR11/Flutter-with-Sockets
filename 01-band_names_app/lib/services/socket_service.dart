import 'package:flutter/material.dart';

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

  SocketService() {
    this._initConfig();
  }

  void _initConfig() {
    // Dart client
    this._socket = IO.io("http://192.168.1.4:3000/",
        IO.OptionBuilder().setTransports(['websocket']).build());

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
}
