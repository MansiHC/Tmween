class OrderDetailModel {
  int? statusCode;
  String? statusMessage;
  String? message;
  Data? data;

  OrderDetailModel(
      {this.statusCode, this.statusMessage, this.message, this.data});

  OrderDetailModel.fromJson(Map<String, dynamic> json) {
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
  List<OrderData>? orderData;

  Data({this.orderData});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['order_data'] != null) {
      orderData = <OrderData>[];
      json['order_data'].forEach((v) {
        orderData!.add(new OrderData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderData != null) {
      data['order_data'] = this.orderData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderData {
  int? id;
  int? quoteId;
  String? orderNumber;

  /* int? orderSequenceNo;
  int? customerType;
  int? customerId;*/
  String? shipToName;
  String? billToName;
  String? subTotal;
  String? shippingPrice;
  String? taxAmount;
  String? grandTotal;
  String? orderDate;

  /*int? refundAmount;
  String? shippingNotes;
  int? paymentMethodId;
  int? paymentStatus;
  Null? paymentTransactionId;
  Null? paymentRequest;
  Null? paymentResponse;
  Null? remarks;
  Null? paymentDate;

  String? ip;
  int? orderStatusId;
  int? createdBy;
  int? createdUserId;
  String? createdAt;
  String? updatedAt;*/
  List<SalesOrderItem>? salesOrderItem;
  List<SalesOrderAddr>? salesOrderAddr;
  List<PaymentMethodName>? paymentMethodName;

  OrderData(
      {this.id,
      this.quoteId,
      this.orderNumber,
      /* this.orderSequenceNo,
        this.customerType,
        this.customerId,*/
      this.shipToName,
      this.billToName,
      this.subTotal,
      this.shippingPrice,
      this.taxAmount,
      this.grandTotal,
      this.orderDate,
      /* this.refundAmount,
        this.shippingNotes,
        this.paymentMethodId,
        this.paymentStatus,
        this.paymentTransactionId,
        this.paymentRequest,
        this.paymentResponse,
        this.remarks,
        this.paymentDate,

        this.ip,
        this.orderStatusId,
        this.createdBy,
        this.createdUserId,
        this.createdAt,
        this.updatedAt,*/
      this.salesOrderItem,
      this.salesOrderAddr,
      this.paymentMethodName});

  OrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quoteId = json['quote_id'];
    orderNumber = json['order_number'];
    /*orderSequenceNo = json['order_sequence_no'];
    customerType = json['customer_type'];
    customerId = json['customer_id'];*/
    shipToName = json['ship_to_name'];
    billToName = json['bill_to_name'];
    subTotal = json['sub_total'];
    shippingPrice = json['shipping_price'];
    taxAmount = json['tax_amount'];
    grandTotal = json['grand_total'];
    orderDate = json['order_date'];
    /* refundAmount = json['refund_amount'];
    shippingNotes = json['shipping_notes'];
    paymentMethodId = json['payment_method_id'];
    paymentStatus = json['payment_status'];
    paymentTransactionId = json['payment_transaction_id'];
    paymentRequest = json['payment_request'];
    paymentResponse = json['payment_response'];
    remarks = json['remarks'];
    paymentDate = json['payment_date'];

    ip = json['ip'];
    orderStatusId = json['order_status_id'];
    createdBy = json['created_by'];
    createdUserId = json['created_user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];*/
    if (json['sales_order_item'] != null) {
      salesOrderItem = <SalesOrderItem>[];
      json['sales_order_item'].forEach((v) {
        salesOrderItem!.add(new SalesOrderItem.fromJson(v));
      });
    }
    if (json['sales_order_addr'] != null) {
      salesOrderAddr = <SalesOrderAddr>[];
      json['sales_order_addr'].forEach((v) {
        salesOrderAddr!.add(new SalesOrderAddr.fromJson(v));
      });
    }
    if (json['payment_method_name'] != null) {
      paymentMethodName = <PaymentMethodName>[];
      json['payment_method_name'].forEach((v) {
        paymentMethodName!.add(new PaymentMethodName.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quote_id'] = this.quoteId;
    data['order_number'] = this.orderNumber;
    /*data['order_sequence_no'] = this.orderSequenceNo;
    data['customer_type'] = this.customerType;
    data['customer_id'] = this.customerId;*/
    data['ship_to_name'] = this.shipToName;
    data['bill_to_name'] = this.billToName;
    data['sub_total'] = this.subTotal;
    data['shipping_price'] = this.shippingPrice;
    data['tax_amount'] = this.taxAmount;
    data['grand_total'] = this.grandTotal;
    data['order_date'] = this.orderDate;
    /*data['refund_amount'] = this.refundAmount;
    data['shipping_notes'] = this.shippingNotes;
    data['payment_method_id'] = this.paymentMethodId;
    data['payment_status'] = this.paymentStatus;
    data['payment_transaction_id'] = this.paymentTransactionId;
    data['payment_request'] = this.paymentRequest;
    data['payment_response'] = this.paymentResponse;
    data['remarks'] = this.remarks;
    data['payment_date'] = this.paymentDate;

    data['ip'] = this.ip;
    data['order_status_id'] = this.orderStatusId;
    data['created_by'] = this.createdBy;
    data['created_user_id'] = this.createdUserId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;*/
    if (this.salesOrderItem != null) {
      data['sales_order_item'] =
          this.salesOrderItem!.map((v) => v.toJson()).toList();
    }
    if (this.salesOrderAddr != null) {
      data['sales_order_addr'] =
          this.salesOrderAddr!.map((v) => v.toJson()).toList();
    }
    if (this.paymentMethodName != null) {
      data['payment_method_name'] =
          this.paymentMethodName!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SalesOrderItem {
  int? id;

  /*int? salesOrderId;
  String? salesOrderItemNumber;
  int? salesOrderItemSeqNo;
  String? itemInvoiceNumber;*/
  int? productId;

  /*int? itemId;
  int? productPackId;
  String? langCode;*/
  String? productName;

  /* String? itemSku;
  int? unitId;
  int? quantity;
  String? finalPrice;
  int? retailPrice;
  int? subtotal;
  int? freeShipping;
  int? deliveryTimeFactor;
  int? shippingPrice;
  double? taxAmount;
  double? itemTotalAmount;
  String? additionalOptions;
  String? remark;
  int? supplierId;
  String? supplierAssignedDate;
  int? supplierBranchId;
  int? supplierStatusId;
  String? supplierStatusUpdated;
  String? supplierRemark;
  int? daId;
  int? daBranchId;
  String? daAssignedDate;
  String? daEstimatedDeliveryDate;
  int? daStatusId;
  String? daStatusUpdated;
  String? daRemark;
  String? reasonForCancellation;
  int? sellerRatingId;
  int? sellerRating;
  String? sellerRatingComment;
  int? productReviewId;
  int? productRating;
  String? productRatingTitle;
  String? productRatingDescription;
  String? eligibleReturnDate;
  String? supplierComment;
  String? daComment;
  int? itemStatus;
  String? cancellationReason;
  int? cancelledByType;
  int? cancelledById;
  Null? cancelledDate;
  String? createdAt;
  Null? updatedAt;

  String? smallImageUrl;*/
  String? largeImageUrl;
  String? itemStatusLabel;

  List<Slug>? slug;
  String? brandName;

  // String? returnMsg;

  SalesOrderItem({
    this.id,
    /* this.salesOrderId,
        this.salesOrderItemNumber,
        this.salesOrderItemSeqNo,
        this.itemInvoiceNumber,*/
    this.productId,
    /*this.itemId,
        this.productPackId,
        this.langCode,*/
    this.productName,
    /* this.itemSku,
        this.unitId,
        this.quantity,
        this.finalPrice,
        this.retailPrice,
        this.subtotal,
        this.freeShipping,
        this.deliveryTimeFactor,
        this.shippingPrice,
        this.taxAmount,
        this.itemTotalAmount,
        this.additionalOptions,
        this.remark,
        this.supplierId,
        this.supplierAssignedDate,
        this.supplierBranchId,
        this.supplierStatusId,
        this.supplierStatusUpdated,
        this.supplierRemark,
        this.daId,
        this.daBranchId,
        this.daAssignedDate,
        this.daEstimatedDeliveryDate,
        this.daStatusId,
        this.daStatusUpdated,
        this.daRemark,
        this.reasonForCancellation,
        this.sellerRatingId,
        this.sellerRating,
        this.sellerRatingComment,
        this.productReviewId,
        this.productRating,
        this.productRatingTitle,
        this.productRatingDescription,
        this.eligibleReturnDate,
        this.supplierComment,
        this.daComment,
        this.itemStatus,
        this.cancellationReason,
        this.cancelledByType,
        this.cancelledById,
        this.cancelledDate,
        this.createdAt,
        this.updatedAt,

        this.smallImageUrl,*/
    this.largeImageUrl,
    this.itemStatusLabel,
    this.slug,
    this.brandName,
    // this.returnMsg
  });

  SalesOrderItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    /*  salesOrderId = json['sales_order_id'];
    salesOrderItemNumber = json['sales_order_item_number'];
    salesOrderItemSeqNo = json['sales_order_item_seq_no'];
    itemInvoiceNumber = json['item_invoice_number'];*/
    productId = json['product_id'];
    /*itemId = json['item_id'];
    productPackId = json['product_pack_id'];
    langCode = json['lang_code'];*/
    productName = json['product_name'];
    /*itemSku = json['item_sku'];
    unitId = json['unit_id'];
    quantity = json['quantity'];
    finalPrice = json['final_price'];
    retailPrice = json['retail_price'];
    subtotal = json['subtotal'];
    freeShipping = json['free_shipping'];
    deliveryTimeFactor = json['delivery_time_factor'];
    shippingPrice = json['shipping_price'];
    taxAmount = json['tax_amount'];
    itemTotalAmount = json['item_total_amount'];
    additionalOptions = json['additional_options'];
    remark = json['remark'];
    supplierId = json['supplier_id'];
    supplierAssignedDate = json['supplier_assigned_date'];
    supplierBranchId = json['supplier_branch_id'];
    supplierStatusId = json['supplier_status_id'];
    supplierStatusUpdated = json['supplier_status_updated'];
    supplierRemark = json['supplier_remark'];
    daId = json['da_id'];
    daBranchId = json['da_branch_id'];
    daAssignedDate = json['da_assigned_date'];
    daEstimatedDeliveryDate = json['da_estimated_delivery_date'];
    daStatusId = json['da_status_id'];
    daStatusUpdated = json['da_status_updated'];
    daRemark = json['da_remark'];
    reasonForCancellation = json['reason_for_cancellation'];
    sellerRatingId = json['seller_rating_id'];
    sellerRating = json['seller_rating'];
    sellerRatingComment = json['seller_rating_comment'];
    productReviewId = json['product_review_id'];
    productRating = json['product_rating'];
    productRatingTitle = json['product_rating_title'];
    productRatingDescription = json['product_rating_description'];
    eligibleReturnDate = json['eligible_return_date'];
    supplierComment = json['supplier_comment'];
    daComment = json['da_comment'];
    itemStatus = json['item_status'];
    cancellationReason = json['cancellation_reason'];
    cancelledByType = json['cancelled_by_type'];
    cancelledById = json['cancelled_by_id'];
    cancelledDate = json['cancelled_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

    smallImageUrl = json['small_image_url'];*/
    largeImageUrl = json['large_image_url'];
    itemStatusLabel = json['item_status_label'];
    if (json['slug'] != null) {
      slug = <Slug>[];
      json['slug'].forEach((v) {
        slug!.add(new Slug.fromJson(v));
      });
    }
    brandName = json['brand_name'];
    //   returnMsg = json['return_msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    /*  data['sales_order_id'] = this.salesOrderId;
    data['sales_order_item_number'] = this.salesOrderItemNumber;
    data['sales_order_item_seq_no'] = this.salesOrderItemSeqNo;
    data['item_invoice_number'] = this.itemInvoiceNumber;*/
    data['product_id'] = this.productId;
    /* data['item_id'] = this.itemId;
    data['product_pack_id'] = this.productPackId;
    data['lang_code'] = this.langCode;*/
    data['product_name'] = this.productName;
    /* data['item_sku'] = this.itemSku;
    data['unit_id'] = this.unitId;
    data['quantity'] = this.quantity;
    data['final_price'] = this.finalPrice;
    data['retail_price'] = this.retailPrice;
    data['subtotal'] = this.subtotal;
    data['free_shipping'] = this.freeShipping;
    data['delivery_time_factor'] = this.deliveryTimeFactor;
    data['shipping_price'] = this.shippingPrice;
    data['tax_amount'] = this.taxAmount;
    data['item_total_amount'] = this.itemTotalAmount;
    data['additional_options'] = this.additionalOptions;
    data['remark'] = this.remark;
    data['supplier_id'] = this.supplierId;
    data['supplier_assigned_date'] = this.supplierAssignedDate;
    data['supplier_branch_id'] = this.supplierBranchId;
    data['supplier_status_id'] = this.supplierStatusId;
    data['supplier_status_updated'] = this.supplierStatusUpdated;
    data['supplier_remark'] = this.supplierRemark;
    data['da_id'] = this.daId;
    data['da_branch_id'] = this.daBranchId;
    data['da_assigned_date'] = this.daAssignedDate;
    data['da_estimated_delivery_date'] = this.daEstimatedDeliveryDate;
    data['da_status_id'] = this.daStatusId;
    data['da_status_updated'] = this.daStatusUpdated;
    data['da_remark'] = this.daRemark;
    data['reason_for_cancellation'] = this.reasonForCancellation;
    data['seller_rating_id'] = this.sellerRatingId;
    data['seller_rating'] = this.sellerRating;
    data['seller_rating_comment'] = this.sellerRatingComment;
    data['product_review_id'] = this.productReviewId;
    data['product_rating'] = this.productRating;
    data['product_rating_title'] = this.productRatingTitle;
    data['product_rating_description'] = this.productRatingDescription;
    data['eligible_return_date'] = this.eligibleReturnDate;
    data['supplier_comment'] = this.supplierComment;
    data['da_comment'] = this.daComment;
    data['item_status'] = this.itemStatus;
    data['cancellation_reason'] = this.cancellationReason;
    data['cancelled_by_type'] = this.cancelledByType;
    data['cancelled_by_id'] = this.cancelledById;
    data['cancelled_date'] = this.cancelledDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;

    data['small_image_url'] = this.smallImageUrl;*/
    data['large_image_url'] = this.largeImageUrl;
    data['item_status_label'] = this.itemStatusLabel;
    if (this.slug != null) {
      data['slug'] = this.slug!.map((v) => v.toJson()).toList();
    }
    data['brand_name'] = this.brandName;
    // data['return_msg'] = this.returnMsg;
    return data;
  }
}

class Slug {
  String? productSlug;

  Slug({this.productSlug});

  Slug.fromJson(Map<String, dynamic> json) {
    productSlug = json['product_slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_slug'] = this.productSlug;
    return data;
  }
}

class SalesOrderAddr {
  int? id;

  /* int? salesOrderId;
  Null? email;*/
  String? fullname;
  Null? lastName;

  /* String? phone1Isd;
  String? phone1;
  String? mobile1Isd;
  String? mobile1;
  int? addressType;
  int? shippingAddressType;*/
  String? address1;
  String? address2;

  /* String? area;
  String? countryCode;
  String? stateCode;
  String? cityCode;*/
  String? zip;
  String? country;
  String? state;
  String? city;

  SalesOrderAddr(
      {this.id,
      /* this.salesOrderId,
        this.email,*/
      this.fullname,
      this.lastName,
      /* this.phone1Isd,
        this.phone1,
        this.mobile1Isd,
        this.mobile1,
        this.addressType,
        this.shippingAddressType,*/
      this.address1,
      this.address2,
      /*  this.area,
        this.countryCode,
        this.stateCode,
        this.cityCode,*/
      this.zip,
      this.country,
      this.state,
      this.city});

  SalesOrderAddr.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    /* salesOrderId = json['sales_order_id'];
    email = json['email'];*/
    fullname = json['fullname'];
    /* lastName = json['last_name'];
    phone1Isd = json['phone1_isd'];
    phone1 = json['phone1'];
    mobile1Isd = json['mobile1_isd'];
    mobile1 = json['mobile1'];
    addressType = json['address_type'];
    shippingAddressType = json['shipping_address_type'];*/
    address1 = json['address1'];
    address2 = json['address2'];
    /* area = json['area'];
    countryCode = json['country_code'];
    stateCode = json['state_code'];
    cityCode = json['city_code'];*/
    zip = json['zip'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    /* data['sales_order_id'] = this.salesOrderId;
    data['email'] = this.email;*/
    data['fullname'] = this.fullname;
    data['last_name'] = this.lastName;
    /*  data['phone1_isd'] = this.phone1Isd;
    data['phone1'] = this.phone1;
    data['mobile1_isd'] = this.mobile1Isd;
    data['mobile1'] = this.mobile1;
    data['address_type'] = this.addressType;
    data['shipping_address_type'] = this.shippingAddressType;*/
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    /*data['area'] = this.area;
    data['country_code'] = this.countryCode;
    data['state_code'] = this.stateCode;
    data['city_code'] = this.cityCode;*/
    data['zip'] = this.zip;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    return data;
  }
}

class PaymentMethodName {
  int? id;
  String? methodName;

  /*String? methodCode;
  String? image;
  int? type;
  int? displayNumber;
  int? subscriptionStatusAfterPayment;
  int? orderStatusAfterPayment;
  int? frontStatus;
  int? adminStatus;
  String? methodModel;
  Null? createdAt;
  String? updatedAt;
  List<PaymentMethodLanguage>? paymentMethodLanguage;
  List<PaymentMethodCredential>? paymentMethodCredential;*/

  PaymentMethodName({
    this.id,
    this.methodName,
    /* this.methodCode,
        this.image,
        this.type,
        this.displayNumber,
        this.subscriptionStatusAfterPayment,
        this.orderStatusAfterPayment,
        this.frontStatus,
        this.adminStatus,
        this.methodModel,
        this.createdAt,
        this.updatedAt,
        this.paymentMethodLanguage,
        this.paymentMethodCredential*/
  });

  PaymentMethodName.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    methodName = json['method_name'];
    /* methodCode = json['method_code'];
    image = json['image'];
    type = json['type'];
    displayNumber = json['display_number'];
    subscriptionStatusAfterPayment = json['subscription_status_after_payment'];
    orderStatusAfterPayment = json['order_status_after_payment'];
    frontStatus = json['front_status'];
    adminStatus = json['admin_status'];
    methodModel = json['method_model'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['payment_method_language'] != null) {
      paymentMethodLanguage = <PaymentMethodLanguage>[];
      json['payment_method_language'].forEach((v) {
        paymentMethodLanguage!.add(new PaymentMethodLanguage.fromJson(v));
      });
    }
    if (json['payment_method_credential'] != null) {
      paymentMethodCredential = <PaymentMethodCredential>[];
      json['payment_method_credential'].forEach((v) {
        paymentMethodCredential!.add(new PaymentMethodCredential.fromJson(v));
      });
    }*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['method_name'] = this.methodName;
    /* data['method_code'] = this.methodCode;
    data['image'] = this.image;
    data['type'] = this.type;
    data['display_number'] = this.displayNumber;
    data['subscription_status_after_payment'] =
        this.subscriptionStatusAfterPayment;
    data['order_status_after_payment'] = this.orderStatusAfterPayment;
    data['front_status'] = this.frontStatus;
    data['admin_status'] = this.adminStatus;
    data['method_model'] = this.methodModel;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.paymentMethodLanguage != null) {
      data['payment_method_language'] =
          this.paymentMethodLanguage!.map((v) => v.toJson()).toList();
    }
    if (this.paymentMethodCredential != null) {
      data['payment_method_credential'] =
          this.paymentMethodCredential!.map((v) => v.toJson()).toList();
    }
   */
    return data;
  }
}

class PaymentMethodLanguage {
  int? id;
  int? paymentMethodId;
  String? langCode;
  String? title;

  PaymentMethodLanguage(
      {this.id, this.paymentMethodId, this.langCode, this.title});

  PaymentMethodLanguage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentMethodId = json['payment_method_id'];
    langCode = json['lang_code'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['payment_method_id'] = this.paymentMethodId;
    data['lang_code'] = this.langCode;
    data['title'] = this.title;
    return data;
  }
}

class PaymentMethodCredential {
  int? id;
  int? paymentMethodId;
  String? code;
  String? label;
  String? value;

  PaymentMethodCredential(
      {this.id, this.paymentMethodId, this.code, this.label, this.value});

  PaymentMethodCredential.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentMethodId = json['payment_method_id'];
    code = json['code'];
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['payment_method_id'] = this.paymentMethodId;
    data['code'] = this.code;
    data['label'] = this.label;
    data['value'] = this.value;
    return data;
  }
}
