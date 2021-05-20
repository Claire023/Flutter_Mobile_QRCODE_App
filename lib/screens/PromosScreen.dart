import 'dart:async';
import 'dart:convert';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:mspr/models/GuestPromo.dart';
//import 'package:mspr/models/GuestPromo.dart';
import 'package:mspr/models/GuestPromoResponse.dart';
import 'package:mspr/screens/HomeScreen.dart';
import 'package:mspr/screens/ScanScreen.dart';
import 'package:http/http.dart' as http;


import '../navbar.dart';

class PromosScreen extends StatefulWidget {
  @override
  _PromosScreenState createState() => _PromosScreenState();
}

class _PromosScreenState extends State<PromosScreen> {

  List<GuestPromoResponse> guestPromoResponse = [];
  final double _borderRadius = 24;

  @override
  initState() {
    super.initState();
    displayPromos();
    Timer(Duration(seconds: 5), () => print("Splash screen display ! "));
  }




  Future <List<GuestPromo>> displayPromos() async {
    final response = await http.get("http://192.168.1.103.:8888/gostyle/guest/promo/1");
    //final response = await http.get("http://localhost:8888/gostyle/guest/promo/1");

    if (response.statusCode == 200) {
      final promoList = response.body;
      GuestPromoResponse promoListDecoded = GuestPromoResponse.fromJson(jsonDecode(promoList));
      return promoListDecoded.guestPromo;

    } else {
      return Future.error("erreur lors du decode");
    }
  }

  Future<Response> deletePromo(String id) async {
    print(id);
    print("id de promo");

      final response = await http.delete(
        'http://192.168.1.103.:8888/gostyle/guest/promo/delete/$id',
        //'http://localhost:8888/gostyle/guest/promo/delete/$id',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      return response;
  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Center(
        child:Text("Promos", style: GoogleFonts.permanentMarker()),
    key: Key('promosScreen'),
        )
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
        child : Center(
        child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: FutureBuilder <List<GuestPromo>>(
                future: displayPromos(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                        itemBuilder: (context, promotionIndex){
                          final promo = snapshot.data[promotionIndex];
                          print(promo.promo.description);
                          return Center(
                            child:Padding(
                              padding: const EdgeInsets.all(16.0),
                              child:Stack(
                                children:<Widget>[
                                  Container(
                                    height:150,
                                    decoration:BoxDecoration(
                                      borderRadius: BorderRadius.circular(_borderRadius),
                                     color: Colors.black54
                                    ),
                                  ),
                                  Positioned.fill(
                                      child: Row(
                                        children:<Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                              child:
                                              Text(
                                              promo.promo.code,
                                              style:TextStyle(
                                                fontFamily: 'Avenir',
                                                fontWeight: FontWeight.w700,
                                                  fontSize: 21,
                                                  color:Colors.purpleAccent
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex:3,
                                            child:Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children:<Widget>[
                                                Text(promo.promo.title,
                                                  style:TextStyle(
                                                    fontFamily: 'Avenir',
                                                    fontWeight:  FontWeight.w700
                                                  ),
                                                ),
                                                Text(promo.promo.description,
                                                style:TextStyle(
                                                  fontFamily:'Avenir',
                                                    //ligne 95
                                                ),
                                                ),
                                                Text("expire le : ${DateFormat('dd-MM-yyyy').format(promo.promo.endPromo)}"),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex:1,
                                            child:Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children:<Widget>[
                                                IconButton(
                                                  icon:Icon(Icons.delete_forever_outlined),
                                                  color:Colors.purpleAccent,
                                                  onPressed: () async {
                                                    await
                                                    setState(() {
                                                      deletePromo(promo.id.toString());
                                                    });

                                                    Scaffold.of(context)
                                                        .showSnackBar(
                                                      SnackBar(content: Text(
                                                          '✓ Promo supprimée !')),
                                                    );
                                                  }),
                                                IconButton(
                                                  icon: Icon(Icons.content_copy),
                                                  color:Colors.purpleAccent,

                                                  onPressed: () async {
                                                    await FlutterClipboard.copy(promo.promo.code);
                                                    Scaffold.of(context).showSnackBar(
                                                      SnackBar(content: Text('✓ Code promo copié !')),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ] ,
                                      ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        //return Text(promo.promo.description);
                        }
                    );

                  } else if (snapshot.hasError) {
                    return Text("erreur dans le builder");
                  } else {
                    return CircularProgressIndicator();
                  }
                })),

      ),
    ),
    );
  }




}







