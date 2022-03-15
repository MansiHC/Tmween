class StateModel {
 /* const StateModel({required this.name});

  final String name;

  static fromJson(responseJson) {
    return null;
  }
}*/
  int? statusCode;
  String? statusMessage;
  String? message;
  Data? data;

  StateModel({this.statusCode, this.statusMessage, this.message, this.data});

  StateModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    statusMessage = json['status_message'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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
  List<States>? state;

  Data({this.cardPerPage, this.state});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['card_per_page'] != null) {
      cardPerPage = <CardPerPage>[];
      json['card_per_page'].forEach((v) {
        cardPerPage!.add(new CardPerPage.fromJson(v));
      });
    }
    if (json['state'] != null) {
      state = <States>[];
      json['state'].forEach((v) {
        state!.add(new States.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cardPerPage != null) {
      data['card_per_page'] = this.cardPerPage!.map((v) => v.toJson()).toList();
    }
    if (this.state != null) {
      data['state'] = this.state!.map((v) => v.toJson()).toList();
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

class States {
  String? stateCode;
  String? stateName;
  String? countryCode;

  States({this.stateCode, this.stateName, this.countryCode});

  States.fromJson(Map<String, dynamic> json) {
    stateCode = json['state_code'];
    stateName = json['state_name'];
    countryCode = json['country_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state_code'] = this.stateCode;
    data['state_name'] = this.stateName;
    data['country_code'] = this.countryCode;
    return data;
  }
}
