import 'Guest.dart';

class Promo {
  Promo({
    this.id,
    this.title,
    this.description,
    this.code,
    this.startPromo,
    this.endPromo,
    this.partner,
  });

  int id;
  String title;
  String description;
  String code;
  DateTime startPromo;
  DateTime endPromo;
  Guest partner;

  factory Promo.fromJson(Map<String, dynamic> json) => Promo(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    code: json["code"],
    startPromo: DateTime.parse(json["startPromo"]),
    endPromo: DateTime.parse(json["endPromo"]),
    partner: Guest.fromJson(json["partner"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "code": code,
    "startPromo": startPromo.toIso8601String(),
    "endPromo": endPromo.toIso8601String(),
    "partner": partner.toJson(),
  };
}