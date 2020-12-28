import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:band_names_socket/services/socket_service.dart';

class StatusPage extends StatelessWidget {
  //const StatusPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Status Page:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(socketService.serverStatus.toString())
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.mail_outline),
        onPressed: () {
          socketService.socket.emit('mensaje',
              {'nombre': 'Flutter', 'mensaje': 'enviado desde FLutter'});
        },
      ),
    );
  }
}
