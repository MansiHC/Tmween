import 'dashboard_model.dart';

class BestSellerModel {
  int? statusCode;
  String? statusMessage;
  String? message;
  Data? data;

  BestSellerModel(
      {this.statusCode, this.statusMessage, this.message, this.data});

  BestSellerModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    statusMessage = json['status_message'];
    message = json['message'];
    if(statusCode==200)
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
  List<BestSellerData>? bestSellerData;
  int? totalPages;
  var next;
  var previous;
  int? totalRecords;

  Data({this.bestSellerData,
    this.totalPages,
    this.next,
    this.previous,
    this.totalRecords});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['best_seller_data'] != null) {
      bestSellerData = <BestSellerData>[];
      json['best_seller_data'].forEach((v) {
        bestSellerData!.add(new BestSellerData.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    next = json['next'];
    previous = json['previous'];
    totalRecords = json['total_records'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bestSellerData != null) {
      data['best_seller_data'] =
          this.bestSellerData!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = this.totalPages;
    data['next'] = this.next;
    data['previous'] = this.previous;
    data['total_records'] = this.totalRecords;
    return data;
  }
}

