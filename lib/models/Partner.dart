class Partner {

  int id;
  String brandName;
  String website;
  String logo;
  String siret;


  Partner(this.id, this.brandName, this.website, this.logo, this.siret);


  Partner.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        brandName = json['brandName'],
        website = json['website'],
        logo = json['logo'],
        siret = json['siret'];

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'brandName': brandName,
        'website': website,
        'logo': logo,
        'siret': siret,
      };

}