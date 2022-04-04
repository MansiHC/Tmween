import 'package:tmween/model/get_filter_data_model.dart';

class ProductDetailModel {
  int? statusCode;
  String? statusMessage;
  String? message;
  ProductDetailData? data;

  ProductDetailModel(
      {this.statusCode, this.statusMessage, this.message, this.data});

  ProductDetailModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    statusMessage = json['status_message'];
    message = json['message'];
    if(statusCode==200)
    data = json['data'] != null ? new ProductDetailData.fromJson(json['data']) : null;
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

class ProductDetailData {
  List<int>? options;
 List<ProductOtherInfo>? productOtherInfo;
//  List<SuppliersData>? suppliersData;
  List<ProductData>? productData;
  CustomerProductReview? customerProductReview;
 List<ProductAssociateAttribute>? productAssociateAttribute;
  List<AttributeImageCombArr>? attributeImageCombArr;
  List<SimilarProduct>? similarProduct;

  /*List<PackDetails>? packDetails;


  List<CustomerViewedProducts>? customerViewedProducts;*/

  ProductDetailData(
      {this.options,
        this.productOtherInfo,
        //this.suppliersData,
        this.productData,
        this.customerProductReview,
       this.productAssociateAttribute,
        this.attributeImageCombArr,
        /* this.packDetails,



        this.customerViewedProducts*/});

  ProductDetailData.fromJson(Map<String, dynamic> json) {
    options = json['options'].cast<int>();
    if (json['product_other_info'] != null) {
      productOtherInfo = <ProductOtherInfo>[];
      json['product_other_info'].forEach((v) {
        productOtherInfo!.add(new ProductOtherInfo.fromJson(v));
      });
    }
    /*  if (json['suppliers_data'] != null) {
      suppliersData = <SuppliersData>[];
      json['suppliers_data'].forEach((v) {
        suppliersData!.add(new SuppliersData.fromJson(v));
      });
    }*/
    if (json['product_data'] != null) {
      productData = <ProductData>[];
      json['product_data'].forEach((v) {
        productData!.add(new ProductData.fromJson(v));
      });
    }
    customerProductReview = json['customer_product_review'] != null
        ? new CustomerProductReview.fromJson(json['customer_product_review'])
        : null;
 if (json['product_associate_attribute'] != null) {
      productAssociateAttribute = <ProductAssociateAttribute>[];
      json['product_associate_attribute'].forEach((v) {
        productAssociateAttribute!
            .add(new ProductAssociateAttribute.fromJson(v));
      });
    }

    if (json['attribute_image_comb_arr'] != null) {
      attributeImageCombArr = <AttributeImageCombArr>[];
      json['attribute_image_comb_arr'].forEach((v) {
        attributeImageCombArr!.add(new AttributeImageCombArr.fromJson(v));
      });
    }
    if (json['similar_product'] != null) {
      similarProduct = <SimilarProduct>[];
      json['similar_product'].forEach((v) {
        similarProduct!.add(new SimilarProduct.fromJson(v));
      });
    }
    /* if (json['pack_details'] != null) {
      packDetails = <PackDetails>[];
      json['pack_details'].forEach((v) {
        packDetails!.add(new PackDetails.fromJson(v));
      });
    }



    if (json['customer_viewed_products'] != null) {
      customerViewedProducts = <CustomerViewedProducts>[];
      json['customer_viewed_products'].forEach((v) {
        customerViewedProducts!.add(new CustomerViewedProducts.fromJson(v));
      });
    }*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
   data['options'] = this.options;
    if (this.productOtherInfo != null) {
      data['product_other_info'] =
          this.productOtherInfo!.map((v) => v.toJson()).toList();
    }
    /* if (this.suppliersData != null) {
      data['suppliers_data'] =
          this.suppliersData!.map((v) => v.toJson()).toList();
    }*/
    if (this.productData != null) {
      data['product_data'] = this.productData!.map((v) => v.toJson()).toList();
    }
    if (this.customerProductReview != null) {
      data['customer_product_review'] = this.customerProductReview!.toJson();
    }
  if (this.productAssociateAttribute != null) {
      data['product_associate_attribute'] =
          this.productAssociateAttribute!.map((v) => v.toJson()).toList();
    }
    if (this.attributeImageCombArr != null) {
      data['attribute_image_comb_arr'] =
          this.attributeImageCombArr!.map((v) => v.toJson()).toList();
    }
    if (this.similarProduct != null) {
      data['similar_product'] =
          this.similarProduct!.map((v) => v.toJson()).toList();
    }
    /*  if (this.packDetails != null) {
      data['pack_details'] = this.packDetails!.map((v) => v.toJson()).toList();
    }



    if (this.customerViewedProducts != null) {
      data['customer_viewed_products'] =
          this.customerViewedProducts!.map((v) => v.toJson()).toList();
    }*/
    return data;
  }
}

class PackDetails {
  int? id;
  int? productId;
  int? marketPrice;
  int? packSize;
  int? weightUnitId;
  int? weight;
  int? dimensionUnitId;
  String? height;
  String? width;
  String? length;

  PackDetails(
      {this.id,
        this.productId,
        this.marketPrice,
        this.packSize,
        this.weightUnitId,
        this.weight,
        this.dimensionUnitId,
        this.height,
        this.width,
        this.length});

  PackDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    marketPrice = json['market_price'];
    packSize = json['pack_size'];
    weightUnitId = json['weight_unit_id'];
    weight = json['weight'];
    dimensionUnitId = json['dimension_unit_id'];
    height = json['height'];
    width = json['width'];
    length = json['length'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['market_price'] = this.marketPrice;
    data['pack_size'] = this.packSize;
    data['weight_unit_id'] = this.weightUnitId;
    data['weight'] = this.weight;
    data['dimension_unit_id'] = this.dimensionUnitId;
    data['height'] = this.height;
    data['width'] = this.width;
    data['length'] = this.length;
    return data;
  }
}

class ProductOtherInfo {
  int? id;
  int? productId;
  String? caption;
  int? position;
  String? color;
  String? createdAt;
  String? updatedAt;

  ProductOtherInfo(
      {this.id,
        this.productId,
        this.caption,
        this.position,
        this.color,
        this.createdAt,
        this.updatedAt});

  ProductOtherInfo.fromJson(Map<String, dynamic> json) {
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
  int? reviewsAvg;
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
  List<PLanguage>? pLanguage;
  List<ProductCategory>? productCategory;
  List<ProductGallery>? productGallery;
  List<ProductPack>? productPack;
  List<ProductSupplier>? productSupplier;
  String? mainCategory;
  String? categorySlug;
  String? smallImageUrl;
  String? largeImageUrl;
  int? discountValuePercentage;
  int? discountValue;
  String? discountValueDisp;
  String? retailPriceDisp;
  String? finalPriceDisp;
  String? brandName;
  int? isWhishlist;
  int? fullfilledByTmween;

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
        this.pLanguage,
        this.productCategory,
        this.productGallery,
        this.productPack,
        this.productSupplier,
        this.mainCategory,
        this.categorySlug,
        this.smallImageUrl,
        this.largeImageUrl,
        this.discountValuePercentage,
        this.discountValue,
        this.discountValueDisp,
        this.retailPriceDisp,
        this.finalPriceDisp,
        this.brandName,
        this.isWhishlist,
        this.fullfilledByTmween});

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
    if (json['p_language'] != null) {
      pLanguage = <PLanguage>[];
      json['p_language'].forEach((v) {
        pLanguage!.add(new PLanguage.fromJson(v));
      });
    }
    if (json['product_category'] != null) {
      productCategory = <ProductCategory>[];
      json['product_category'].forEach((v) {
        productCategory!.add(new ProductCategory.fromJson(v));
      });
    }
    if (json['product_gallery'] != null) {
      productGallery = <ProductGallery>[];
      json['product_gallery'].forEach((v) {
        productGallery!.add(new ProductGallery.fromJson(v));
      });
    }
    if (json['product_pack'] != null) {
      productPack = <ProductPack>[];
      json['product_pack'].forEach((v) {
        productPack!.add(new ProductPack.fromJson(v));
      });
    }
    if (json['product_supplier'] != null) {
      productSupplier = <ProductSupplier>[];
      json['product_supplier'].forEach((v) {
        productSupplier!.add(new ProductSupplier.fromJson(v));
      });
    }
    mainCategory = json['main_category'];
    categorySlug = json['category_slug'];
    smallImageUrl = json['small_image_url'];
    largeImageUrl = json['large_image_url'];
    discountValuePercentage = json['discount_value_percentage'];
    discountValue = json['discount_value'];
    discountValueDisp = json['discount_value_disp'];
    retailPriceDisp = json['retail_price_disp'];
    finalPriceDisp = json['final_price_disp'];
    brandName = json['brand_name'];
    isWhishlist = json['is_whishlist'];
    fullfilledByTmween = json['fullfilled_by_tmween'];
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
    if (this.pLanguage != null) {
      data['p_language'] = this.pLanguage!.map((v) => v.toJson()).toList();
    }
    if (this.productCategory != null) {
      data['product_category'] =
          this.productCategory!.map((v) => v.toJson()).toList();
    }
    if (this.productGallery != null) {
      data['product_gallery'] =
          this.productGallery!.map((v) => v.toJson()).toList();
    }
    if (this.productPack != null) {
      data['product_pack'] = this.productPack!.map((v) => v.toJson()).toList();
    }
    if (this.productSupplier != null) {
      data['product_supplier'] =
          this.productSupplier!.map((v) => v.toJson()).toList();
    }
    data['main_category'] = this.mainCategory;
    data['category_slug'] = this.categorySlug;
    data['small_image_url'] = this.smallImageUrl;
    data['large_image_url'] = this.largeImageUrl;
    data['discount_value_percentage'] = this.discountValuePercentage;
    data['discount_value'] = this.discountValue;
    data['discount_value_disp'] = this.discountValueDisp;
    data['retail_price_disp'] = this.retailPriceDisp;
    data['final_price_disp'] = this.finalPriceDisp;
    data['brand_name'] = this.brandName;
    data['is_whishlist'] = this.isWhishlist;
    data['fullfilled_by_tmween'] = this.fullfilledByTmween;
    return data;
  }
}

class PLanguage {
  int? id;
  int? productId;
  String? langCode;
  String? productName;
  String? productSlug;
  String? shortDescription;
  String? longDescription;
  String? specification;

  PLanguage(
      {this.id,
        this.productId,
        this.langCode,
        this.productName,
        this.productSlug,
        this.shortDescription,
        this.longDescription,
        this.specification});

  PLanguage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    langCode = json['lang_code'];
    productName = json['product_name'];
    productSlug = json['product_slug'];
    shortDescription = json['short_description'];
    longDescription = json['long_description'];
    specification = json['specification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['lang_code'] = this.langCode;
    data['product_name'] = this.productName;
    data['product_slug'] = this.productSlug;
    data['short_description'] = this.shortDescription;
    data['long_description'] = this.longDescription;
    data['specification'] = this.specification;
    return data;
  }
}

class ProductGallery {
  int? productId;
  String? image;
  String? fancyBoxUrl;
  String? smallImageUrl;
  String? largeImageUrl;
  int? orderBy;

  ProductGallery(
      {this.productId,
        this.image,
        this.fancyBoxUrl,
        this.smallImageUrl,
        this.largeImageUrl,
        this.orderBy});

  ProductGallery.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    image = json['image'];
    fancyBoxUrl = json['fancy_box_url'];
    smallImageUrl = json['small_image_url'];
    largeImageUrl = json['large_image_url'];
    orderBy = json['order_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['image'] = this.image;
    data['fancy_box_url'] = this.fancyBoxUrl;
    data['small_image_url'] = this.smallImageUrl;
    data['large_image_url'] = this.largeImageUrl;
    data['order_by'] = this.orderBy;
    return data;
  }
}

class ProductPack {
  int? id;
  int? productId;
  int? marketPrice;
  int? packSize;
  int? weightUnitId;
  int? weight;
  int? dimensionUnitId;
  String? height;
  String? width;
  String? length;

  ProductPack(
      {this.id,
        this.productId,
        this.marketPrice,
        this.packSize,
        this.weightUnitId,
        this.weight,
        this.dimensionUnitId,
        this.height,
        this.width,
        this.length});

  ProductPack.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    marketPrice = json['market_price'];
    packSize = json['pack_size'];
    weightUnitId = json['weight_unit_id'];
    weight = json['weight'];
    dimensionUnitId = json['dimension_unit_id'];
    height = json['height'];
    width = json['width'];
    length = json['length'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['market_price'] = this.marketPrice;
    data['pack_size'] = this.packSize;
    data['weight_unit_id'] = this.weightUnitId;
    data['weight'] = this.weight;
    data['dimension_unit_id'] = this.dimensionUnitId;
    data['height'] = this.height;
    data['width'] = this.width;
    data['length'] = this.length;
    return data;
  }
}

class ProductSupplier {
  int? id;
  int? productId;
  int? supplierId;
  int? addedById;
  String? addedDate;
  String? supplierName;

  ProductSupplier(
      {this.id,
        this.productId,
        this.supplierId,
        this.addedById,
        this.addedDate,
        this.supplierName});

  ProductSupplier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    supplierId = json['supplier_id'];
    addedById = json['added_by_id'];
    addedDate = json['added_date'];
    supplierName = json['supplier_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['supplier_id'] = this.supplierId;
    data['added_by_id'] = this.addedById;
    data['added_date'] = this.addedDate;
    data['supplier_name'] = this.supplierName;
    return data;
  }
}

class ProductAssociateAttribute {
  int? attributeId;
  String? attributeName;
  List<Options>? options;

  ProductAssociateAttribute(
      {this.attributeId, this.attributeName, this.options});

  ProductAssociateAttribute.fromJson(Map<String, dynamic> json) {
    attributeId = json['attribute_id'];
    attributeName = json['attribute_name'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attribute_id'] = this.attributeId;
    data['attribute_name'] = this.attributeName;
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Options {
  int? attributeOptionId;
  String? attributeOptionValue;

  Options({this.attributeOptionId, this.attributeOptionValue});

  Options.fromJson(Map<String, dynamic> json) {
    attributeOptionId = json['attribute_option_id'];
    attributeOptionValue = json['attribute_option_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attribute_option_id'] = this.attributeOptionId;
    data['attribute_option_value'] = this.attributeOptionValue;
    return data;
  }
}

class AttributeImageCombArr {
  int? id;
  String? image;
  int? status;
  String? fancyBoxUrl;
  String? smallImageUrl;
  String? largeImageUrl;

  AttributeImageCombArr(
      {this.id,
        this.image,
        this.status,
        this.fancyBoxUrl,
        this.smallImageUrl,
        this.largeImageUrl});

  AttributeImageCombArr.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    status = json['status'];
    fancyBoxUrl = json['fancy_box_url'];
    smallImageUrl = json['small_image_url'];
    largeImageUrl = json['large_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['status'] = this.status;
    data['fancy_box_url'] = this.fancyBoxUrl;
    data['small_image_url'] = this.smallImageUrl;
    data['large_image_url'] = this.largeImageUrl;
    return data;
  }
}

class SimilarProduct {
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
  int? reviewsAvg;
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
  String? smallImageUrl;
  String? largeImageUrl;
  int? discountValuePercentage;
  int? discountValue;
  String? discountValueDisp;
  String? retailPriceDisp;
  String? finalPriceDisp;

  SimilarProduct(
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
        this.discountValuePercentage,
        this.discountValue,
        this.discountValueDisp,
        this.retailPriceDisp,
        this.finalPriceDisp});

  SimilarProduct.fromJson(Map<String, dynamic> json) {
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
    data['discount_value_percentage'] = this.discountValuePercentage;
    data['discount_value'] = this.discountValue;
    data['discount_value_disp'] = this.discountValueDisp;
    data['retail_price_disp'] = this.retailPriceDisp;
    data['final_price_disp'] = this.finalPriceDisp;
    return data;
  }
}

class CustomerProductReview {
  List<CustomerProductReviewData>? data;
  int? customerProductReviewCount;
  String? customerProductReviewRating;
  CustomerReviewHelpfulCount? customerReviewHelpfulCount;
  CustomerReviewHelpfulCount? customerReviewReportAbuse;

  CustomerProductReview(
      {this.data,
        this.customerProductReviewCount,
        this.customerProductReviewRating,this.customerReviewHelpfulCount,
        this.customerReviewReportAbuse});

  CustomerProductReview.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CustomerProductReviewData>[];
      json['data'].forEach((v) {
        data!.add(new CustomerProductReviewData.fromJson(v));
      });
    }
    customerProductReviewCount = json['customer_product_review_count'];
    customerProductReviewRating = json['customer_product_review_rating'];
    customerReviewHelpfulCount = json['customer_review_helpful_count'] != null
        ? new CustomerReviewHelpfulCount.fromJson(
        json['customer_review_helpful_count'])
        : null;
    customerReviewReportAbuse = json['customer_review_report_abuse'] != null
        ? new CustomerReviewHelpfulCount.fromJson(
        json['customer_review_report_abuse'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['customer_product_review_count'] = this.customerProductReviewCount;
    data['customer_product_review_rating'] = this.customerProductReviewRating;
    if (this.customerReviewHelpfulCount != null) {
      data['customer_review_helpful_count'] =
          this.customerReviewHelpfulCount!.toJson();
    }
    if (this.customerReviewReportAbuse != null) {
      data['customer_review_report_abuse'] =
          this.customerReviewReportAbuse!.toJson();
    }
    return data;
  }
}

class CustomerReviewHelpfulCount {
  List<CustomeReviewData>? data;

  CustomerReviewHelpfulCount({this.data});

  CustomerReviewHelpfulCount.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CustomeReviewData>[];
      json['data'].forEach((v) {
        data!.add(new CustomeReviewData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomeReviewData {
  String? message;
  int? isHelpful;
  int? isAbuse;
  CustomeReviewData({this.message, this.isHelpful,this.isAbuse});

  CustomeReviewData.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    isHelpful = json['isHelpful'];
    isAbuse = json['isAbuse'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['isHelpful'] = this.isHelpful;
    data['isAbuse'] = this.isAbuse;
    return data;
  }
}

class CustomerProductReviewData {
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

  CustomerProductReviewData({this.id, this.customerId, this.productId, this.reviewTitle, this.review, this.rating, this.ip, this.reviewDate, this.addedByType, this.addedById, this.status, this.reviewApprovedDate, this.reviewApprovedId, this.createdAt, this.image, this.fullname, this.smallImageUrl, this.largeImageUrl});

  CustomerProductReviewData.fromJson(Map<String, dynamic> json) {
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


class CustomerViewedProducts {
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
  int? reviewsAvg;
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
  int? productId;
  int? customerId;
  String? productSlug;

  CustomerViewedProducts(
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
        this.productSlug});

  CustomerViewedProducts.fromJson(Map<String, dynamic> json) {
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
    productId = json['product_id'];
    customerId = json['customer_id'];
    productSlug = json['product_slug'];
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
    return data;
  }
}
