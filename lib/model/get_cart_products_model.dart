class GetCartProductsModel {
  int? statusCode;
  String? statusMessage;
  String? message;
  Data? data;

  GetCartProductsModel(
      {this.statusCode, this.statusMessage, this.message, this.data});

  GetCartProductsModel.fromJson(Map<String, dynamic> json) {
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
    if(statusCode==200)
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  CartDetails? cartDetails;
  List<RecommendationProducts>? recommendationProducts;
  List<RecentlyViewedProducts>? recentlyViewedProducts;

  Data(
      {this.cartDetails,
        this.recommendationProducts,
        this.recentlyViewedProducts});

  Data.fromJson(Map<String, dynamic> json) {
    cartDetails = json['cart_details'] != null
        ? new CartDetails.fromJson(json['cart_details'])
        : null;
    if (json['recommendation_products'] != null) {
      recommendationProducts = <RecommendationProducts>[];
      json['recommendation_products'].forEach((v) {
        recommendationProducts!.add(new RecommendationProducts.fromJson(v));
      });
    }
    if (json['recently_viewed_products'] != null) {
      recentlyViewedProducts = <RecentlyViewedProducts>[];
      json['recently_viewed_products'].forEach((v) {
        recentlyViewedProducts!.add(new RecentlyViewedProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cartDetails != null) {
      data['cart_details'] = this.cartDetails!.toJson();
    }
    if (this.recommendationProducts != null) {
      data['recommendation_products'] =
          this.recommendationProducts!.map((v) => v.toJson()).toList();
    }
   /* if (this.recentlyViewedProducts != null) {
      data['recently_viewed_products'] =
          this.recentlyViewedProducts!.map((v) => v.toJson()).toList();
    }*/
    return data;
  }
}

class CartDetails {
  List<CartItemDetails>? cartItemDetails;
  double? totalPrice;
  String? currencyCode;
  double? totalDeliveryPrice;
  double? totalTaxAmount;
  int? totalItems;
  List<CustomerAddressDetails>? customerAddressDetails;

  CartDetails(
      {this.cartItemDetails,
        this.totalPrice,
        this.currencyCode,
        this.totalDeliveryPrice,
        this.totalTaxAmount,
        this.totalItems,
        this.customerAddressDetails});

  CartDetails.fromJson(Map<String, dynamic> json) {
    if (json['cart_item_details'] != null) {
      cartItemDetails = <CartItemDetails>[];
      json['cart_item_details'].forEach((v) {
        cartItemDetails!.add(new CartItemDetails.fromJson(v));
      });
    }
    totalPrice = double.parse(json['total_price'].toString());
    currencyCode = json['currency_code'];
    totalDeliveryPrice = double.parse(json['total_delivery_price'].toString());
    totalTaxAmount = double.parse(json['total_tax_amount'].toString());
    totalItems = json['total_items'];
    if (json['customer_address_details'] != null) {
      customerAddressDetails = <CustomerAddressDetails>[];
      json['customer_address_details'].forEach((v) {
        customerAddressDetails!.add(new CustomerAddressDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cartItemDetails != null) {
      data['cart_item_details'] =
          this.cartItemDetails!.map((v) => v.toJson()).toList();
    }
    data['total_price'] = this.totalPrice;
    data['currency_code'] = this.currencyCode;
    data['total_delivery_price'] = this.totalDeliveryPrice;
    data['total_tax_amount'] = this.totalTaxAmount;
    data['total_items'] = this.totalItems;
    if (this.customerAddressDetails != null) {
      data['customer_address_details'] =
          this.customerAddressDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartItemDetails {
  int? id;
  String? quoteNo;
  int? currentQuotesNo;
  int? customerId;
  int? customerAddressId;
  int? subTotal;
  double? shippingPrice;
  double? taxAmount;
  double? grandTotal;
  String? shippingNotes;
  int? paymentMethodId;
  String? quoteCreatedDate;
  String? quoteUpdatedDate;
  int? status;
  String? ip;
  int? quoteId;
  int? productId;
  String? productName;
  String? sku;
  int? productItemId;
  int? productPackId;
  List<AttributeOptionsDetails>? attributeOptionsDetails;

  int? supplierId;
  String? supplierAssignedDate;
  int? supplierBranchId;
  int? supplierStatusId;
  String? supplierStatusUpdated;
  String? supplierRemark;
  int? daId;
  int? daBranchId;
  String? daAssignedDate;
  int? daStatusId;
  String? daStatusUpdated;
  String? daRemark;
  String? finalPrice;
  String? retailPrice;
  int? unitId;
  int? quantity;
  double? weight;
  int? weightUnitId;
  int? freeShipping;
  double? itemFinalTotal;
  String? daEstimatedDeliveryDate;
  int? deliveryTimeFactor;
  double? normalDeliveryPrice;
  double? quickDeliveryPrice;
  double? itemTotalAmount;
  String? createdAt;
  String? updatedAt;
  String? image;
  double? reviewsAvg;
  String? supplierName;
  String? pName;
  String? productSlug;
  String? smallImageUrl;
  String? largeImageUrl;
  String? shippingPriceLabel;
  String? normalDeliveryPriceLabel;
  String? quickDeliveryPriceLabel;
  String? prodImage;

  CartItemDetails(
      {this.id,
        this.quoteNo,
        this.currentQuotesNo,
        this.customerId,
        this.customerAddressId,
        this.subTotal,
        this.shippingPrice,
        this.taxAmount,
        this.grandTotal,
        this.shippingNotes,
        this.paymentMethodId,
        this.quoteCreatedDate,
        this.quoteUpdatedDate,
        this.status,
        this.ip,
        this.quoteId,
        this.productId,
        this.productName,
        this.sku,
        this.productItemId,
        this.productPackId,
        this.attributeOptionsDetails,
        this.supplierId,
        this.supplierAssignedDate,
        this.supplierBranchId,
        this.supplierStatusId,
        this.supplierStatusUpdated,
        this.supplierRemark,
        this.daId,
        this.daBranchId,
        this.daAssignedDate,
        this.daStatusId,
        this.daStatusUpdated,
        this.daRemark,
        this.finalPrice,
        this.retailPrice,
        this.unitId,
        this.quantity,
        this.weight,
        this.weightUnitId,
        this.freeShipping,
        this.itemFinalTotal,
        this.daEstimatedDeliveryDate,
        this.deliveryTimeFactor,
        this.normalDeliveryPrice,
        this.quickDeliveryPrice,
        this.itemTotalAmount,
        this.createdAt,
        this.updatedAt,
        this.image,
        this.reviewsAvg,
        this.supplierName,
        this.pName,
        this.productSlug,
        this.smallImageUrl,
        this.largeImageUrl,
        this.shippingPriceLabel,
        this.normalDeliveryPriceLabel,
        this.quickDeliveryPriceLabel,
        this.prodImage});

  CartItemDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quoteNo = json['quote_no'];
    currentQuotesNo = json['current_quotes_no'];
    customerId = json['customer_id'];
    customerAddressId = json['customer_address_id'];
    subTotal = json['sub_total'];
    shippingPrice = double.parse(json['shipping_price'].toString());
    taxAmount = double.parse(json['tax_amount'].toString());
    grandTotal = double.parse(json['grand_total'].toString());
    shippingNotes = json['shipping_notes'];
    paymentMethodId = json['payment_method_id'];
    quoteCreatedDate = json['quote_created_date'];
    quoteUpdatedDate = json['quote_updated_date'];
    status = json['status'];
    ip = json['ip'];
    quoteId = json['quote_id'];
    productId = json['product_id'];
    productName = json['product_name'];
    sku = json['sku'];
    productItemId = json['product_item_id'];
    productPackId = json['product_pack_id'];
    if (json['attribute_options_details'] != null) {
      attributeOptionsDetails = <AttributeOptionsDetails>[];
      json['attribute_options_details'].forEach((v) {
        attributeOptionsDetails!.add(new AttributeOptionsDetails.fromJson(v));
      });
    }
    supplierId = json['supplier_id'];
    supplierAssignedDate = json['supplier_assigned_date'];
    supplierBranchId = json['supplier_branch_id'];
    supplierStatusId = json['supplier_status_id'];
    supplierStatusUpdated = json['supplier_status_updated'];
    supplierRemark = json['supplier_remark'];
    daId = json['da_id'];
    daBranchId = json['da_branch_id'];
    daAssignedDate = json['da_assigned_date'];
    daStatusId = json['da_status_id'];
    daStatusUpdated = json['da_status_updated'];
    daRemark = json['da_remark'];
    finalPrice = json['final_price'];
    retailPrice = json['retail_price'];
    unitId = json['unit_id'];
    quantity = json['quantity'];
    weight = double.parse(json['weight'].toString());
    weightUnitId = json['weight_unit_id'];
    freeShipping = json['free_shipping'];
    itemFinalTotal = double.parse(json['item_final_total'].toString());
    daEstimatedDeliveryDate = json['da_estimated_delivery_date'];
    deliveryTimeFactor = json['delivery_time_factor'];
    normalDeliveryPrice = double.parse(json['normal_delivery_price'].toString());
    quickDeliveryPrice = double.parse(json['quick_delivery_price'].toString());
    itemTotalAmount = double.parse(json['item_total_amount'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
    reviewsAvg = double.parse(json['reviews_avg'].toString());
    supplierName = json['supplier_name'];
    pName = json['p_name'];
    productSlug = json['product_slug'];
    smallImageUrl = json['small_image_url'];
    largeImageUrl = json['large_image_url'];
    shippingPriceLabel = json['shipping_price_label'];
    normalDeliveryPriceLabel = json['normal_delivery_price_label'];
    quickDeliveryPriceLabel = json['quick_delivery_price_label'];
    prodImage = json['prod_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quote_no'] = this.quoteNo;
    data['current_quotes_no'] = this.currentQuotesNo;
    data['customer_id'] = this.customerId;
    data['customer_address_id'] = this.customerAddressId;
    data['sub_total'] = this.subTotal;
    data['shipping_price'] = this.shippingPrice;
    data['tax_amount'] = this.taxAmount;
    data['grand_total'] = this.grandTotal;
    data['shipping_notes'] = this.shippingNotes;
    data['payment_method_id'] = this.paymentMethodId;
    data['quote_created_date'] = this.quoteCreatedDate;
    data['quote_updated_date'] = this.quoteUpdatedDate;
    data['status'] = this.status;
    data['ip'] = this.ip;
    data['quote_id'] = this.quoteId;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['sku'] = this.sku;
    data['product_item_id'] = this.productItemId;
    data['product_pack_id'] = this.productPackId;
    if (this.attributeOptionsDetails != null) {
      data['attribute_options_details'] =
          this.attributeOptionsDetails!.map((v) => v.toJson()).toList();
    }
    data['supplier_id'] = this.supplierId;
    data['supplier_assigned_date'] = this.supplierAssignedDate;
    data['supplier_branch_id'] = this.supplierBranchId;
    data['supplier_status_id'] = this.supplierStatusId;
    data['supplier_status_updated'] = this.supplierStatusUpdated;
    data['supplier_remark'] = this.supplierRemark;
    data['da_id'] = this.daId;
    data['da_branch_id'] = this.daBranchId;
    data['da_assigned_date'] = this.daAssignedDate;
    data['da_status_id'] = this.daStatusId;
    data['da_status_updated'] = this.daStatusUpdated;
    data['da_remark'] = this.daRemark;
    data['final_price'] = this.finalPrice;
    data['retail_price'] = this.retailPrice;
    data['unit_id'] = this.unitId;
    data['quantity'] = this.quantity;
    data['weight'] = this.weight;
    data['weight_unit_id'] = this.weightUnitId;
    data['free_shipping'] = this.freeShipping;
    data['item_final_total'] = this.itemFinalTotal;
    data['da_estimated_delivery_date'] = this.daEstimatedDeliveryDate;
    data['delivery_time_factor'] = this.deliveryTimeFactor;
    data['normal_delivery_price'] = this.normalDeliveryPrice;
    data['quick_delivery_price'] = this.quickDeliveryPrice;
    data['item_total_amount'] = this.itemTotalAmount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image'] = this.image;
    data['reviews_avg'] = this.reviewsAvg;
    data['supplier_name'] = this.supplierName;
    data['p_name'] = this.pName;
    data['product_slug'] = this.productSlug;
    data['small_image_url'] = this.smallImageUrl;
    data['large_image_url'] = this.largeImageUrl;
    data['shipping_price_label'] = this.shippingPriceLabel;
    data['normal_delivery_price_label'] = this.normalDeliveryPriceLabel;
    data['quick_delivery_price_label'] = this.quickDeliveryPriceLabel;
    data['prod_image'] = this.prodImage;
    return data;
  }
}

class AttributeOptionsDetails {
  int? productAssociateAttributeId;
  int? productId;
  int? attributeId;
  int? optionId;
  String? attributeName;
  String? attributeOptionValue;

  AttributeOptionsDetails(
      {this.productAssociateAttributeId,
        this.productId,
        this.attributeId,
        this.optionId,
        this.attributeName,
        this.attributeOptionValue});

  AttributeOptionsDetails.fromJson(Map<String, dynamic> json) {
    productAssociateAttributeId = json['product_associate_attribute_id'];
    productId = json['product_id'];
    attributeId = json['attribute_id'];
    optionId = json['option_id'];
    attributeName = json['attribute_name'];
    attributeOptionValue = json['attribute_option_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_associate_attribute_id'] = this.productAssociateAttributeId;
    data['product_id'] = this.productId;
    data['attribute_id'] = this.attributeId;
    data['option_id'] = this.optionId;
    data['attribute_name'] = this.attributeName;
    data['attribute_option_value'] = this.attributeOptionValue;
    return data;
  }
}

class CustomerAddressDetails {
  int? id;
  int? customerId;
  String? createdAt;
  int? status;
  String? updatedAt;
  String? fullname;
  String? firstName;
  String? lastName;
  String? address1;
  String? address2;
  String? landmark;
  String? addressType;
  int? defaultAddress;
  String? deliveryInstruction;
  String? phone1Isd;
  String? phone1;
  String? mobile1Isd;
  String? mobile1;
  String? zip;
  String? countryCode;
  String? stateCode;
  String? cityCode;
  int? isDefaultShipping;
  int? isDefaultBilling;
  String? countryName;
  String? stateName;
  String? cityName;

  CustomerAddressDetails(
      {this.id,
        this.customerId,
        this.createdAt,
        this.status,
        this.updatedAt,
        this.fullname,
        this.firstName,
        this.lastName,
        this.address1,
        this.address2,
        this.landmark,
        this.addressType,
        this.defaultAddress,
        this.deliveryInstruction,
        this.phone1Isd,
        this.phone1,
        this.mobile1Isd,
        this.mobile1,
        this.zip,
        this.countryCode,
        this.stateCode,
        this.cityCode,
        this.isDefaultShipping,
        this.isDefaultBilling,
        this.countryName,
        this.stateName,
        this.cityName});

  CustomerAddressDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    createdAt = json['created_at'];
    status = json['status'];
    updatedAt = json['updated_at'];
    fullname = json['fullname'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    address1 = json['address1'];
    address2 = json['address2'];
    landmark = json['landmark'];
    addressType = json['address_type'];
    defaultAddress = json['default_address'];
    deliveryInstruction = json['delivery_instruction'];
    phone1Isd = json['phone1_isd'];
    phone1 = json['phone1'];
    mobile1Isd = json['mobile1_isd'];
    mobile1 = json['mobile1'];
    zip = json['zip'];
    countryCode = json['country_code'];
    stateCode = json['state_code'];
    cityCode = json['city_code'];
    isDefaultShipping = json['is_default_shipping'];
    isDefaultBilling = json['is_default_billing'];
    countryName = json['country_name'];
    stateName = json['state_name'];
    cityName = json['city_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['created_at'] = this.createdAt;
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    data['fullname'] = this.fullname;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['landmark'] = this.landmark;
    data['address_type'] = this.addressType;
    data['default_address'] = this.defaultAddress;
    data['delivery_instruction'] = this.deliveryInstruction;
    data['phone1_isd'] = this.phone1Isd;
    data['phone1'] = this.phone1;
    data['mobile1_isd'] = this.mobile1Isd;
    data['mobile1'] = this.mobile1;
    data['zip'] = this.zip;
    data['country_code'] = this.countryCode;
    data['state_code'] = this.stateCode;
    data['city_code'] = this.cityCode;
    data['is_default_shipping'] = this.isDefaultShipping;
    data['is_default_billing'] = this.isDefaultBilling;
    data['country_name'] = this.countryName;
    data['state_name'] = this.stateName;
    data['city_name'] = this.cityName;
    return data;
  }
}



class RecommendationProducts {
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
  String? discountValuePercentage;
  int? discountPer;
  int? discountValue;
  String? discountValueDisp;
  String? retailPriceDisp;
  String? finalPriceDisp;
  String? discountPerDisp;

  RecommendationProducts(
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
        this.discountPer,
        this.discountValue,
        this.discountValueDisp,
        this.retailPriceDisp,
        this.finalPriceDisp,
        this.discountPerDisp});

  RecommendationProducts.fromJson(Map<String, dynamic> json) {
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
    smallImageUrl = json['small_image_url'];
    largeImageUrl = json['large_image_url'];
    discountValuePercentage = json['discount_value_percentage'];
    discountPer = json['discount_per'];
    discountValue = json['discount_value'];
    discountValueDisp = json['discount_value_disp'];
    retailPriceDisp = json['retail_price_disp'];
    finalPriceDisp = json['final_price_disp'];
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
    data['product_slug'] = this.productSlug;
    data['small_image_url'] = this.smallImageUrl;
    data['large_image_url'] = this.largeImageUrl;
    data['discount_value_percentage'] = this.discountValuePercentage;
    data['discount_per'] = this.discountPer;
    data['discount_value'] = this.discountValue;
    data['discount_value_disp'] = this.discountValueDisp;
    data['retail_price_disp'] = this.retailPriceDisp;
    data['final_price_disp'] = this.finalPriceDisp;
    data['discount_per_disp'] = this.discountPerDisp;
    return data;
  }
}

class RecentlyViewedProducts {
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
  String? discountValuePercentage;
  int? discountPer;
  int? discountValue;
  String? discountValueDisp;
  String? retailPriceDisp;
  String? finalPriceDisp;
  String? discountPerDisp;

  RecentlyViewedProducts(
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
        this.discountPer,
        this.discountValue,
        this.discountValueDisp,
        this.retailPriceDisp,
        this.finalPriceDisp,
        this.discountPerDisp});

  RecentlyViewedProducts.fromJson(Map<String, dynamic> json) {
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
    smallImageUrl = json['small_image_url'];
    largeImageUrl = json['large_image_url'];
    discountValuePercentage = json['discount_value_percentage'];
    discountPer = json['discount_per'];
    discountValue = json['discount_value'];
    discountValueDisp = json['discount_value_disp'];
    retailPriceDisp = json['retail_price_disp'];
    finalPriceDisp = json['final_price_disp'];
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
    data['product_slug'] = this.productSlug;
    data['small_image_url'] = this.smallImageUrl;
    data['large_image_url'] = this.largeImageUrl;
    data['discount_value_percentage'] = this.discountValuePercentage;
    data['discount_per'] = this.discountPer;
    data['discount_value'] = this.discountValue;
    data['discount_value_disp'] = this.discountValueDisp;
    data['retail_price_disp'] = this.retailPriceDisp;
    data['final_price_disp'] = this.finalPriceDisp;
    data['discount_per_disp'] = this.discountPerDisp;
    return data;
  }
}
