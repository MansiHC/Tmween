class ProductListingModel {
  int? statusCode;
  String? statusMessage;
  String? message;
  Data? data;

  ProductListingModel(
      {this.statusCode, this.statusMessage, this.message, this.data});

  ProductListingModel.fromJson(Map<String, dynamic> json) {
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
  List<SearchProductData>? productData;
  int? totalPages;
  var next;
  var previous;
  int? totalRecords;

  Data(
      {this.productData,
      this.totalPages,
      this.next,
      this.previous,
      this.totalRecords});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['product_data'] != null) {
      productData = <SearchProductData>[];
      json['product_data'].forEach((v) {
        productData!.add(new SearchProductData.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    next = json['next'];
    previous = json['previous'];
    totalRecords = json['total_records'];
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
    return data;
  }
}

class SearchProductData {
  int? id;
  int? attributeSetId;
  int? productCategoryId;
  String? upc;
  String? sku;
  String? productName;
  String? finalPrice;
  String? retailPrice;
  int? stock;
  int? inStock;
  int? isCombinationAvailable;
  double? reviewsAvg;
  int? brandId;
  String? manufacturerNumber;
  String? countryCode;
  String? vehicleTypeCode;
  int? taxClass;
  String? shortDescription;
  String? longDescription;
  String? specification;
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
  int? percentage;
  String? productImage;
  String? prodImage;
  String? largeImageUrl;

  SearchProductData(
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
      this.isCombinationAvailable,
      this.reviewsAvg,
      this.brandId,
      this.manufacturerNumber,
      this.countryCode,
      this.vehicleTypeCode,
      this.taxClass,
      this.shortDescription,
      this.longDescription,
      this.specification,
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
      this.percentage,
      this.productImage,
      this.prodImage,
      this.largeImageUrl});

  SearchProductData.fromJson(Map<String, dynamic> json) {
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
    isCombinationAvailable = json['is_combination_available'];
    reviewsAvg = double.parse(json['reviews_avg'].toString());
    brandId = json['brand_id'];
    manufacturerNumber = json['manufacturer_number'];
    countryCode = json['country_code'];
    vehicleTypeCode = json['vehicle_type_code'];
    taxClass = json['tax_class'];
    shortDescription = json['short_description'];
    longDescription = json['long_description'];
    specification = json['specification'];
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
    percentage = json['percentage'];
    productImage = json['product_image'];
    prodImage = json['prod_image'];
    largeImageUrl = json['large_image_url'];
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
    data['is_combination_available'] = this.isCombinationAvailable;
    data['reviews_avg'] = this.reviewsAvg;
    data['brand_id'] = this.brandId;
    data['manufacturer_number'] = this.manufacturerNumber;
    data['country_code'] = this.countryCode;
    data['vehicle_type_code'] = this.vehicleTypeCode;
    data['tax_class'] = this.taxClass;
    data['short_description'] = this.shortDescription;
    data['long_description'] = this.longDescription;
    data['specification'] = this.specification;
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
    data['percentage'] = this.percentage;
    data['product_image'] = this.productImage;
    data['prod_image'] = this.prodImage;
    data['large_image_url'] = this.largeImageUrl;
    return data;
  }
}
