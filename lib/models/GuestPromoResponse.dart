/*
import 'dart:convert';
import 'GuestPromo.dart';


GuestPromoResponse guestPromoResponseFromJson(String str) => GuestPromoResponse.fromJson(json.decode(str));

String guestPromoResponse(GuestPromo data) => json.encode(data.toJson());


class GuestPromoResponse {
  String id;
  String username;
  List<GuestPromo> guestPromo;

  GuestPromoResponse({
    this.id,
    this.username,
    this.guestPromo,

  });


  factory GuestPromoResponse.fromJson(Map<String, dynamic> json) => GuestPromoResponse(
    id: json["id"],
    username: json["username"],
    guestPromo: List<GuestPromo>.from(json["guestPromo"].map((x) => GuestPromo.fromJson(x))),
  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "guestPromo": List<dynamic>.from(guestPromo.map((x) => x.toJson())),
  };
}

*/


// To parse this JSON data, do
//
//     final guestPromoResponse = guestPromoResponseFromJson(jsonString);
import 'dart:convert';
import 'Guest.dart';
import 'GuestPromo.dart';
import 'Promo.dart';

GuestPromoResponse guestPromoResponseFromJson(String str) => GuestPromoResponse.fromJson(json.decode(str));

String guestPromoResponseToJson(GuestPromoResponse data) => json.encode(data.toJson());

class GuestPromoResponse {
  GuestPromoResponse({
    this.id,
    this.username,
    this.guestPromo,
  });

  int id;
  String username;
  List<GuestPromo> guestPromo;

  GuestPromoResponse.fromJson(Map<String, dynamic> json) {
    id =  json["id"];
    username = json["username"];
    guestPromo = new List<GuestPromo>();
    json["guestPromo"].forEach((v){
      guestPromo.add(new GuestPromo.fromJson(v));

    });

  }

  Map<String, dynamic> toJson() => {
    "id" : id,
    "username": username,
    "guestPromo": List<dynamic>.from(guestPromo.map((x) => x.toJson()).toList()),

  };
}



