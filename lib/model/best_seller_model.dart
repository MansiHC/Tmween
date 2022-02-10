class BestSellerModel {
  const BestSellerModel(
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

  static fromJson(responseJson) {}
}

/*
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

  Data({this.bestSellerData});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['best_seller_data'] != null) {
      bestSellerData = <BestSellerData>[];
      json['best_seller_data'].forEach((v) {
        bestSellerData!.add(new BestSellerData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bestSellerData != null) {
      data['best_seller_data'] =
          this.bestSellerData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BestSellerData {
  int? id;
  int? attributeSetId;
  int? productCategoryId;
  String? upc;
  String? sku;
  String? productName;
  int? finalPrice;
  int? retailPrice;
  int? stock;
  int? inStock;
  int? reviewsAvg;
  int? brandId;
  String? manufacturerNumber;
  String? countryCode;
  String? vehicleTypeCode;
  int? taxClass;
  String? shortDescription;
  String? longDescription;
  String? image;
  int? isBestSellers;
  int? isTopSelection;
  int? autogenerateSeo;
  String? metaTitle;
  String? metaKeywords;
  String? metaDescription;
  Null? specialTransportId;
  int? weightUnitId;
  int? singleProductWeight;
  int? singleProductDimensionsUnitId;
  String? singleProductHeight;
  String? singleProductWidth;
  String? singleProductLength;
  int? packProductDimensionsUnitId;
  String? packProductHeight;
  String? packProductWidth;
  String? packProductLength;
  int? packProductWeightUnitId;
  int? packProductWeight;
  int? productInOnePack;
  int? expirable;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? attributeSetName;
  String? categoryName;
  String? productSlug;
  String? smallImageUrl;
  String? largeImageUrl;
  String? prodImage;
  int? discountPer;
  int? discountValue;
  String? discountPerDisp;
  String? discountValueDisp;
  String? retailPriceDisp;
  String? finalPriceDisp;

  BestSellerData(
      {this.id,
        this.attributeSetId,
        this.productCategoryId,
        this.upc,
        this.sku,
        this.productName,
        this.finalPrice,
        this.retailPrice,
        this.stock,
        this.inStock,
        this.reviewsAvg,
        this.brandId,
        this.manufacturerNumber,
        this.countryCode,
        this.vehicleTypeCode,
        this.taxClass,
        this.shortDescription,
        this.longDescription,
        this.image,
        this.isBestSellers,
        this.isTopSelection,
        this.autogenerateSeo,
        this.metaTitle,
        this.metaKeywords,
        this.metaDescription,
        this.specialTransportId,
        this.weightUnitId,
        this.singleProductWeight,
        this.singleProductDimensionsUnitId,
        this.singleProductHeight,
        this.singleProductWidth,
        this.singleProductLength,
        this.packProductDimensionsUnitId,
        this.packProductHeight,
        this.packProductWidth,
        this.packProductLength,
        this.packProductWeightUnitId,
        this.packProductWeight,
        this.productInOnePack,
        this.expirable,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.attributeSetName,
        this.categoryName,
        this.productSlug,
        this.smallImageUrl,
        this.largeImageUrl,
        this.prodImage,
        this.discountPer,
        this.discountValue,
        this.discountPerDisp,
        this.discountValueDisp,
        this.retailPriceDisp,
        this.finalPriceDisp});

  BestSellerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributeSetId = json['attribute_set_id'];
    productCategoryId = json['product_category_id'];
    upc = json['upc'];
    sku = json['sku'];
    productName = json['product_name'];
    finalPrice = json['final_price'];
    retailPrice = json['retail_price'];
    stock = json['stock'];
    inStock = json['in_stock'];
    reviewsAvg = json['reviews_avg'];
    brandId = json['brand_id'];
    manufacturerNumber = json['manufacturer_number'];
    countryCode = json['country_code'];
    vehicleTypeCode = json['vehicle_type_code'];
    taxClass = json['tax_class'];
    shortDescription = json['short_description'];
    longDescription = json['long_description'];
    image = json['image'];
    isBestSellers = json['is_best_sellers'];
    isTopSelection = json['is_top_selection'];
    autogenerateSeo = json['autogenerate_seo'];
    metaTitle = json['meta_title'];
    metaKeywords = json['meta_keywords'];
    metaDescription = json['meta_description'];
    specialTransportId = json['special_transport_id'];
    weightUnitId = json['weight_unit_id'];
    singleProductWeight = json['single_product_weight'];
    singleProductDimensionsUnitId = json['single_product_dimensions_unit_id'];
    singleProductHeight = json['single_product_height'];
    singleProductWidth = json['single_product_width'];
    singleProductLength = json['single_product_length'];
    packProductDimensionsUnitId = json['pack_product_dimensions_unit_id'];
    packProductHeight = json['pack_product_height'];
    packProductWidth = json['pack_product_width'];
    packProductLength = json['pack_product_length'];
    packProductWeightUnitId = json['pack_product_weight_unit_id'];
    packProductWeight = json['pack_product_weight'];
    productInOnePack = json['product_in_one_pack'];
    expirable = json['expirable'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    attributeSetName = json['attribute_set_name'];
    categoryName = json['category_name'];
    productSlug = json['product_slug'];
    smallImageUrl = json['small_image_url'];
    largeImageUrl = json['large_image_url'];
    prodImage = json['prod_image'];
    discountPer = json['discount_per'];
    discountValue = json['discount_value'];
    discountPerDisp = json['discount_per_disp'];
    discountValueDisp = json['discount_value_disp'];
    retailPriceDisp = json['retail_price_disp'];
    finalPriceDisp = json['final_price_disp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['attribute_set_id'] = this.attributeSetId;
    data['product_category_id'] = this.productCategoryId;
    data['upc'] = this.upc;
    data['sku'] = this.sku;
    data['product_name'] = this.productName;
    data['final_price'] = this.finalPrice;
    data['retail_price'] = this.retailPrice;
    data['stock'] = this.stock;
    data['in_stock'] = this.inStock;
    data['reviews_avg'] = this.reviewsAvg;
    data['brand_id'] = this.brandId;
    data['manufacturer_number'] = this.manufacturerNumber;
    data['country_code'] = this.countryCode;
    data['vehicle_type_code'] = this.vehicleTypeCode;
    data['tax_class'] = this.taxClass;
    data['short_description'] = this.shortDescription;
    data['long_description'] = this.longDescription;
    data['image'] = this.image;
    data['is_best_sellers'] = this.isBestSellers;
    data['is_top_selection'] = this.isTopSelection;
    data['autogenerate_seo'] = this.autogenerateSeo;
    data['meta_title'] = this.metaTitle;
    data['meta_keywords'] = this.metaKeywords;
    data['meta_description'] = this.metaDescription;
    data['special_transport_id'] = this.specialTransportId;
    data['weight_unit_id'] = this.weightUnitId;
    data['single_product_weight'] = this.singleProductWeight;
    data['single_product_dimensions_unit_id'] =
        this.singleProductDimensionsUnitId;
    data['single_product_height'] = this.singleProductHeight;
    data['single_product_width'] = this.singleProductWidth;
    data['single_product_length'] = this.singleProductLength;
    data['pack_product_dimensions_unit_id'] = this.packProductDimensionsUnitId;
    data['pack_product_height'] = this.packProductHeight;
    data['pack_product_width'] = this.packProductWidth;
    data['pack_product_length'] = this.packProductLength;
    data['pack_product_weight_unit_id'] = this.packProductWeightUnitId;
    data['pack_product_weight'] = this.packProductWeight;
    data['product_in_one_pack'] = this.productInOnePack;
    data['expirable'] = this.expirable;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['attribute_set_name'] = this.attributeSetName;
    data['category_name'] = this.categoryName;
    data['product_slug'] = this.productSlug;
    data['small_image_url'] = this.smallImageUrl;
    data['large_image_url'] = this.largeImageUrl;
    data['prod_image'] = this.prodImage;
    data['discount_per'] = this.discountPer;
    data['discount_value'] = this.discountValue;
    data['discount_per_disp'] = this.discountPerDisp;
    data['discount_value_disp'] = this.discountValueDisp;
    data['retail_price_disp'] = this.retailPriceDisp;
    data['final_price_disp'] = this.finalPriceDisp;
    return data;
  }
}
*/
