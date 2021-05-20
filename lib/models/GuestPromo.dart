import 'Promo.dart';
import 'Guest.dart';
import 'dart:convert';


GuestPromo guestPromoFromJson(String str)=> GuestPromo.fromJson(json.decode(str));
String guestPromoToJson(GuestPromo data) => json.encode(data.toJson());


class GuestPromo {
  GuestPromo({
    this.id,
    this.guest,
    this.promo,
  });

  int id;
  Guest guest;
  Promo promo;

  factory GuestPromo.fromJson(Map<String, dynamic> json) => GuestPromo(
    id: json["id"],
    guest: Guest.fromJson(json["guest"]),
    promo: Promo.fromJson(json["promo"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "guest": guest.toJson(),
    "promo": promo.toJson(),
  };
}

