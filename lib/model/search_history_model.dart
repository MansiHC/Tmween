class SearchHistoryModel {
  int? statusCode;
  String? statusMessage;
  String? message;
  Data? data;

  SearchHistoryModel(
      {this.statusCode, this.statusMessage, this.message, this.data});

  SearchHistoryModel.fromJson(Map<String, dynamic> json) {
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
  List<SearchHistoryData>? searchHistoryData;

  Data({this.searchHistoryData});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['search_history_data'] != null) {
      searchHistoryData = <SearchHistoryData>[];
      json['search_history_data'].forEach((v) {
        searchHistoryData!.add(new SearchHistoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.searchHistoryData != null) {
      data['search_history_data'] =
          this.searchHistoryData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SearchHistoryData {
  int? id;
  String? keyword;
  int? searchCount;
  String? defaultLangCode;
  String? createdAt;
  String? updatedAt;
  int? userSearchKeywordId;
  int? searchByUserId;
  String? ip;

  SearchHistoryData(
      {this.id,
      this.keyword,
      this.searchCount,
      this.defaultLangCode,
      this.createdAt,
      this.updatedAt,
      this.userSearchKeywordId,
      this.searchByUserId,
      this.ip});

  SearchHistoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    keyword = json['keyword'];
    searchCount = json['search_count'];
    defaultLangCode = json['default_lang_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userSearchKeywordId = json['user_search_keyword_id'];
    searchByUserId = json['search_by_user_id'];
    ip = json['ip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['keyword'] = this.keyword;
    data['search_count'] = this.searchCount;
    data['default_lang_code'] = this.defaultLangCode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user_search_keyword_id'] = this.userSearchKeywordId;
    data['search_by_user_id'] = this.searchByUserId;
    data['ip'] = this.ip;
    return data;
  }
}
