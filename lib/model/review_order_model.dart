class ReviewOrderModel {
  int? statusCode;
  String? statusMessage;
  String? message;
  ReviewOrderData? data;

  ReviewOrderModel(
      {this.statusCode, this.statusMessage, this.message, this.data});

  ReviewOrderModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    statusMessage = json['status_message'];
    message = json['message'];
    data = json['data'] != null ? new ReviewOrderData.fromJson(json['data']) : null;
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

class ReviewOrderData {
  QuotesData? quotesData;
  CartDetail? cartDetail;

  ReviewOrderData({this.quotesData, this.cartDetail});

  ReviewOrderData.fromJson(Map<String, dynamic> json) {
    quotesData = json['quotes_data'] != null
        ? new QuotesData.fromJson(json['quotes_data'])
        : null;
    cartDetail = json['cart_detail'] != null
        ? new CartDetail.fromJson(json['cart_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.quotesData != null) {
      data['quotes_data'] = this.quotesData!.toJson();
    }
    if (this.cartDetail != null) {
      data['cart_detail'] = this.cartDetail!.toJson();
    }
    return data;
  }
}

class QuotesData {
  QuoteDetails? quoteDetails;
  List<QuoteItemData>? quoteItemData;

  QuotesData({this.quoteDetails, this.quoteItemData});

  QuotesData.fromJson(Map<String, dynamic> json) {
    quoteDetails = json['quote_details'] != null
        ? new QuoteDetails.fromJson(json['quote_details'])
        : null;
    if (json['quote_item_data'] != null) {
      quoteItemData = <QuoteItemData>[];
      json['quote_item_data'].forEach((v) {
        quoteItemData!.add(new QuoteItemData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.quoteDetails != null) {
      data['quote_details'] = this.quoteDetails!.toJson();
    }
    if (this.quoteItemData != null) {
      data['quote_item_data'] =
          this.quoteItemData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuoteDetails {
  int? id;
  String? quoteNo;
  int? currentQuotesNo;
  int? customerId;
  int? customerAddressId;
  double? subTotal;
  double? shippingPrice;
  double? taxAmount;
  double? grandTotal;
  String? shippingNotes;
  int? paymentMethodId;
  String? quoteCreatedDate;
  String? quoteUpdatedDate;
  int? status;
  String? ip;
  String? paymentMethod;

  QuoteDetails(
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
        this.paymentMethod});

  QuoteDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quoteNo = json['quote_no'];
    currentQuotesNo = json['current_quotes_no'];
    customerId = json['customer_id'];
    customerAddressId = json['customer_address_id'];
    subTotal = double.parse(json['sub_total'].toString());
    shippingPrice = double.parse(json['shipping_price'].toString());
    taxAmount = double.parse(json['tax_amount'].toString());
    grandTotal = double.parse(json['grand_total'].toString());
    shippingNotes = json['shipping_notes'];
    paymentMethodId = json['payment_method_id'];
    quoteCreatedDate = json['quote_created_date'];
    quoteUpdatedDate = json['quote_updated_date'];
    status = json['status'];
    ip = json['ip'];
    paymentMethod = json['payment_method'];
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
    data['payment_method'] = this.paymentMethod;
    return data;
  }
}

class QuoteItemData {
  int? id;
  String? quoteNo;
  int? currentQuotesNo;
  int? customerId;
  int? customerAddressId;
  double? subTotal;
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
  String? attributeOptions;
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
  Null? daEstimatedDeliveryDate;
  int? deliveryTimeFactor;
  double? normalDeliveryPrice;
  double? quickDeliveryPrice;
  double? itemTotalAmount;
  String? createdAt;
  String? updatedAt;
  String? image;
  int? reviewsAvg;
  String? supplierName;
  String? pName;
  String? productSlug;
  String? smallImageUrl;
  String? largeImageUrl;
  String? shippingPriceLabel;
  String? normalDeliveryPriceLabel;
  String? quickDeliveryPriceLabel;
  String? prodImage;

  QuoteItemData(
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
        this.attributeOptions,
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

  QuoteItemData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quoteNo = json['quote_no'];
    currentQuotesNo = json['current_quotes_no'];
    customerId = json['customer_id'];
    customerAddressId = json['customer_address_id'];
    subTotal = double.parse(json['sub_total'].toString());
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
    attributeOptions = json['attribute_options'];
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
    reviewsAvg = json['reviews_avg'];
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
    data['attribute_options'] = this.attributeOptions;
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

class CartDetail {
  String? paymentMethod;
  double? totalPrice;
  String? currencyCode;
  double? totalDeliveryPrice;
  double? totalTaxAmount;
  int? totalItems;
  List<CustomerAddressDetails>? customerAddressDetails;

  CartDetail(
      {this.paymentMethod,
        this.totalPrice,
        this.currencyCode,
        this.totalDeliveryPrice,
        this.totalTaxAmount,
        this.totalItems,
        this.customerAddressDetails});

  CartDetail.fromJson(Map<String, dynamic> json) {
    paymentMethod = json['payment_method'];
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
    data['payment_method'] = this.paymentMethod;
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
