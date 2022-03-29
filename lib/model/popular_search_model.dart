class PopularSearchModel {
  int? statusCode;
  String? statusMessage;
  String? message;
  Data? data;

  PopularSearchModel(
      {this.statusCode, this.statusMessage, this.message, this.data});

  PopularSearchModel.fromJson(Map<String, dynamic> json) {
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
  List<PopularSearches>? popularSearches;

  Data({this.popularSearches});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['popular_searches'] != null) {
      popularSearches = <PopularSearches>[];
      json['popular_searches'].forEach((v) {
        popularSearches!.add(new PopularSearches.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.popularSearches != null) {
      data['popular_searches'] =
          this.popularSearches!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PopularSearches {
  int? id;
  String? keyword;
  int? searchCount;
  String? defaultLangCode;
  String? createdAt;
  String? updatedAt;

  PopularSearches(
      {this.id,
        this.keyword,
        this.searchCount,
        this.defaultLangCode,
        this.createdAt,
        this.updatedAt});

  PopularSearches.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    keyword = json['keyword'];
    searchCount = json['search_count'];
    defaultLangCode = json['default_lang_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['keyword'] = this.keyword;
    data['search_count'] = this.searchCount;
    data['default_lang_code'] = this.defaultLangCode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
