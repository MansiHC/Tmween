class BannerModel {
  int? statusCode;
  String? statusMessage;
  String? message;
  Data? data;

  BannerModel({this.statusCode, this.statusMessage, this.message, this.data});

  BannerModel.fromJson(Map<String, dynamic> json) {
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
  List<TOP>? tOP;
  CENTER? cENTER;

  Data({this.tOP, this.cENTER});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['TOP'] != null) {
      tOP = <TOP>[];
      json['TOP'].forEach((v) {
        tOP!.add(new TOP.fromJson(v));
      });
    }
    cENTER =
        json['CENTER'] != null ? new CENTER.fromJson(json['CENTER']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tOP != null) {
      data['TOP'] = this.tOP!.map((v) => v.toJson()).toList();
    }
    if (this.cENTER != null) {
      data['CENTER'] = this.cENTER!.toJson();
    }
    return data;
  }
}

class TOP {
  int? id;
  String? title;
  String? bannerUrl;
  String? image;
  String? imgUrl;
  String? largeImageUrl;

  TOP(
      {this.id,
      this.title,
      this.bannerUrl,
      this.image,
      this.imgUrl,
      this.largeImageUrl});

  TOP.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    bannerUrl = json['banner_url'];
    image = json['image'];
    imgUrl = json['img_url'];
    largeImageUrl = json['large_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['banner_url'] = this.bannerUrl;
    data['image'] = this.image;
    data['img_url'] = this.imgUrl;
    data['large_image_url'] = this.largeImageUrl;
    return data;
  }
}

class CENTER {
  TOP? t4;
  TOP? t5;
  TOP? t6;

  CENTER({this.t4, this.t5, this.t6});

  CENTER.fromJson(Map<String, dynamic> json) {
    t4 = json['4'] != null ? new TOP.fromJson(json['4']) : null;
    t5 = json['5'] != null ? new TOP.fromJson(json['5']) : null;
    t6 = json['6'] != null ? new TOP.fromJson(json['6']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.t4 != null) {
      data['4'] = this.t4!.toJson();
    }
    if (this.t5 != null) {
      data['5'] = this.t5!.toJson();
    }
    if (this.t6 != null) {
      data['6'] = this.t6!.toJson();
    }
    return data;
  }
}
