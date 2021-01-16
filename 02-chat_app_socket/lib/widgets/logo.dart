import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String text;
  final String assetImage;

  const Logo({Key key, @required this.text, @required this.assetImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            width: 200,
            height: 250,
            child: Image(
              image: AssetImage(assetImage),
            ),
          ),
          Text(
            this.text,
            style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'MajorMonoDisplay'),
          )
        ],
      ),
    );
  }
}
