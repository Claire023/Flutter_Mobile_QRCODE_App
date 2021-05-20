
class Guest {
  Guest({
    this.id,
  });

  int id;

  factory Guest.fromJson(Map<String, dynamic> json) => Guest(
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
  };
}