import 'dart:io';

import 'package:band_names_socket/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  //const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'ACDC', votes: 5),
    Band(id: '2', name: 'Queen', votes: 5),
    Band(id: '3', name: 'Metallica', votes: 5),
    Band(id: '4', name: 'Red Hot Chili Peppers', votes: 100),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          'BandNames',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: bands.length,
          itemBuilder: (BuildContext context, int index) =>
              _bandTile(bands[index])),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addnewband();
        },
        child: Icon(Icons.add),
        elevation: 1,
      ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        //TODO: llamar el metodo borrar en el server
      },
      background: Container(
        child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                SizedBox(
                  width: 10.0,
                ),
                Icon(
                  Icons.delete_outline,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  'Delete ${band.name}',
                  style: TextStyle(color: Colors.white),
                )
              ],
            )),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: FractionalOffset(0.0, 1.0),
                end: FractionalOffset(0.5, 1.0),
                colors: [
              Colors.red,
              Theme.of(context).scaffoldBackgroundColor
            ])),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${band.votes}',
              style: TextStyle(fontSize: 20),
            ),
            Icon(
              Icons.star_border_rounded,
              color: Colors.yellow[600],
            ),
          ],
        ),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }

  addnewband() {
    final TextEditingController textController = new TextEditingController();

    if (Platform.isIOS) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Agregar nueva Banda:'),
              content: TextField(
                controller: textController,
              ),
              actions: [
                MaterialButton(
                    child: Text('Agregar'),
                    elevation: 5,
                    textColor: Colors.blue,
                    onPressed: () {
                      addBandToList(textController.text);
                    })
              ],
            );
          });
    }

    showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: Text('Agregar nueva Banda:'),
            content: CupertinoTextField(
              controller: textController,
            ),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text('Agregar'),
                onPressed: () => addBandToList(textController.text),
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                child: Text('cancelar'),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        });
  }

  void addBandToList(String name) {
    if (name.length > 2) {
      this
          .bands
          .add(new Band(id: DateTime.now().toString(), name: name, votes: 0));
      setState(() {});
    }
    Navigator.pop(context);
  }
}
