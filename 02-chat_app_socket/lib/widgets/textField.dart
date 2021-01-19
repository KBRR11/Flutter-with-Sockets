import 'package:flutter/material.dart';

class TextFieldCustomized extends StatelessWidget {
  //const TextFieldCustomized({Key key}) : super(key: key);
  final String placeholder;
  final IconData icon;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final bool isPassword;
  final Function onChanged;

  const TextFieldCustomized(
      {Key key,
      @required this.placeholder,
      @required this.icon,
      @required this.textController,
      this.keyboardType = TextInputType.text,
      this.isPassword = false,
      this.onChanged
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 20),
        margin: EdgeInsets.only(bottom: 20.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: Offset(0, 5),
                  blurRadius: 5)
            ]),
        child: TextField(
          controller: textController,
          onChanged: onChanged,
          style: TextStyle(fontFamily: 'GlegooRegular'),
          autocorrect: false,
          keyboardType: keyboardType,
          obscureText: isPassword,
          decoration: InputDecoration(
              prefixIcon: Icon(icon),
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
              //prefixStyle: TextStyle(fontFamily: 'GlegooRegular'),
              hintStyle: TextStyle(fontFamily: 'GlegooRegular'),
              hintText: placeholder),
        ));
  }
}
