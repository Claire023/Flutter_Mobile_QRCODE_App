import 'dart:async';
import 'dart:convert';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:mspr/models/GuestPromoResponse.dart';
import 'package:http/http.dart' as http;
import 'package:mspr/models/Promo.dart';
import 'package:mspr/modules/widgets/PromoModal.dart';


class ScanScreen extends StatefulWidget {
  @override
  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<ScanScreen> {
  String barcode = "";
  final double _borderRadius = 24;


  @override
  initState() {
    scan();
    super.initState();
    // getPromotionFromBarcode("2");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  AppBar(
          title: Center(
            child: Text('Scan Promos' ,style: GoogleFonts.permanentMarker()),
          ),
        ),
        body:  Container(
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
            child: Center(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),

                child: RaisedButton(
                    //borderRadius: BorderRadius.circular(_borderRadius),
                    key: Key('scannButton'),
                    color: Color(0xff000000),
                    textColor: Colors.white,
                    splashColor: Colors.blueGrey,
                    onPressed: scan,
                    child: Container(
                      child: Center(child: Text('Scanner une promotion')),
                      height: 150,
                    )
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  barcode,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        )
        ),);
  }

  void _showDialog(String content) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: new Text("Attention")),
            content: new Text(content),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Fermer"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }


  Future scan() async {
    Promo response;
    try {
      String barcode = await BarcodeScanner.scan();
      response = await this.getPromotionFromBarcode(barcode);

    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        this._showDialog(
            "Vous devez activez l\'application à accéder à votre appareil photo !");
      } else {
        // this._showDialog('Erreur interne: $e');
      }
      // this._showDialog("Une erreur est apparue");
    } catch (e) {
      if (e.toString().contains("subtype")) {
        return;
      }
      // this._showDialog("Une erreur est apparue: $e");
    }
  }



  Future getPromotionFromBarcode(String id) async {
    final response = await http.get(
       // "http://localhost:8888/gostyle/promo/" + id);
        "http://192.168.1.103.:8888/gostyle/promo/" + id);
    // final response = await utilitary.fetch('/product/getFromQrCodes/$id');
    if (response.statusCode == 200) {
      // Promotion promotion = Promotion.fromJson(jsonDecode(response.body));
      Promo promo = Promo.fromJson(jsonDecode(response.body));

      print(promo);
        _postPromo(promo.id);
        showDialog(
            context: context,
            builder: (BuildContext context) => showModalPromo(context, promo));
      print("reponse du scan");
      print(response.body);
      return response.body;
    }
  }


  //post promo in user list
  _postPromo(int id) async {
    // set up POST request arguments
   // String url = 'http://localhost:8888/gostyle/guest/promo/add';
    String url = 'http://192.168.1.103.:8888/gostyle/guest/promo/add';
    print("promo postée avec succes");
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = '{"guest": {"id": 1}, "promo": {"id": ${id}}}';
    // make POST request
    Response response = await post(url, headers: headers, body: json);
    // check the status code for the result
    int statusCode = response.statusCode;
    // this API passes back the id of the new item added to the body
    String body = response.body;

  }







}