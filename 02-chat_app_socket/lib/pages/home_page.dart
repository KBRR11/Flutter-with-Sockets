import 'package:chat_app_socket/services/scroll_service.dart';
import 'package:chat_app_socket/widgets/raised_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  //const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
            children: [FondoGradiente(), Head(), Botones(), Condiciones()]));
  }
}

class Condiciones extends StatelessWidget {
  const Condiciones({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.95,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: GestureDetector(
          onTap: () {
            //TODO: crear page de condiciones
          },
          child: Center(
              child: Text(
            'Términos y condiciones de uso',
            style: TextStyle(
                fontFamily: 'DarkerGrotesque-Light',
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white60),
          )),
        ),
      ),
    );
  }
}

class Botones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scrollService = Provider.of<ScrollService>(context);
    return Positioned(
      top: 450,
      child: Container(
        width: MediaQuery.of(context).size.width,
        // color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedPersonalizado(
              backgroundColor: Colors.white,
              fontFamiliy: 'GlegooRegular',
              onPressed: () {
                scrollService.controller.animateToPage(0,
                    duration: Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn);
              },
              text: 'Login',
              textColor: Color.fromRGBO(24, 121, 153, 1),
              weight: FontWeight.bold,
              width: 100.0,
            ),
            SizedBox(
              width: 20.0,
            ),
            RaisedPersonalizado(
              backgroundColor: Colors.white,
              fontFamiliy: 'GlegooRegular',
              onPressed: () {
                scrollService.controller.animateToPage(2,
                    duration: Duration(seconds: 1),
                    curve: Curves.easeInToLinear);
              },
              text: 'Register',
              textColor: Color.fromRGBO(13, 160, 154, 1),
              weight: FontWeight.bold,
              width: 100.0,
            )
          ],
        ),
      ),
    );
  }
}

class Head extends StatelessWidget {
  const Head({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 130,
      child: Container(
        //height: 100,
        width: MediaQuery.of(context).size.width,
        //color: Colors.black,
        child: Column(
          children: [
            Container(
                width: 200,
                height: 200,
                //color: Colors.red,
                child: Image(
                  image: AssetImage('assets/globos-de-texto.png'),
                )),
            Text(
              'messenger',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'MajorMonoDisplay'),
            )
          ],
        ),
      ),
    );
  }
}

class FondoGradiente extends StatelessWidget {
  const FondoGradiente({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
            0.3,
            1.0
          ],
              colors: [
            Color.fromRGBO(24, 121, 153, 1),
            Color.fromRGBO(13, 160, 154, 1),
            //Colors.red
          ])),
    );
  }
}
