class GetFilterDataModel {
  int? statusCode;
  String? statusMessage;
  String? message;
  GetFilterData? data;

  GetFilterDataModel(
      {this.statusCode, this.statusMessage, this.message, this.data});

  GetFilterDataModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    statusMessage = json['status_message'];
    message = json['message'];
    if (statusCode == 200)
      data = json['data'] != null
          ? new GetFilterData.fromJson(json['data'])
          : null;
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

class GetFilterData {
  String? categoryName;
  int? categoryId;
  List<SuppliersData>? suppliersData;
  List<Brand>? brand;
  List<ProductCategory>? productCategory;

  /* List<ProductData>? productData;
  ProductDataPagination? productDataPagination;*/
  int? maxPrice;

  GetFilterData(
      {this.categoryName,
      this.categoryId,
      this.suppliersData,
      this.brand,
      this.productCategory,
      /* this.productData, this.productDataPagination,*/ this.maxPrice});

  GetFilterData.fromJson(Map<String, dynamic> json) {
    categoryName = json['category_name'];
    categoryId = json['category_id'];
    if (json['suppliers_data'] != null) {
      suppliersData = <SuppliersData>[];
      json['suppliers_data'].forEach((v) {
        suppliersData!.add(new SuppliersData.fromJson(v));
      });
    }
    if (json['brand'] != null) {
      brand = <Brand>[];
      json['brand'].forEach((v) {
        brand!.add(new Brand.fromJson(v));
      });
    }
    if (json['product_category'] != null) {
      productCategory = <ProductCategory>[];
      json['product_category'].forEach((v) {
        productCategory!.add(new ProductCategory.fromJson(v));
      });
    }
    /* if (json['product_data'] != null) {
      productData = <ProductData>[];
      json['product_data'].forEach((v) { productData!.add(new ProductData.fromJson(v)); });
    }
    productDataPagination = json['product_data_pagination'] != null ? new ProductDataPagination.fromJson(json['product_data_pagination']) : null;
*/
    maxPrice = json['max_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_name'] = this.categoryName;
    data['category_id'] = this.categoryId;
    if (this.suppliersData != null) {
      data['suppliers_data'] =
          this.suppliersData!.map((v) => v.toJson()).toList();
    }
    if (this.brand != null) {
      data['brand'] = this.brand!.map((v) => v.toJson()).toList();
    }
    if (this.productCategory != null) {
      data['product_category'] =
          this.productCategory!.map((v) => v.toJson()).toList();
    }

    /* if (this.productData != null) {
      data['product_data'] = this.productData!.map((v) => v.toJson()).toList();
    }
    if (this.productDataPagination != null) {
      data['product_data_pagination'] = this.productDataPagination!.toJson();
    }*/
    data['max_price'] = this.maxPrice;
    return data;
  }
}

class SuppliersData {
  int? supplierId;
  int? productId;
  int? isSystemSupplier;
  String? supplierName;

  SuppliersData(
      {this.supplierId,
      this.productId,
      this.isSystemSupplier,
      this.supplierName});

  SuppliersData.fromJson(Map<String, dynamic> json) {
    supplierId = json['supplier_id'];
    productId = json['product_id'];
    isSystemSupplier = json['is_system_supplier'];
    supplierName = json['supplier_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['supplier_id'] = this.supplierId;
    data['product_id'] = this.productId;
    data['is_system_supplier'] = this.isSystemSupplier;
    data['supplier_name'] = this.supplierName;
    return data;
  }
}

class Brand {
  int? id;
  String? brandName;
  int? count;

  Brand({this.id, this.brandName, this.count});

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brandName = json['brand_name'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['brand_name'] = this.brandName;
    data['count'] = this.count;
    return data;
  }
}

class ProductCategory {
  int? id;
  String? categoryName;
  int? parentId;
  int? showInTopMenu;
  String? image;
  String? slugName;
  int? count;
  String? mainCategory;

  ProductCategory(
      {this.id,
      this.categoryName,
      this.parentId,
      this.showInTopMenu,
      this.image,
      this.slugName,
      this.count,
      this.mainCategory});

  ProductCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    parentId = json['parent_id'];
    showInTopMenu = json['show_in_top_menu'];
    image = json['image'];
    slugName = json['slug_name'];
    count = json['count'];
    mainCategory = json['main_category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_name'] = this.categoryName;
    data['parent_id'] = this.parentId;
    data['show_in_top_menu'] = this.showInTopMenu;
    data['image'] = this.image;
    data['slug_name'] = this.slugName;
    data['count'] = this.count;
    data['main_category'] = this.mainCategory;
    return data;
  }
}

class ProductData {
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
  String? productSlug;
  String? smallImageUrl;
  String? largeImageUrl;
  String? statusLabel;
  int? isWishlist;
  String? rating;
  int? productReview;
  int? discountValuePercentage;
  int? discountValue;
  String? discountValueDisp;
  String? retailPriceDisp;
  String? finalPriceDisp;

  ProductData(
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
      this.smallImageUrl,
      this.largeImageUrl,
      this.statusLabel,
      this.isWishlist,
      this.rating,
      this.productReview,
      this.discountValuePercentage,
      this.discountValue,
      this.discountValueDisp,
      this.retailPriceDisp,
      this.finalPriceDisp});

  ProductData.fromJson(Map<String, dynamic> json) {
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
    reviewsAvg = json['reviews_avg'];
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
    smallImageUrl = json['small_image_url'];
    largeImageUrl = json['large_image_url'];
    statusLabel = json['status_label'];
    isWishlist = json['isWishlist'];
    rating = json['rating'];
    productReview = json['product_review'];
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
    data['small_image_url'] = this.smallImageUrl;
    data['large_image_url'] = this.largeImageUrl;
    data['status_label'] = this.statusLabel;
    data['isWishlist'] = this.isWishlist;
    data['rating'] = this.rating;
    data['product_review'] = this.productReview;
    data['discount_value_percentage'] = this.discountValuePercentage;
    data['discount_value'] = this.discountValue;
    data['discount_value_disp'] = this.discountValueDisp;
    data['retail_price_disp'] = this.retailPriceDisp;
    data['final_price_disp'] = this.finalPriceDisp;
    return data;
  }
}

class ProductDataPagination {
  int? totalPages;
  int? next;
  String? previous;
  int? totalRecords;

  ProductDataPagination(
      {this.totalPages, this.next, this.previous, this.totalRecords});

  ProductDataPagination.fromJson(Map<String, dynamic> json) {
    totalPages = json['total_pages'];
    next = json['next'];
    previous = json['previous'];
    totalRecords = json['total_records'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_pages'] = this.totalPages;
    data['next'] = this.next;
    data['previous'] = this.previous;
    data['total_records'] = this.totalRecords;
    return data;
  }
}
