import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Container(
            child: Text('Hello World'),
          ),
        ),
        floatingActionButton: FloatingActionButton(
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
                          Navigator.pop(context);
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 65,
                              width: 65,
                              child: Image(
                                image:
                                    AssetImage('assets/camara-fotografica.png'),
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
            child: Icon(Icons.add)),
      ),
    );
  }
}
