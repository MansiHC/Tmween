class GetSubCategoryModel {
  int? statusCode;
  String? statusMessage;
  String? message;
  Data? data;

  GetSubCategoryModel(
      {this.statusCode, this.statusMessage, this.message, this.data});

  GetSubCategoryModel.fromJson(Map<String, dynamic> json) {
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
  List<SubCategoryData>? subCategoryData;

  Data({this.subCategoryData});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['sub_category_data'] != null) {
      subCategoryData = <SubCategoryData>[];
      json['sub_category_data'].forEach((v) {
        subCategoryData!.add(new SubCategoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subCategoryData != null) {
      data['sub_category_data'] =
          this.subCategoryData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategoryData {
  int? id;
  int? parentId;
  String? subcategoryName;
  String? slugName;
  String? largeImageUrl;

  SubCategoryData(
      {this.id,
      this.parentId,
      this.subcategoryName,
      this.slugName,
      this.largeImageUrl});

  SubCategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    subcategoryName = json['subcategory_name'];
    slugName = json['slug_name'];
    largeImageUrl = json['large_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['subcategory_name'] = this.subcategoryName;
    data['slug_name'] = this.slugName;
    data['large_image_url'] = this.largeImageUrl;

    return data;
  }
}
