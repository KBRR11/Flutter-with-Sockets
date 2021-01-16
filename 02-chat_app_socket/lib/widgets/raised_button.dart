import 'package:flutter/material.dart';

class RaisedPersonalizado extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final Function onPressed;
  final FontWeight weight;
  final String fontFamiliy;
  final double width;

  const RaisedPersonalizado(
      {Key key,
      @required this.text,
      @required this.textColor,
      @required this.backgroundColor,
      @required this.onPressed,
      @required this.weight,
      @required this.fontFamiliy,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 2,
      color: backgroundColor,
      highlightElevation: 5,
      shape: StadiumBorder(),
      onPressed: onPressed,
      child: Container(
        width: width,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: textColor, //Color.fromRGBO(66, 141, 255, 1),
                fontFamily: fontFamiliy,
                fontWeight: weight),
          ),
        ),
      ),
    );
  }
}
