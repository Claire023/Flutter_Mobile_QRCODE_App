import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mspr/models/GuestPromoResponse.dart';
import 'package:mspr/models/Promo.dart';
import 'package:clipboard/clipboard.dart';



Dialog showModalPromo(BuildContext context, Promo promotion) {
  return Dialog(
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Container(
      height: 200.0,
      width: 200.0,
      child: ListView(
        //mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Padding(
              padding: EdgeInsets.all(5.0),
            ),
          ),
          Row(
            children: <Widget>[
              Text(
                promotion.title.toString(),
                style: TextStyle(fontSize: 16, color: Colors.grey),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Wrap(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        promotion.description.toString(),
                        style: TextStyle(color: Colors.grey[800], fontSize: 18.0)),
                  ],
                )
              ],
            ),
          ),
          Padding(

            padding: const EdgeInsets.only(left: 10, right: 10, top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
            ),
          ),
          IconButton(
            icon: Icon(Icons.content_copy),
            color:Colors.grey,
            onPressed: () async {
              await FlutterClipboard.copy(promotion.description.toString());

             Scaffold.of(context).showSnackBar(
            SnackBar(content: Text('✓ Code promo copié !')),
              );
          },

          ),
        ],
      ),
    ),
  );
}
