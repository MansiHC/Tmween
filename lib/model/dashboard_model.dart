class DashboardModel {
  int? statusCode;
  String? statusMessage;
  String? message;
  Data? data;

  DashboardModel(
      {this.statusCode, this.statusMessage, this.message, this.data});

  DashboardModel.fromJson(Map<String, dynamic> json) {
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
  List<RecentlyViewProduct>? recentlyViewProduct;
  List<TopSelectionData>? topSelectionData;
  List<SoldByTmweenProductData>? soldByTmweenProductData;
  List<BestSellerData>? bestSellerData;
  List<DailyDealsData>? dailyDealsData;
  List<ShopByCategory>? shopByCategory;
  Banners? banners;

  Data(
      {this.shopByCategory,
      this.dailyDealsData,
      this.bestSellerData,
      this.soldByTmweenProductData,
      this.topSelectionData,
      this.recentlyViewProduct,
      this.banners});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['recently_view_product'] != null) {
      recentlyViewProduct = <RecentlyViewProduct>[];
      json['recently_view_product'].forEach((v) {
        recentlyViewProduct!.add(new RecentlyViewProduct.fromJson(v));
      });
    }

    if (json['top_selection_data'] != null) {
      topSelectionData = <TopSelectionData>[];
      json['top_selection_data'].forEach((v) {
        topSelectionData!.add(new TopSelectionData.fromJson(v));
      });
    }

    if (json['sold_by_tmween_product_data'] != null) {
      soldByTmweenProductData = <SoldByTmweenProductData>[];
      json['sold_by_tmween_product_data'].forEach((v) {
        soldByTmweenProductData!.add(new SoldByTmweenProductData.fromJson(v));
      });
    }

    if (json['best_seller_data'] != null) {
      bestSellerData = <BestSellerData>[];
      json['best_seller_data'].forEach((v) {
        bestSellerData!.add(new BestSellerData.fromJson(v));
      });
    }

    if (json['daily_deals_data'] != null) {
      dailyDealsData = <DailyDealsData>[];
      json['daily_deals_data'].forEach((v) {
        dailyDealsData!.add(new DailyDealsData.fromJson(v));
      });
    }
    if (json['shop_by_category'] != null) {
      shopByCategory = <ShopByCategory>[];
      json['shop_by_category'].forEach((v) {
        shopByCategory!.add(new ShopByCategory.fromJson(v));
      });
    }
    banners =
        json['banners'] != null ? new Banners.fromJson(json['banners']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.recentlyViewProduct != null) {
      data['recently_view_product'] =
          this.recentlyViewProduct!.map((v) => v.toJson()).toList();
    }

    if (this.topSelectionData != null) {
      data['top_selection_data'] =
          this.topSelectionData!.map((v) => v.toJson()).toList();
    }

    if (this.soldByTmweenProductData != null) {
      data['sold_by_tmween_product_data'] =
          this.soldByTmweenProductData!.map((v) => v.toJson()).toList();
    }

    if (this.bestSellerData != null) {
      data['best_seller_data'] =
          this.bestSellerData!.map((v) => v.toJson()).toList();
    }

    if (this.dailyDealsData != null) {
      data['daily_deals_data'] =
          this.dailyDealsData!.map((v) => v.toJson()).toList();
    }
    if (this.shopByCategory != null) {
      data['shop_by_category'] =
          this.shopByCategory!.map((v) => v.toJson()).toList();
    }
    if (this.banners != null) {
      data['banners'] = this.banners!.toJson();
    }
    return data;
  }
}

class SoldByTmweenProductData {
  int? id;
  int? attributeSetId;
  int? productCategoryId;
  String? upc;
  String? sku;
  String? productName;
  var finalPrice;
  var retailPrice;
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
  int? specialTransportId;
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
  String? productSlug;
  String? startDate;
  String? endDate;
  String? smallImageUrl;
  String? largeImageUrl;
  String? prodImage;
  int? discountPerDisp;
  int? discountPer;
  int? discountValue;
  var discountValueDisp;
  var retailPriceDisp;
  var finalPriceDisp;
  List<TopLeftCaptionArr>? topLeftCaptionArr;
  List<TopRightCaptionArr>? topRightCaptionArr;
  List<BottomLeftCaptionArr>? bottomLeftCaptionArr;

  SoldByTmweenProductData(
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
      this.productSlug,
      this.startDate,
      this.endDate,
      this.smallImageUrl,
      this.largeImageUrl,
      this.prodImage,
      this.discountPerDisp,
      this.discountPer,
      this.discountValue,
      this.discountValueDisp,
      this.retailPriceDisp,
      this.finalPriceDisp,
      this.topLeftCaptionArr,
      this.topRightCaptionArr,
      this.bottomLeftCaptionArr});

  SoldByTmweenProductData.fromJson(Map<String, dynamic> json) {
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
    productSlug = json['product_slug'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    smallImageUrl = json['small_image_url'];
    largeImageUrl = json['large_image_url'];
    prodImage = json['prod_image'];
    discountPerDisp = json['discount_per_disp'];
    discountPer = json['discount_per'];
    discountValue = json['discount_value'];
    discountValueDisp = json['discount_value_disp'];
    retailPriceDisp = json['retail_price_disp'];
    finalPriceDisp = json['final_price_disp'];
    if (json['topLeftCaptionArr'] != null) {
      topLeftCaptionArr = <TopLeftCaptionArr>[];
      json['topLeftCaptionArr'].forEach((v) {
        topLeftCaptionArr!.add(new TopLeftCaptionArr.fromJson(v));
      });
    }
    if (json['topRightCaptionArr'] != null) {
      topRightCaptionArr = <TopRightCaptionArr>[];
      json['topRightCaptionArr'].forEach((v) {
        topRightCaptionArr!.add(new TopRightCaptionArr.fromJson(v));
      });
    }
    if (json['bottomLeftCaptionArr'] != null) {
      bottomLeftCaptionArr = <BottomLeftCaptionArr>[];
      json['bottomLeftCaptionArr'].forEach((v) {
        bottomLeftCaptionArr!.add(new BottomLeftCaptionArr.fromJson(v));
      });
    }
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
    data['product_slug'] = this.productSlug;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['small_image_url'] = this.smallImageUrl;
    data['large_image_url'] = this.largeImageUrl;
    data['prod_image'] = this.prodImage;
    data['discount_per_disp'] = this.discountPerDisp;
    data['discount_per'] = this.discountPer;
    data['discount_value'] = this.discountValue;
    data['discount_value_disp'] = this.discountValueDisp;
    data['retail_price_disp'] = this.retailPriceDisp;
    data['final_price_disp'] = this.finalPriceDisp;
    if (this.topLeftCaptionArr != null) {
      data['topLeftCaptionArr'] =
          this.topLeftCaptionArr!.map((v) => v.toJson()).toList();
    }
    if (this.topRightCaptionArr != null) {
      data['topRightCaptionArr'] =
          this.topRightCaptionArr!.map((v) => v.toJson()).toList();
    }
    if (this.bottomLeftCaptionArr != null) {
      data['bottomLeftCaptionArr'] =
          this.bottomLeftCaptionArr!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TopLeftCaptionArr {
  int? id;
  int? productId;
  String? caption;
  int? position;
  String? color;
  String? createdAt;
  String? updatedAt;

  TopLeftCaptionArr(
      {this.id,
      this.productId,
      this.caption,
      this.position,
      this.color,
      this.createdAt,
      this.updatedAt});

  TopLeftCaptionArr.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    caption = json['caption'];
    position = json['position'];
    color = json['color'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['caption'] = this.caption;
    data['position'] = this.position;
    data['color'] = this.color;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class TopRightCaptionArr {
  int? id;
  int? productId;
  String? caption;
  int? position;
  String? color;
  String? createdAt;
  String? updatedAt;

  TopRightCaptionArr(
      {this.id,
      this.productId,
      this.caption,
      this.position,
      this.color,
      this.createdAt,
      this.updatedAt});

  TopRightCaptionArr.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    caption = json['caption'];
    position = json['position'];
    color = json['color'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['caption'] = this.caption;
    data['position'] = this.position;
    data['color'] = this.color;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class BottomLeftCaptionArr {
  int? id;
  int? productId;
  String? caption;
  int? position;
  String? color;
  String? createdAt;
  String? updatedAt;

  BottomLeftCaptionArr(
      {this.id,
      this.productId,
      this.caption,
      this.position,
      this.color,
      this.createdAt,
      this.updatedAt});

  BottomLeftCaptionArr.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    caption = json['caption'];
    position = json['position'];
    color = json['color'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['caption'] = this.caption;
    data['position'] = this.position;
    data['color'] = this.color;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class BottomRightCaptionArr {
  int? id;
  int? productId;
  String? caption;
  int? position;
  String? color;
  String? createdAt;
  String? updatedAt;

  BottomRightCaptionArr(
      {this.id,
      this.productId,
      this.caption,
      this.position,
      this.color,
      this.createdAt,
      this.updatedAt});

  BottomRightCaptionArr.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    caption = json['caption'];
    position = json['position'];
    color = json['color'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['caption'] = this.caption;
    data['position'] = this.position;
    data['color'] = this.color;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class TopSelectionData {
  int? id;
  int? attributeSetId;
  int? productCategoryId;
  String? upc;
  String? sku;
  String? productName;
  var finalPrice;
  var retailPrice;
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
  int? specialTransportId;
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
  int? discountPerDisp;
  int? discountPer;
  int? discountValue;
  var discountValueDisp;
  var retailPriceDisp;
  var finalPriceDisp;
  List<TopRightCaptionArr>? topRightCaptionArr;
  List<BottomLeftCaptionArr>? bottomLeftCaptionArr;
  List<TopLeftCaptionArr>? topLeftCaptionArr;
  List<BottomRightCaptionArr>? bottomRightCaptionArr;

  TopSelectionData(
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
      this.smallImageUrl,
      this.largeImageUrl,
      this.prodImage,
      this.discountPerDisp,
      this.discountPer,
      this.discountValue,
      this.discountValueDisp,
      this.retailPriceDisp,
      this.finalPriceDisp,
      this.topRightCaptionArr,
      this.bottomLeftCaptionArr,
      this.topLeftCaptionArr,
      this.bottomRightCaptionArr});

  TopSelectionData.fromJson(Map<String, dynamic> json) {
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
    smallImageUrl = json['small_image_url'];
    largeImageUrl = json['large_image_url'];
    prodImage = json['prod_image'];
    discountPerDisp = json['discount_per_disp'];
    discountPer = json['discount_per'];
    discountValue = json['discount_value'];
    discountValueDisp = json['discount_value_disp'];
    retailPriceDisp = json['retail_price_disp'];
    finalPriceDisp = json['final_price_disp'];
    if (json['topRightCaptionArr'] != null) {
      topRightCaptionArr = <TopRightCaptionArr>[];
      json['topRightCaptionArr'].forEach((v) {
        topRightCaptionArr!.add(new TopRightCaptionArr.fromJson(v));
      });
    }
    if (json['bottomLeftCaptionArr'] != null) {
      bottomLeftCaptionArr = <BottomLeftCaptionArr>[];
      json['bottomLeftCaptionArr'].forEach((v) {
        bottomLeftCaptionArr!.add(new BottomLeftCaptionArr.fromJson(v));
      });
    }
    if (json['topLeftCaptionArr'] != null) {
      topLeftCaptionArr = <TopLeftCaptionArr>[];
      json['topLeftCaptionArr'].forEach((v) {
        topLeftCaptionArr!.add(new TopLeftCaptionArr.fromJson(v));
      });
    }
    if (json['bottomRightCaptionArr'] != null) {
      bottomRightCaptionArr = <BottomRightCaptionArr>[];
      json['bottomRightCaptionArr'].forEach((v) {
        bottomRightCaptionArr!.add(new BottomRightCaptionArr.fromJson(v));
      });
    }
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
    data['small_image_url'] = this.smallImageUrl;
    data['large_image_url'] = this.largeImageUrl;
    data['prod_image'] = this.prodImage;
    data['discount_per_disp'] = this.discountPerDisp;
    data['discount_per'] = this.discountPer;
    data['discount_value'] = this.discountValue;
    data['discount_value_disp'] = this.discountValueDisp;
    data['retail_price_disp'] = this.retailPriceDisp;
    data['final_price_disp'] = this.finalPriceDisp;
    if (this.topRightCaptionArr != null) {
      data['topRightCaptionArr'] =
          this.topRightCaptionArr!.map((v) => v.toJson()).toList();
    }
    if (this.bottomLeftCaptionArr != null) {
      data['bottomLeftCaptionArr'] =
          this.bottomLeftCaptionArr!.map((v) => v.toJson()).toList();
    }
    if (this.topLeftCaptionArr != null) {
      data['topLeftCaptionArr'] =
          this.topLeftCaptionArr!.map((v) => v.toJson()).toList();
    }
    if (this.bottomRightCaptionArr != null) {
      data['bottomRightCaptionArr'] =
          this.bottomRightCaptionArr!.map((v) => v.toJson()).toList();
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
  var finalPrice;
  var retailPrice;
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
  int? specialTransportId;
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
  int? discountPerDisp;
  int? discountPer;
  int? discountValue;
  var discountValueDisp;
  var retailPriceDisp;
  var finalPriceDisp;
  List<TopRightCaptionArr>? topRightCaptionArr;
  List<BottomLeftCaptionArr>? bottomLeftCaptionArr;
  List<TopLeftCaptionArr>? topLeftCaptionArr;
  List<BottomRightCaptionArr>? bottomRightCaptionArr;

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
      this.smallImageUrl,
      this.largeImageUrl,
      this.prodImage,
      this.discountPerDisp,
      this.discountPer,
      this.discountValue,
      this.discountValueDisp,
      this.retailPriceDisp,
      this.finalPriceDisp,
      this.topRightCaptionArr,
      this.bottomLeftCaptionArr,
      this.topLeftCaptionArr,
      this.bottomRightCaptionArr});

  BestSellerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    //  print('$id');
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
    smallImageUrl = json['small_image_url'];
    largeImageUrl = json['large_image_url'];
    prodImage = json['prod_image'];
    discountPerDisp = json['discount_per_disp'];
    discountPer = json['discount_per'];
    discountValue = json['discount_value'];
    discountValueDisp = json['discount_value_disp'];
    retailPriceDisp = json['retail_price_disp'];
    finalPriceDisp = json['final_price_disp'];
    if (json['topRightCaptionArr'] != null) {
      topRightCaptionArr = <TopRightCaptionArr>[];
      json['topRightCaptionArr'].forEach((v) {
        topRightCaptionArr!.add(new TopRightCaptionArr.fromJson(v));
      });
    }
    if (json['bottomLeftCaptionArr'] != null) {
      bottomLeftCaptionArr = <BottomLeftCaptionArr>[];
      json['bottomLeftCaptionArr'].forEach((v) {
        bottomLeftCaptionArr!.add(new BottomLeftCaptionArr.fromJson(v));
      });
    }
    if (json['topLeftCaptionArr'] != null) {
      topLeftCaptionArr = <TopLeftCaptionArr>[];
      json['topLeftCaptionArr'].forEach((v) {
        topLeftCaptionArr!.add(new TopLeftCaptionArr.fromJson(v));
      });
    }
    if (json['bottomRightCaptionArr'] != null) {
      bottomRightCaptionArr = <BottomRightCaptionArr>[];
      json['bottomRightCaptionArr'].forEach((v) {
        bottomRightCaptionArr!.add(new BottomRightCaptionArr.fromJson(v));
      });
    }
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
    data['small_image_url'] = this.smallImageUrl;
    data['large_image_url'] = this.largeImageUrl;
    data['prod_image'] = this.prodImage;
    data['discount_per_disp'] = this.discountPerDisp;
    data['discount_per'] = this.discountPer;
    data['discount_value'] = this.discountValue;
    data['discount_value_disp'] = this.discountValueDisp;
    data['retail_price_disp'] = this.retailPriceDisp;
    data['final_price_disp'] = this.finalPriceDisp;
    if (this.topRightCaptionArr != null) {
      data['topRightCaptionArr'] =
          this.topRightCaptionArr!.map((v) => v.toJson()).toList();
    }
    if (this.bottomLeftCaptionArr != null) {
      data['bottomLeftCaptionArr'] =
          this.bottomLeftCaptionArr!.map((v) => v.toJson()).toList();
    }
    if (this.topLeftCaptionArr != null) {
      data['topLeftCaptionArr'] =
          this.topLeftCaptionArr!.map((v) => v.toJson()).toList();
    }
    if (this.bottomRightCaptionArr != null) {
      data['bottomRightCaptionArr'] =
          this.bottomRightCaptionArr!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DailyDealsData {
  int? id;
  int? productId;
  int? productItemId;
  int? discountPercentage;
  String? startDate;
  String? endDate;
  int? status;
  int? attributeSetId;
  int? productCategoryId;
  String? upc;
  String? sku;
  String? productName;
  var finalPrice;
  var retailPrice;
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
  int? specialTransportId;
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
  String? createdAt;
  String? updatedAt;
  String? productSlug;
  String? smallImageUrl;
  String? largeImageUrl;
  String? prodImage;
  int? discountPerDisp;
  int? discountPer;
  int? discountValue;
  var discountValueDisp;
  var retailPriceDisp;
  var finalPriceDisp;
  List<TopRightCaptionArr>? topRightCaptionArr;
  List<BottomLeftCaptionArr>? bottomLeftCaptionArr;
  List<TopLeftCaptionArr>? topLeftCaptionArr;
  List<BottomRightCaptionArr>? bottomRightCaptionArr;

  DailyDealsData(
      {this.id,
      this.productId,
      this.productItemId,
      this.discountPercentage,
      this.startDate,
      this.endDate,
      this.status,
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
      this.createdAt,
      this.updatedAt,
      this.productSlug,
      this.smallImageUrl,
      this.largeImageUrl,
      this.prodImage,
      this.discountPerDisp,
      this.discountPer,
      this.discountValue,
      this.discountValueDisp,
      this.retailPriceDisp,
      this.finalPriceDisp,
      this.topRightCaptionArr,
      this.bottomLeftCaptionArr,
      this.topLeftCaptionArr,
      this.bottomRightCaptionArr});

  DailyDealsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    productItemId = json['product_item_id'];
    discountPercentage = json['discount_percentage'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];
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
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    productSlug = json['product_slug'];
    smallImageUrl = json['small_image_url'];
    largeImageUrl = json['large_image_url'];
    prodImage = json['prod_image'];
    discountPerDisp = json['discount_per_disp'];
    discountPer = json['discount_per'];
    discountValue = json['discount_value'];
    discountValueDisp = json['discount_value_disp'];
    retailPriceDisp = json['retail_price_disp'];
    finalPriceDisp = json['final_price_disp'];
    if (json['topRightCaptionArr'] != null) {
      topRightCaptionArr = <TopRightCaptionArr>[];
      json['topRightCaptionArr'].forEach((v) {
        topRightCaptionArr!.add(new TopRightCaptionArr.fromJson(v));
      });
    }
    if (json['bottomLeftCaptionArr'] != null) {
      bottomLeftCaptionArr = <BottomLeftCaptionArr>[];
      json['bottomLeftCaptionArr'].forEach((v) {
        bottomLeftCaptionArr!.add(new BottomLeftCaptionArr.fromJson(v));
      });
    }
    if (json['topLeftCaptionArr'] != null) {
      topLeftCaptionArr = <TopLeftCaptionArr>[];
      json['topLeftCaptionArr'].forEach((v) {
        topLeftCaptionArr!.add(new TopLeftCaptionArr.fromJson(v));
      });
    }
    if (json['bottomRightCaptionArr'] != null) {
      bottomRightCaptionArr = <BottomRightCaptionArr>[];
      json['bottomRightCaptionArr'].forEach((v) {
        bottomRightCaptionArr!.add(new BottomRightCaptionArr.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['product_item_id'] = this.productItemId;
    data['discount_percentage'] = this.discountPercentage;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['status'] = this.status;
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
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['product_slug'] = this.productSlug;
    data['small_image_url'] = this.smallImageUrl;
    data['large_image_url'] = this.largeImageUrl;
    data['prod_image'] = this.prodImage;
    data['discount_per_disp'] = this.discountPerDisp;
    data['discount_per'] = this.discountPer;
    data['discount_value'] = this.discountValue;
    data['discount_value_disp'] = this.discountValueDisp;
    data['retail_price_disp'] = this.retailPriceDisp;
    data['final_price_disp'] = this.finalPriceDisp;
    if (this.topRightCaptionArr != null) {
      data['topRightCaptionArr'] =
          this.topRightCaptionArr!.map((v) => v.toJson()).toList();
    }
    if (this.bottomLeftCaptionArr != null) {
      data['bottomLeftCaptionArr'] =
          this.bottomLeftCaptionArr!.map((v) => v.toJson()).toList();
    }
    if (this.topLeftCaptionArr != null) {
      data['topLeftCaptionArr'] =
          this.topLeftCaptionArr!.map((v) => v.toJson()).toList();
    }
    if (this.bottomRightCaptionArr != null) {
      data['bottomRightCaptionArr'] =
          this.bottomRightCaptionArr!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RecentlyViewProduct {
  int? id;
  int? attributeSetId;
  int? productCategoryId;
  String? upc;
  String? sku;
  String? productName;
  var finalPrice;
  var retailPrice;
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
  int? specialTransportId;
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
  int? productId;
  int? customerId;
  String? productSlug;
  String? smallImageUrl;
  String? largeImageUrl;
  String? discountValuePercentage;
  int? discountPer;
  int? discountValue;
  var discountValueDisp;
  var retailPriceDisp;
  var finalPriceDisp;
  int? isWishlist;
  String? discountPerDisp;

  RecentlyViewProduct(
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
      this.productId,
      this.customerId,
      this.productSlug,
      this.smallImageUrl,
      this.largeImageUrl,
      this.discountValuePercentage,
      this.discountPer,
      this.discountValue,
      this.discountValueDisp,
      this.retailPriceDisp,
      this.finalPriceDisp,
      this.isWishlist,
      this.discountPerDisp});

  RecentlyViewProduct.fromJson(Map<String, dynamic> json) {
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
    productId = json['product_id'];
    customerId = json['customer_id'];
    productSlug = json['product_slug'];
    smallImageUrl = json['small_image_url'];
    largeImageUrl = json['large_image_url'];
    discountValuePercentage = json['discount_value_percentage'];
    discountPer = json['discount_per'];
    discountValue = json['discount_value'];
    discountValueDisp = json['discount_value_disp'];
    retailPriceDisp = json['retail_price_disp'];
    finalPriceDisp = json['final_price_disp'];
    isWishlist = json['isWishlist'];
    discountPerDisp = json['discount_per_disp'];
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
    data['product_id'] = this.productId;
    data['customer_id'] = this.customerId;
    data['product_slug'] = this.productSlug;
    data['small_image_url'] = this.smallImageUrl;
    data['large_image_url'] = this.largeImageUrl;
    data['discount_value_percentage'] = this.discountValuePercentage;
    data['discount_per'] = this.discountPer;
    data['discount_value'] = this.discountValue;
    data['discount_value_disp'] = this.discountValueDisp;
    data['retail_price_disp'] = this.retailPriceDisp;
    data['final_price_disp'] = this.finalPriceDisp;
    data['isWishlist'] = this.isWishlist;
    data['discount_per_disp'] = this.discountPerDisp;
    return data;
  }
}

class ShopByCategory {
  int? id;
  String? categoryName;
  int? parentId;
  int? showInTopMenu;
  String? image;
  String? slugName;
  String? largeImageUrl;
  String? smallImageUrl;

  ShopByCategory(
      {this.id,
      this.categoryName,
      this.parentId,
      this.showInTopMenu,
      this.image,
      this.slugName,
        this.smallImageUrl,
      this.largeImageUrl,
});

  ShopByCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    parentId = json['parent_id'];
    showInTopMenu = json['show_in_top_menu'];
    image = json['image'];
    slugName = json['slug_name'];
    smallImageUrl = json['small_image_url'];
    largeImageUrl = json['large_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.categoryName;
    data['parent_id'] = this.parentId;
    data['show_in_top_menu'] = this.showInTopMenu;
    data['image'] = this.image;
    data['slug_name'] = this.slugName;
    data['small_image_url'] = this.smallImageUrl;
    data['large_image_url'] = this.largeImageUrl;
    return data;
  }
}

class Banners {
  List<TOP>? tOP;
  List<CENTER>? cENTER;
  List<CENTERUP>? cENTERUP;
  List<CENTERDOWN>? cENTERDOWN;

  Banners({this.tOP, this.cENTER, this.cENTERUP, this.cENTERDOWN});

  Banners.fromJson(Map<String, dynamic> json) {
    if (json['TOP'] != null) {
      tOP = <TOP>[];
      json['TOP'].forEach((v) {
        tOP!.add(new TOP.fromJson(v));
      });
    }
    if (json['CENTER'] != null) {
      cENTER = <CENTER>[];
      json['CENTER'].forEach((v) {
        cENTER!.add(new CENTER.fromJson(v));
      });
    }
    if (json['CENTER-UP'] != null) {
      cENTERUP = <CENTERUP>[];
      json['CENTER-UP'].forEach((v) {
        cENTERUP!.add(new CENTERUP.fromJson(v));
      });
    }
    if (json['CENTER-DOWN'] != null) {
      cENTERDOWN = <CENTERDOWN>[];
      json['CENTER-DOWN'].forEach((v) {
        cENTERDOWN!.add(new CENTERDOWN.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tOP != null) {
      data['TOP'] = this.tOP!.map((v) => v.toJson()).toList();
    }
    if (this.cENTER != null) {
      data['CENTER'] = this.cENTER!.map((v) => v.toJson()).toList();
    }
    if (this.cENTERUP != null) {
      data['CENTER-UP'] = this.cENTERUP!.map((v) => v.toJson()).toList();
    }
    if (this.cENTERDOWN != null) {
      data['CENTER-DOWN'] = this.cENTERDOWN!.map((v) => v.toJson()).toList();
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
  int? id;
  String? title;
  String? bannerUrl;
  String? image;
  String? imgUrl;
  String? largeImageUrl;

  CENTER(
      {this.id,
      this.title,
      this.bannerUrl,
      this.image,
      this.imgUrl,
      this.largeImageUrl});

  CENTER.fromJson(Map<String, dynamic> json) {
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

class CENTERUP {
  int? id;
  String? title;
  String? bannerUrl;
  String? image;
  String? imgUrl;
  String? largeImageUrl;

  CENTERUP(
      {this.id,
      this.title,
      this.bannerUrl,
      this.image,
      this.imgUrl,
      this.largeImageUrl});

  CENTERUP.fromJson(Map<String, dynamic> json) {
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

class CENTERDOWN {
  int? id;
  String? title;
  String? bannerUrl;
  String? image;
  String? imgUrl;
  String? largeImageUrl;

  CENTERDOWN(
      {this.id,
      this.title,
      this.bannerUrl,
      this.image,
      this.imgUrl,
      this.largeImageUrl});

  CENTERDOWN.fromJson(Map<String, dynamic> json) {
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
