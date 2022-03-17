class CityModel {
  /*const CityModel({required this.name});

  final String name;

  static fromJson(responseJson) {
    return null;
  }
}*/
  int? statusCode;
  String? statusMessage;
  String? message;
  Data? data;

  CityModel({this.statusCode, this.statusMessage, this.message, this.data});

  CityModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    statusMessage = json['status_message'];
    message = json['message'];
    if (statusCode == 200) {
      data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['status_message'] = this.statusMessage;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<CardPerPage>? cardPerPage;
  List<City>? city;

  Data({this.cardPerPage, this.city});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['card_per_page'] != null) {
      cardPerPage = <CardPerPage>[];
      json['card_per_page'].forEach((v) {
        cardPerPage!.add(new CardPerPage.fromJson(v));
      });
    }
    if (json['city'] != null) {
      city = <City>[];
      json['city'].forEach((v) {
        city!.add(new City.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cardPerPage != null) {
      data['card_per_page'] = this.cardPerPage!.map((v) => v.toJson()).toList();
    }
    if (this.city != null) {
      data['city'] = this.city!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CardPerPage {
  String? value;

  CardPerPage({this.value});

  CardPerPage.fromJson(Map<String, dynamic> json) {
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    return data;
  }
}

class City {
  String? cityCode;
  String? cityName;
  String? stateCode;
  String? countryCode;

  City({this.cityCode, this.cityName, this.stateCode, this.countryCode});

  City.fromJson(Map<String, dynamic> json) {
    cityCode = json['city_code'];
    cityName = json['city_name'];
    stateCode = json['state_code'];
    countryCode = json['country_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city_code'] = this.cityCode;
    data['city_name'] = this.cityName;
    data['state_code'] = this.stateCode;
    data['country_code'] = this.countryCode;
    return data;
  }
}
