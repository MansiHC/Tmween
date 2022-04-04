class GetReviewsModel {
  int? statusCode;
  String? statusMessage;
  String? message;
  Data? data;

  GetReviewsModel(
      {this.statusCode, this.statusMessage, this.message, this.data});

  GetReviewsModel.fromJson(Map<String, dynamic> json) {
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
  List<ReviewProductData>? reviewProductData;
  int? reviewCount;

  Data({this.reviewProductData, this.reviewCount});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['review_product_data'] != null) {
      reviewProductData = <ReviewProductData>[];
      json['review_product_data'].forEach((v) {
        reviewProductData!.add(new ReviewProductData.fromJson(v));
      });
    }
    reviewCount = json['review_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reviewProductData != null) {
      data['review_product_data'] =
          this.reviewProductData!.map((v) => v.toJson()).toList();
    }
    data['review_count'] = this.reviewCount;
    return data;
  }
}

class ReviewProductData {
  int? id;
  int? customerId;
  int? productId;
  String? reviewTitle;
  String? review;
  double? rating;
  String? ip;
  String? reviewDate;
  int? addedByType;
  int? addedById;
  int? status;
  Null? reviewApprovedDate;
  int? reviewApprovedId;
  String? createdAt;
  String? image;
  String? fullname;
  String? smallImageUrl;
  String? largeImageUrl;

  ReviewProductData(
      {this.id,
        this.customerId,
        this.productId,
        this.reviewTitle,
        this.review,
        this.rating,
        this.ip,
        this.reviewDate,
        this.addedByType,
        this.addedById,
        this.status,
        this.reviewApprovedDate,
        this.reviewApprovedId,
        this.createdAt,
        this.image,
        this.fullname,
        this.smallImageUrl,
        this.largeImageUrl});

  ReviewProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    productId = json['product_id'];
    reviewTitle = json['review_title'];
    review = json['review'];
    rating = double.parse(json['rating'].toString());
    ip = json['ip'];
    reviewDate = json['review_date'];
    addedByType = json['added_by_type'];
    addedById = json['added_by_id'];
    status = json['status'];
    reviewApprovedDate = json['review_approved_date'];
    reviewApprovedId = json['review_approved_id'];
    createdAt = json['created_at'];
    image = json['image'];
    fullname = json['fullname'];
    smallImageUrl = json['small_image_url'];
    largeImageUrl = json['large_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['product_id'] = this.productId;
    data['review_title'] = this.reviewTitle;
    data['review'] = this.review;
    data['rating'] = this.rating;
    data['ip'] = this.ip;
    data['review_date'] = this.reviewDate;
    data['added_by_type'] = this.addedByType;
    data['added_by_id'] = this.addedById;
    data['status'] = this.status;
    data['review_approved_date'] = this.reviewApprovedDate;
    data['review_approved_id'] = this.reviewApprovedId;
    data['created_at'] = this.createdAt;
    data['image'] = this.image;
    data['fullname'] = this.fullname;
    data['small_image_url'] = this.smallImageUrl;
    data['large_image_url'] = this.largeImageUrl;
    return data;
  }
}
