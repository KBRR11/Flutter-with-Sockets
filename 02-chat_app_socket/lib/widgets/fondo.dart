import 'package:flutter/material.dart';

class Fondo extends StatelessWidget {
  final Color background;

  const Fondo({Key key, @required this.background}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: background,
    );
  }
}
