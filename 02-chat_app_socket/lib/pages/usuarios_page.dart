import 'package:chat_app_socket/services/messages_service.dart';
import 'package:chat_app_socket/services/socket_service.dart';
import 'package:chat_app_socket/services/usuarios_service.dart';
import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat_app_socket/models/usuario.dart';

class UsuariosPage extends StatefulWidget {
  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
      SocketService socketService;
      
@override
  void initState() {
    this.socketService = Provider.of<SocketService>(context, listen: false);
    
    socketService.socket.on('refresh', (data) {

      setState(() {
      //print('me actualizo');
      refreshListUser();        
      });
    });
    refreshListUser();
    super.initState();
  }

  @override
  void dispose() {
    socketService.socket.off('refresh');
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final usuariosService = Provider.of<UsuariosService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: _cargarUsers,
          header: WaterDropHeader(
            complete: Icon(
              Icons.check,
              color: Colors.blue[400],
            ),
            waterDropColor: Colors.blue[400],
          ),
          child: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [_CrearAppBar(), _userSliverList(context)]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          //await usuariosService.refreshList();
         
         
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  _cargarUsers() async {
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  SliverList _userSliverList(BuildContext context) {
     final usuariosService = Provider.of<UsuariosService>(context);   
        //refreshListUser(); // hace un bucle : falso socket
      
    return SliverList(
      delegate: SliverChildBuilderDelegate((_, i) {
        return _userListTile(context, usuariosService.usuarios[i], i);
      }, childCount: usuariosService.usuarios.length),
    );
  }

  refreshListUser()async{
    final usuariosService = Provider.of<UsuariosService>(context, listen: false);   
        await usuariosService.refreshList();
  }

 

  FadeInLeft _userListTile(BuildContext context, Usuario usuario, int i) {
    return FadeInLeft(
      duration: Duration(milliseconds: 500),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
            final messageService = Provider.of<MessagesService>(context, listen:false);
            messageService.usuarioPara = usuario;  
            Navigator.pushNamed(context, 'chat');

            }, 
            child: ListTile(
              tileColor: Colors.white,
              leading: CircleAvatar(
                backgroundColor: Colors.white30,
                radius: 30,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: FadeInImage(
                    height: 56,
                    width: 56,
                    fit: BoxFit.cover,
                    placeholder: AssetImage('assets/preload.gif'),
                    image:(usuario.fotoUrl=='')
                       ? AssetImage('assets/usuario.png')
                       :NetworkImage(usuario.fotoUrl),
                  ),
                ),
              ),
              title: Text(
                usuario.nombre,
                style:
                    TextStyle(fontFamily: 'Rubik', fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint Occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum',
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Icon(
                Icons.lens,
                color: (usuario.online) ? Colors.green : Colors.red,
                size: 15,
              ),
            ),
          ),
          Divider()
        ],
      ),
    );
  }
}

class _CrearAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
final socketService = Provider.of<SocketService>(context);
    return SliverAppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        expandedHeight: 130,
        floating: false,
        pinned: true,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 20),
            //width: 20,
            //height: 20,
            //color: Colors.red,
            child: IconButton(
                icon: Icon(
                  Icons.search,
                  size: 30,
                ),
                color: Colors.black87,
                onPressed: () {
                  print('buscar');
                }),
          )
        ],
        flexibleSpace: FlexibleSpaceBar(
          titlePadding: EdgeInsets.only(left: 30, bottom: 12),
          title: Row(
            children: [
              FadeInDown(
                              child: Text(
                  'Messages',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w600,
                      fontSize: 29),
                ),
              ),
              SizedBox(width: 5,),
               FadeInUp(
                 
                 child: Icon(socketService.iconStatus, color: socketService.colorIcono,))
            ],
          ),
        ));
  }
}
