import 'dashboard_model.dart';

class RecentlyViewdModel {
  const RecentlyViewdModel(
      {required this.title,
      required this.image,
      required this.offer,
      required this.rating,
      required this.fulfilled,
      required this.price,
      this.beforePrice});

  final String title;
  final String image;
  final String offer;
  final String rating;
  final bool fulfilled;
  final String price;
  final String? beforePrice;
}

class RecentlyViewedModel {
  int? statusCode;
  String? statusMessage;
  String? message;
  Data? data;

  RecentlyViewedModel(
      {this.statusCode, this.statusMessage, this.message, this.data});

  RecentlyViewedModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    statusMessage = json['status_message'];
    message = json['message'];
    if (statusCode == 200)
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
  List<RecentlyViewProduct>? recentlyViewProduct;
  int? totalPages;
  var next;
  var previous;
  int? totalRecords;

  Data(
      {this.recentlyViewProduct,
      this.totalPages,
      this.next,
      this.previous,
      this.totalRecords});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['recently_view_product'] != null) {
      recentlyViewProduct = <RecentlyViewProduct>[];
      json['recently_view_product'].forEach((v) {
        recentlyViewProduct!.add(new RecentlyViewProduct.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    next = json['next'];
    previous = json['previous'];
    totalRecords = json['total_records'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.recentlyViewProduct != null) {
      data['recently_view_product'] =
          this.recentlyViewProduct!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = this.totalPages;
    data['next'] = this.next;
    data['previous'] = this.previous;
    data['total_records'] = this.totalRecords;
    return data;
  }
}
