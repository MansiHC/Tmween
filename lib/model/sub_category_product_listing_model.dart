class SubCategoryProductListingModel {
  int? statusCode;
  String? statusMessage;
  String? message;
  Data? data;

  SubCategoryProductListingModel(
      {this.statusCode, this.statusMessage, this.message, this.data});

  SubCategoryProductListingModel.fromJson(Map<String, dynamic> json) {
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
  List<ProductData>? productData;
  int? totalPages;
  var next;
  var previous;
  int? totalRecords;
  int? maxPrice;

  Data(
      {this.productData,
        this.totalPages,
        this.next,
        this.previous,
        this.totalRecords,
        this.maxPrice});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['product_data'] != null) {
      productData = <ProductData>[];
      json['product_data'].forEach((v) {
        productData!.add(new ProductData.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    next = json['next'];
    previous = json['previous'];
    totalRecords = json['total_records'];
    maxPrice = json['max_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.productData != null) {
      data['product_data'] = this.productData!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = this.totalPages;
    data['next'] = this.next;
    data['previous'] = this.previous;
    data['total_records'] = this.totalRecords;
    data['max_price'] = this.maxPrice;
    return data;
  }
}

class ProductData {
  int? id;
  int? attributeSetId;
  int? productCategoryId;
  String? productName;
  int? finalPrice;
  int? retailPrice;
  double? reviewsAvg;
  String? productSlug;
  String? largeImageUrl;

  int? discountValuePercentage;
  int? discountValue;
  String? discountValueDisp;
  String? retailPriceDisp;
  String? finalPriceDisp;


  ProductData(
      {this.id,
        this.attributeSetId,
        this.productCategoryId,
        this.productName,
        this.finalPrice,
        this.retailPrice,
        this.reviewsAvg,

        this.productSlug,
        this.largeImageUrl,
        this.discountValuePercentage,
        this.discountValue,
        this.discountValueDisp,
        this.retailPriceDisp,
        this.finalPriceDisp});

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributeSetId = json['attribute_set_id'];
    productCategoryId = json['product_category_id'];
    productName = json['product_name'];
    finalPrice = json['final_price'];
    retailPrice = json['retail_price'];
    reviewsAvg = double.parse(json['reviews_avg'].toString());

    productSlug = json['product_slug'];
    largeImageUrl = json['large_image_url'];
    discountValuePercentage = json['discount_value_percentage'];
    discountValue = json['discount_value'];
    discountValueDisp = json['discount_value_disp'];
    retailPriceDisp = json['retail_price_disp'];
    finalPriceDisp = json['final_price_disp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['attribute_set_id'] = this.attributeSetId;
    data['product_category_id'] = this.productCategoryId;
    data['product_name'] = this.productName;
    data['final_price'] = this.finalPrice;
    data['retail_price'] = this.retailPrice;
    data['reviews_avg'] = this.reviewsAvg;

    data['product_slug'] = this.productSlug;
    data['large_image_url'] = this.largeImageUrl;
    data['discount_value_percentage'] = this.discountValuePercentage;
    data['discount_value'] = this.discountValue;
    data['discount_value_disp'] = this.discountValueDisp;
    data['retail_price_disp'] = this.retailPriceDisp;
    data['final_price_disp'] = this.finalPriceDisp;
    return data;
  }
}
