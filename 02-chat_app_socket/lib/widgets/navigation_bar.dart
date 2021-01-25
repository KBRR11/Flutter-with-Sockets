import 'package:chat_app_socket/pages/config_user.dart';
import 'package:chat_app_socket/pages/usuarios_page.dart';
import 'package:chat_app_socket/services/scroll_service.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';

void main() => runApp(MaterialApp(home: BottomNavBar()));

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    
    //bool origen = ModalRoute.of(context).settings.arguments;
    int _page = 0;
    final scrollService = Provider.of<ScrollService>(context);
    return Scaffold(
        
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,//TODO: se borra el bool : revisar Bug
          height: 50.0,
          items: <Widget>[
            Icon(
              Icons.chat_bubble_outline,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.perm_identity,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.settings,
              size: 30,
              color: Colors.white,
            ),
          ],
          color: Color.fromRGBO(24, 121, 153, 1),
          buttonBackgroundColor: Colors.yellow[600],//Color.fromRGBO(13, 160, 154, 1)
          backgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _page = index;
              scrollService.controllerLogin.animateToPage(_page,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInToLinear);
            });
          },
          letIndexChange: (index) => true,
        ),
        body: PageView(
          controller: scrollService.controllerLogin,
          
          children: [
            UsuariosPage(),
            Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
                child: Center(
                  child: Text('page 1'),
                )),
            ConfigUsuario()
          ],
        ));
  }
}
//Container(
//          color: Colors.blueAccent,
//          child: Center(
//            child: Column(
//              children: <Widget>[
//                Text(_page.toString(), textScaleFactor: 10.0),
//                RaisedButton(
//                  child: Text('Go To Page of index 1'),
//                  onPressed: () {
//                    final CurvedNavigationBarState navBarState =
//                        _bottomNavigationKey.currentState;
//                    navBarState.setPage(2);
//                  },
//                )
//              ],
//            ),
//          ),
//        )
