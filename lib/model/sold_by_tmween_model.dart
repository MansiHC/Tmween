class SoldByTmweenModel {
  const SoldByTmweenModel(
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

  static fromJson(responseJson) {
    return null;
  }
}
/*
class SoldByTmweenModel {
  int? statusCode;
  String? statusMessage;
  String? message;
  Data? data;

  SoldByTmweenModel(
      {this.statusCode, this.statusMessage, this.message, this.data});

  SoldByTmweenModel.fromJson(Map<String, dynamic> json) {
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
  List<SoldByTmweenProductData>? soldByTmweenProductData;
  int? totalPages;
  String? next;
  String? previous;
  int? totalRecords;

  Data(
      {this.soldByTmweenProductData,
        this.totalPages,
        this.next,
        this.previous,
        this.totalRecords});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['sold_by_tmween_product_data'] != null) {
      soldByTmweenProductData = <SoldByTmweenProductData>[];
      json['sold_by_tmween_product_data'].forEach((v) {
        soldByTmweenProductData!.add(new SoldByTmweenProductData.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    next = json['next'];
    previous = json['previous'];
    totalRecords = json['total_records'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.soldByTmweenProductData != null) {
      data['sold_by_tmween_product_data'] =
          this.soldByTmweenProductData!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = this.totalPages;
    data['next'] = this.next;
    data['previous'] = this.previous;
    data['total_records'] = this.totalRecords;
    return data;
  }
}

class SoldByTmweenProductData {
  int? id;
  String? supplierName;
  String? supplierActivityTypeId;
  String? companyName;
  String? registrationNumber;
  int? regNo;
  String? contactName;
  String? mobile1Isd;
  String? mobile1;
  Null? mobile2Isd;
  Null? mobile2;
  String? phone1Isd;
  String? phone1;
  Null? phone2Isd;
  Null? phone2;
  String? address1;
  Null? address2;
  String? area;
  String? countryCode;
  String? stateCode;
  String? cityCode;
  String? zoneCode;
  String? zip;
  int? noOfBranches;
  int? noOfServiceActivityType;
  int? deliveryService;
  int? priority;
  String? email;
  String? password;
  String? orderEmail;
  String? technicalEmail;
  String? ip;
  int? supplierPakageId;
  int? supplierPakagePlanId;
  String? subscriptionStartDate;
  String? subscriptionEndDate;
  int? isAutoSubscriptionUpgrade;
  int? referenceId;
  int? addedUserId;
  String? latitude;
  String? longitude;
  Null? defaultLangCode;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? attributeSetId;
  int? productCategoryId;
  String? upc;
  String? sku;
  String? productName;
  int? finalPrice;
  int? retailPrice;
  int? stock;
  int? inStock;
  double? reviewsAvg;
  int? brandId;
  String? manufacturerNumber;
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
  String? productSlug;
  String? startDate;
  String? endDate;
  String? smallImageUrl;
  String? largeImageUrl;
  String? prodImage;
  String? discountPerDisp;
  int? discountPer;
  int? discountValue;
  String? discountValueDisp;
  String? retailPriceDisp;
  String? finalPriceDisp;

  SoldByTmweenProductData(
      {this.id,
        this.supplierName,
        this.supplierActivityTypeId,
        this.companyName,
        this.registrationNumber,
        this.regNo,
        this.contactName,
        this.mobile1Isd,
        this.mobile1,
        this.mobile2Isd,
        this.mobile2,
        this.phone1Isd,
        this.phone1,
        this.phone2Isd,
        this.phone2,
        this.address1,
        this.address2,
        this.area,
        this.countryCode,
        this.stateCode,
        this.cityCode,
        this.zoneCode,
        this.zip,
        this.noOfBranches,
        this.noOfServiceActivityType,
        this.deliveryService,
        this.priority,
        this.email,
        this.password,
        this.orderEmail,
        this.technicalEmail,
        this.ip,
        this.supplierPakageId,
        this.supplierPakagePlanId,
        this.subscriptionStartDate,
        this.subscriptionEndDate,
        this.isAutoSubscriptionUpgrade,
        this.referenceId,
        this.addedUserId,
        this.latitude,
        this.longitude,
        this.defaultLangCode,
        this.status,
        this.createdAt,
        this.updatedAt,
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
        this.finalPriceDisp});

  SoldByTmweenProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    supplierName = json['supplier_name'];
    supplierActivityTypeId = json['supplier_activity_type_id'];
    companyName = json['company_name'];
    registrationNumber = json['registration_number'];
    regNo = json['reg_no'];
    contactName = json['contact_name'];
    mobile1Isd = json['mobile1_isd'];
    mobile1 = json['mobile1'];
    mobile2Isd = json['mobile2_isd'];
    mobile2 = json['mobile2'];
    phone1Isd = json['phone1_isd'];
    phone1 = json['phone1'];
    phone2Isd = json['phone2_isd'];
    phone2 = json['phone2'];
    address1 = json['address1'];
    address2 = json['address2'];
    area = json['area'];
    countryCode = json['country_code'];
    stateCode = json['state_code'];
    cityCode = json['city_code'];
    zoneCode = json['zone_code'];
    zip = json['zip'];
    noOfBranches = json['no_of_branches'];
    noOfServiceActivityType = json['no_of_service_activity_type'];
    deliveryService = json['delivery_service'];
    priority = json['priority'];
    email = json['email'];
    password = json['password'];
    orderEmail = json['order_email'];
    technicalEmail = json['technical_email'];
    ip = json['ip'];
    supplierPakageId = json['supplier_pakage_id'];
    supplierPakagePlanId = json['supplier_pakage_plan_id'];
    subscriptionStartDate = json['subscription_start_date'];
    subscriptionEndDate = json['subscription_end_date'];
    isAutoSubscriptionUpgrade = json['is_auto_subscription_upgrade'];
    referenceId = json['reference_id'];
    addedUserId = json['added_user_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    defaultLangCode = json['default_lang_code'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['supplier_name'] = this.supplierName;
    data['supplier_activity_type_id'] = this.supplierActivityTypeId;
    data['company_name'] = this.companyName;
    data['registration_number'] = this.registrationNumber;
    data['reg_no'] = this.regNo;
    data['contact_name'] = this.contactName;
    data['mobile1_isd'] = this.mobile1Isd;
    data['mobile1'] = this.mobile1;
    data['mobile2_isd'] = this.mobile2Isd;
    data['mobile2'] = this.mobile2;
    data['phone1_isd'] = this.phone1Isd;
    data['phone1'] = this.phone1;
    data['phone2_isd'] = this.phone2Isd;
    data['phone2'] = this.phone2;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['area'] = this.area;
    data['country_code'] = this.countryCode;
    data['state_code'] = this.stateCode;
    data['city_code'] = this.cityCode;
    data['zone_code'] = this.zoneCode;
    data['zip'] = this.zip;
    data['no_of_branches'] = this.noOfBranches;
    data['no_of_service_activity_type'] = this.noOfServiceActivityType;
    data['delivery_service'] = this.deliveryService;
    data['priority'] = this.priority;
    data['email'] = this.email;
    data['password'] = this.password;
    data['order_email'] = this.orderEmail;
    data['technical_email'] = this.technicalEmail;
    data['ip'] = this.ip;
    data['supplier_pakage_id'] = this.supplierPakageId;
    data['supplier_pakage_plan_id'] = this.supplierPakagePlanId;
    data['subscription_start_date'] = this.subscriptionStartDate;
    data['subscription_end_date'] = this.subscriptionEndDate;
    data['is_auto_subscription_upgrade'] = this.isAutoSubscriptionUpgrade;
    data['reference_id'] = this.referenceId;
    data['added_user_id'] = this.addedUserId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['default_lang_code'] = this.defaultLangCode;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
    return data;
  }
}*/
