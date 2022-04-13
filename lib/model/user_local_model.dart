class UserLocalModel {
  String? id;
  String? fullname;
  String? countryName;
  String? stateName;
  String? cityName;
  String? largeImageUrl;
  String? mobile1;
  String? zip;
  String? phone;
  String? email;
  String? yourName;
  String? image;

  UserLocalModel(
      {this.id,
      this.fullname,
      this.mobile1,
      this.zip,
      this.yourName,
      this.phone,
      this.email,
      this.image,
      this.countryName,
      this.stateName,
      this.cityName,
      this.largeImageUrl});

  UserLocalModel.fromMap(Map map) {
    id = map[id];
    fullname = map[fullname];
    mobile1 = map[mobile1];
    zip = map[zip];
    yourName = map[yourName];
    phone = map[phone];
    email = map[email];
    image = map[image];
    countryName = map[countryName];
    stateName = map[stateName];
    cityName = map[cityName];
    largeImageUrl = map[largeImageUrl];
  }
}
