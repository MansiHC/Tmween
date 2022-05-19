class AttributeCombinationModel {
  int? statusCode;
  String? statusMessage;
  String? message;
  AttributeData? data;

  AttributeCombinationModel(
      {this.statusCode, this.statusMessage, this.message, this.data});

  AttributeCombinationModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    statusMessage = json['status_message'];
    message = json['message'];
    if (statusCode == 200)
      data = json['data'] != null
          ? new AttributeData.fromJson(json['data'])
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

class AttributeData {
  List<ProductMainSupplier>? productMainSupplier;
  List<ProductOtherSupplier>? productOtherSupplier;
  List<ProductQtyPackData>? productQtyPackData;
  ProductDeliveryData? productDeliveryData;
  int? selectAttributeWiseImageShow;
  List<GalleryAndAttributeComArr>? galleryAndAttributeComArr;

  //List<Null>? productAssociateAttributeData;

  AttributeData({
    this.galleryAndAttributeComArr,
    this.productMainSupplier,
    this.productOtherSupplier,
    this.productQtyPackData,
    this.productDeliveryData,
    this.selectAttributeWiseImageShow,
    /* this.productAssociateAttributeData*/
  });

  AttributeData.fromJson(Map<String, dynamic> json) {
    if (json['gallery_and_attribute_com_arr'] != null) {
      galleryAndAttributeComArr = <GalleryAndAttributeComArr>[];
      json['gallery_and_attribute_com_arr'].forEach((v) {
        galleryAndAttributeComArr!
            .add(new GalleryAndAttributeComArr.fromJson(v));
      });
    }
    if (json['product_main_supplier'] != null) {
      productMainSupplier = <ProductMainSupplier>[];
      json['product_main_supplier'].forEach((v) {
        productMainSupplier!.add(new ProductMainSupplier.fromJson(v));
      });
    }
    if (productMainSupplier!.length != 0) {
      if (json['product_other_supplier'] != null) {
        productOtherSupplier = <ProductOtherSupplier>[];
        json['product_other_supplier'].forEach((v) {
          productOtherSupplier!.add(new ProductOtherSupplier.fromJson(v));
        });
      }
      if (json['product_qty_pack_data'] != null) {
        productQtyPackData = <ProductQtyPackData>[];
        json['product_qty_pack_data'].forEach((v) {
          productQtyPackData!.add(new ProductQtyPackData.fromJson(v));
        });
      }
      try {
        productDeliveryData = json['product_delivery_data'] != null
            ? new ProductDeliveryData.fromJson(json['product_delivery_data'])
            : null;
      } catch (e) {
        productDeliveryData = null;
      }
      selectAttributeWiseImageShow = json['select_attribute_wise_image_show'];
    }
    /*if (json['product_associate_attribute_data'] != null) {
      productAssociateAttributeData = <Null>[];
      json['product_associate_attribute_data'].forEach((v) {
        productAssociateAttributeData!.add(new Null.fromJson(v));
      });
    }*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.galleryAndAttributeComArr != null) {
      data['gallery_and_attribute_com_arr'] =
          this.galleryAndAttributeComArr!.map((v) => v.toJson()).toList();
    }
    if (this.productMainSupplier != null) {
      data['product_main_supplier'] =
          this.productMainSupplier!.map((v) => v.toJson()).toList();
    }
    if (this.productOtherSupplier != null) {
      data['product_other_supplier'] =
          this.productOtherSupplier!.map((v) => v.toJson()).toList();
    }
    if (this.productQtyPackData != null) {
      data['product_qty_pack_data'] =
          this.productQtyPackData!.map((v) => v.toJson()).toList();
    }
    if (this.productDeliveryData != null) {
      data['product_delivery_data'] = this.productDeliveryData!.toJson();
    }
    data['select_attribute_wise_image_show'] =
        this.selectAttributeWiseImageShow;
    /* if (this.productAssociateAttributeData != null) {
      data['product_associate_attribute_data'] =
          this.productAssociateAttributeData!.map((v) => v.toJson()).toList();
    }*/
    return data;
  }
}

class GalleryAndAttributeComArr {
  int? id;
  String? image;
  int? status;
  String? fancyBoxUrl;
  String? smallImageUrl;
  String? largeImageUrl;
  int? productId;
  int? orderBy;

  GalleryAndAttributeComArr(
      {this.id,
      this.image,
      this.status,
      this.fancyBoxUrl,
      this.smallImageUrl,
      this.largeImageUrl,
      this.productId,
      this.orderBy});

  GalleryAndAttributeComArr.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    status = json['status'];
    fancyBoxUrl = json['fancy_box_url'];
    smallImageUrl = json['small_image_url'];
    largeImageUrl = json['large_image_url'];
    productId = json['product_id'];
    orderBy = json['order_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['status'] = this.status;
    data['fancy_box_url'] = this.fancyBoxUrl;
    data['small_image_url'] = this.smallImageUrl;
    data['large_image_url'] = this.largeImageUrl;
    data['product_id'] = this.productId;
    data['order_by'] = this.orderBy;
    return data;
  }
}

class ProductMainSupplier {
  int? id;
  int? productItemId;
  int? supplierId;
  String? supplierSku;
  int? productPackId;
  String? pack;
  int? price;
  int? status;
  String? supplierName;
  int? priority;
  int? supplierPakageId;
  int? supplierPakagePlanId;
  int? isSystemSupplier;
  String? priceDisp;

  ProductMainSupplier(
      {this.id,
      this.productItemId,
      this.supplierId,
      this.supplierSku,
      this.productPackId,
      this.pack,
      this.price,
      this.status,
      this.supplierName,
      this.priority,
      this.supplierPakageId,
      this.supplierPakagePlanId,
      this.isSystemSupplier,
      this.priceDisp});

  ProductMainSupplier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productItemId = json['product_item_id'];
    supplierId = json['supplier_id'];
    supplierSku = json['supplier_sku'];
    productPackId = json['product_pack_id'];
    pack = json['pack'];
    price = json['price'];
    status = json['status'];
    supplierName = json['supplier_name'];
    priority = json['priority'];
    supplierPakageId = json['supplier_pakage_id'];
    supplierPakagePlanId = json['supplier_pakage_plan_id'];
    isSystemSupplier = json['is_system_supplier'];
    priceDisp = json['price_disp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_item_id'] = this.productItemId;
    data['supplier_id'] = this.supplierId;
    data['supplier_sku'] = this.supplierSku;
    data['product_pack_id'] = this.productPackId;
    data['pack'] = this.pack;
    data['price'] = this.price;
    data['status'] = this.status;
    data['supplier_name'] = this.supplierName;
    data['priority'] = this.priority;
    data['supplier_pakage_id'] = this.supplierPakageId;
    data['supplier_pakage_plan_id'] = this.supplierPakagePlanId;
    data['is_system_supplier'] = this.isSystemSupplier;
    data['price_disp'] = this.priceDisp;
    return data;
  }
}

class ProductOtherSupplier {
  int? id;
  int? productItemId;
  int? supplierId;
  String? supplierSku;
  int? productPackId;
  String? pack;
  int? price;
  int? status;
  String? supplierName;
  int? priority;
  int? supplierPakageId;
  int? supplierPakagePlanId;
  int? isSystemSupplier;
  String? priceDisp;

  ProductOtherSupplier(
      {this.id,
      this.productItemId,
      this.supplierId,
      this.supplierSku,
      this.productPackId,
      this.pack,
      this.price,
      this.status,
      this.supplierName,
      this.priority,
      this.supplierPakageId,
      this.supplierPakagePlanId,
      this.isSystemSupplier,
      this.priceDisp});

  ProductOtherSupplier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productItemId = json['product_item_id'];
    supplierId = json['supplier_id'];
    supplierSku = json['supplier_sku'];
    productPackId = json['product_pack_id'];
    pack = json['pack'];
    price = json['price'];
    status = json['status'];
    supplierName = json['supplier_name'];
    priority = json['priority'];
    supplierPakageId = json['supplier_pakage_id'];
    supplierPakagePlanId = json['supplier_pakage_plan_id'];
    isSystemSupplier = json['is_system_supplier'];
    priceDisp = json['price_disp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_item_id'] = this.productItemId;
    data['supplier_id'] = this.supplierId;
    data['supplier_sku'] = this.supplierSku;
    data['product_pack_id'] = this.productPackId;
    data['pack'] = this.pack;
    data['price'] = this.price;
    data['status'] = this.status;
    data['supplier_name'] = this.supplierName;
    data['priority'] = this.priority;
    data['supplier_pakage_id'] = this.supplierPakageId;
    data['supplier_pakage_plan_id'] = this.supplierPakagePlanId;
    data['is_system_supplier'] = this.isSystemSupplier;
    data['price_disp'] = this.priceDisp;
    return data;
  }
}

class ProductQtyPackData {
  int? supplierId;
  int? productPackId;
  String? pack;
  int? qty;
  int? supplierBranchId;
  int? price;
  String? priceDisp;

  ProductQtyPackData(
      {this.supplierId,
      this.productPackId,
      this.pack,
      this.qty,
      this.supplierBranchId,
      this.price,
      this.priceDisp});

  ProductQtyPackData.fromJson(Map<String, dynamic> json) {
    supplierId = json['supplier_id'];
    productPackId = json['product_pack_id'];
    pack = json['pack'];
    qty = json['qty'];
    supplierBranchId = json['supplier_branch_id'];
    price = json['price'];
    priceDisp = json['price_disp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['supplier_id'] = this.supplierId;
    data['product_pack_id'] = this.productPackId;
    data['pack'] = this.pack;
    data['qty'] = this.qty;
    data['supplier_branch_id'] = this.supplierBranchId;
    data['price'] = this.price;
    data['price_disp'] = this.priceDisp;
    return data;
  }
}

class ProductDeliveryData {
  int? id;
  int? daId;
  String? address1;
  String? address2;
  String? address3;
  String? countryCode;
  String? stateCode;
  String? cityCode;
  String? zoneCode;
  String? zip;
  String? latitude;
  String? longitude;
  String? plusCode;
  String? deliveryAgencyName;
  double? daMarginAmount;
  DistanceData? distanceData;
  double? deliveryPrice;
  String? deliveryPriceLabel;
  String? deliveryDurationLabel;

  ProductDeliveryData(
      {this.id,
      this.daId,
      this.address1,
      this.address2,
      this.address3,
      this.countryCode,
      this.stateCode,
      this.cityCode,
      this.zoneCode,
      this.zip,
      this.latitude,
      this.longitude,
      this.plusCode,
      this.deliveryAgencyName,
      this.daMarginAmount,
      this.distanceData,
      this.deliveryPrice,
      this.deliveryPriceLabel,
      this.deliveryDurationLabel});

  ProductDeliveryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    daId = json['da_id'];
    address1 = json['address1'];
    address2 = json['address2'];
    address3 = json['address3'];
    countryCode = json['country_code'];
    stateCode = json['state_code'];
    cityCode = json['city_code'];
    zoneCode = json['zone_code'];
    zip = json['zip'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    plusCode = json['plus_code'];
    deliveryAgencyName = json['delivery_agency_name'];
    daMarginAmount = json['da_margin_amount'];
    distanceData = json['distance_data'] != null
        ? new DistanceData.fromJson(json['distance_data'])
        : null;
    deliveryPrice = double.parse(json['delivery_price'].toString());
    deliveryPriceLabel = json['delivery_price_label'];
    deliveryDurationLabel = json['delivery_duration_label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['da_id'] = this.daId;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['address3'] = this.address3;
    data['country_code'] = this.countryCode;
    data['state_code'] = this.stateCode;
    data['city_code'] = this.cityCode;
    data['zone_code'] = this.zoneCode;
    data['zip'] = this.zip;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['plus_code'] = this.plusCode;
    data['delivery_agency_name'] = this.deliveryAgencyName;
    data['da_margin_amount'] = this.daMarginAmount;
    if (this.distanceData != null) {
      data['distance_data'] = this.distanceData!.toJson();
    }
    data['delivery_price'] = this.deliveryPrice;
    data['delivery_price_label'] = this.deliveryPriceLabel;
    data['delivery_duration_label'] = this.deliveryDurationLabel;
    return data;
  }
}

class DistanceData {
  String? distance;
  int? distanceValue;
  String? duration;
  int? durationValue;

  DistanceData(
      {this.distance, this.distanceValue, this.duration, this.durationValue});

  DistanceData.fromJson(Map<String, dynamic> json) {
    distance = json['distance'];
    distanceValue = json['distance_value'];
    duration = json['duration'];
    durationValue = json['duration_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['distance'] = this.distance;
    data['distance_value'] = this.distanceValue;
    data['duration'] = this.duration;
    data['duration_value'] = this.durationValue;
    return data;
  }
}
