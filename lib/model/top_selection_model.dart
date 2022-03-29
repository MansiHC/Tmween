import 'package:tmween/model/dashboard_model.dart';

class TopSelectionModel {
  int? statusCode;
  String? statusMessage;
  String? message;
  Data? data;

  TopSelectionModel(
      {this.statusCode, this.statusMessage, this.message, this.data});

  TopSelectionModel.fromJson(Map<String, dynamic> json) {
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
  List<TopSelectionData>? topSelectionData;
  int? totalPages;
  var next;
  var previous;
  int? totalRecords;

  Data(
      {this.topSelectionData,
      this.totalPages,
      this.next,
      this.previous,
      this.totalRecords});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['top_selection_data'] != null) {
      topSelectionData = <TopSelectionData>[];
      json['top_selection_data'].forEach((v) {
        topSelectionData!.add(new TopSelectionData.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    next = json['next'];
    previous = json['previous'];
    totalRecords = json['total_records'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.topSelectionData != null) {
      data['top_selection_data'] =
          this.topSelectionData!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = this.totalPages;
    data['next'] = this.next;
    data['previous'] = this.previous;
    data['total_records'] = this.totalRecords;
    return data;
  }
}
