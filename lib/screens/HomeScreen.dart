import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui' as ui;
import '../navbar.dart';


class HomeScreen extends StatelessWidget {

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Center(
          child:
          Text("Accueil", style: GoogleFonts.permanentMarker())
      ),
      key: Key('homeScreen'),
    ),
    body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            tileMode: TileMode.mirror,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff75005a),
              Color(0xff000000),
            ],
            stops: [
              0,
              1,
            ],
          ),
          backgroundBlendMode: BlendMode.srcOver,
        ),
        child: Column(
          children :<Widget>[
            Image.asset('assets/images/sneakers.png'),
            Text("Bienvenue sur GoStyle", style: TextStyle(
                fontSize: 23,
                foreground: Paint()
                  ..shader = ui.Gradient.linear(
                    const Offset(0, 20),
                    const Offset(150, 20),
                    <Color>[
                      Colors.white,
                      Colors.white38
                    ],
                  ),
            ),
            ),
          ],


        )
    ),
  );
}

}