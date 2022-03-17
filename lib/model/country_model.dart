class CountryModel {
/*  const CountryModel({required this.name});

  final String name;

  static fromJson(responseJson) {
    return null;
  }
}*/
  int? statusCode;
  String? statusMessage;
  String? message;
  Data? data;

  CountryModel({this.statusCode, this.statusMessage, this.message, this.data});

  CountryModel.fromJson(Map<String, dynamic> json) {
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
  List<Country>? country;

  Data({this.cardPerPage, this.country});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['card_per_page'] != null) {
      cardPerPage = <CardPerPage>[];
      json['card_per_page'].forEach((v) {
        cardPerPage!.add(new CardPerPage.fromJson(v));
      });
    }
    if (json['country'] != null) {
      country = <Country>[];
      json['country'].forEach((v) {
        country!.add(new Country.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cardPerPage != null) {
      data['card_per_page'] = this.cardPerPage!.map((v) => v.toJson()).toList();
    }
    if (this.country != null) {
      data['country'] = this.country!.map((v) => v.toJson()).toList();
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

class Country {
  String? countryCode;
  String? countryName;

  Country({this.countryCode, this.countryName});

  Country.fromJson(Map<String, dynamic> json) {
    countryCode = json['country_code'];
    countryName = json['country_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country_code'] = this.countryCode;
    data['country_name'] = this.countryName;
    return data;
  }
}
