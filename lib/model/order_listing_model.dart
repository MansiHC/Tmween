class OrderListingModel {
  int? statusCode;
  String? statusMessage;
  String? message;
  OrderListData? data;

  OrderListingModel(
      {this.statusCode, this.statusMessage, this.message, this.data});

  OrderListingModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    statusMessage = json['status_message'];
    message = json['message'];
    if (statusCode == 200)
      data = json['data'] != null
          ? new OrderListData.fromJson(json['data'])
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

class OrderListData {
  List<OrderData>? orderData;
  int? totalPages;
  var next;
  var previous;
  int? totalRecords;

  OrderListData(
      {this.orderData,
      this.totalPages,
      this.next,
      this.previous,
      this.totalRecords});

  OrderListData.fromJson(Map<String, dynamic> json) {
    if (json['order_data'] != null) {
      orderData = <OrderData>[];
      json['order_data'].forEach((v) {
        orderData!.add(new OrderData.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    next = json['next'];
    previous = json['previous'];
    totalRecords = json['total_records'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderData != null) {
      data['order_data'] = this.orderData!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = this.totalPages;
    data['next'] = this.next;
    data['previous'] = this.previous;
    data['total_records'] = this.totalRecords;
    return data;
  }
}

class OrderData {
  int? id;
  int? quoteId;
  String? orderNumber;
  String? itemStatusLabel;

  /*int? orderSequenceNo;
  int? customerType;
  int? customerId;
  String? shipToName;
  String? billToName;
  String? subTotal;
  String? shippingPrice;
  String? taxAmount;
  String? grandTotal;
  int? refundAmount;
  String? shippingNotes;
  int? paymentMethodId;
  int? paymentStatus;
  String? paymentTransactionId;
  String? paymentRequest;
  Null? paymentResponse;
  Null? remarks;
  Null? paymentDate;
  String? orderDate;
  String? ip;
  int? orderStatusId;
  int? createdBy;
  int? createdUserId;
  String? createdAt;
  String? updatedAt;*/
  List<SalesOrderItem>? salesOrderItem;

  OrderData(
      {this.id,
      this.quoteId,
      this.orderNumber,
      this.itemStatusLabel,
      /*  this.orderSequenceNo,
        this.customerType,
        this.customerId,
        this.shipToName,
        this.billToName,
        this.subTotal,
        this.shippingPrice,
        this.taxAmount,
        this.grandTotal,
        this.refundAmount,
        this.shippingNotes,
        this.paymentMethodId,
        this.paymentStatus,
        this.paymentTransactionId,
        this.paymentRequest,
        this.paymentResponse,
        this.remarks,
        this.paymentDate,
        this.orderDate,
        this.ip,
        this.orderStatusId,
        this.createdBy,
        this.createdUserId,
        this.createdAt,
        this.updatedAt,*/
      this.salesOrderItem});

  OrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quoteId = json['quote_id'];
    orderNumber = json['order_number'];
    itemStatusLabel = json['item_status_label'];
    /* orderSequenceNo = json['order_sequence_no'];
    customerType = json['customer_type'];
    customerId = json['customer_id'];
    shipToName = json['ship_to_name'];
    billToName = json['bill_to_name'];
    subTotal = json['sub_total'];
    shippingPrice = json['shipping_price'];
    taxAmount = json['tax_amount'];
    grandTotal = json['grand_total'];
    refundAmount = json['refund_amount'];
    shippingNotes = json['shipping_notes'];
    paymentMethodId = json['payment_method_id'];
    paymentStatus = json['payment_status'];
    paymentTransactionId = json['payment_transaction_id'];
    paymentRequest = json['payment_request'];
    paymentResponse = json['payment_response'];
    remarks = json['remarks'];
    paymentDate = json['payment_date'];
    orderDate = json['order_date'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quote_id'] = this.quoteId;
    data['order_number'] = this.orderNumber;
    data['item_status_label'] = this.itemStatusLabel;
    /*  data['order_sequence_no'] = this.orderSequenceNo;
    data['customer_type'] = this.customerType;
    data['customer_id'] = this.customerId;
    data['ship_to_name'] = this.shipToName;
    data['bill_to_name'] = this.billToName;
    data['sub_total'] = this.subTotal;
    data['shipping_price'] = this.shippingPrice;
    data['tax_amount'] = this.taxAmount;
    data['grand_total'] = this.grandTotal;
    data['refund_amount'] = this.refundAmount;
    data['shipping_notes'] = this.shippingNotes;
    data['payment_method_id'] = this.paymentMethodId;
    data['payment_status'] = this.paymentStatus;
    data['payment_transaction_id'] = this.paymentTransactionId;
    data['payment_request'] = this.paymentRequest;
    data['payment_response'] = this.paymentResponse;
    data['remarks'] = this.remarks;
    data['payment_date'] = this.paymentDate;
    data['order_date'] = this.orderDate;
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
    return data;
  }
}

class SalesOrderItem {
  int? id;
  int? salesOrderId;

  /*String? salesOrderItemNumber;
  int? salesOrderItemSeqNo;
  String? itemInvoiceNumber;*/
  int? productId;
  int? itemId;

  /* int? productPackId;
  String? langCode;*/
  String? productName;
  double? reviewsAvg;

  /*String? itemSku;
  int? unitId;
  int? quantity;
  String? finalPrice;
  String? retailPrice;
  String? subtotal;
  int? freeShipping;
  int? deliveryTimeFactor;
  String? shippingPrice;
  String? taxAmount;
  String? itemTotalAmount;
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
  int? productReviewId;*/
  int? productRating;

  /* String? productRatingTitle;
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
  String? returnMsg;
  String? smallImageUrl;*/
  String? largeImageUrl;
  List<Slug>? slug;

  SalesOrderItem(
      {this.id,
      this.salesOrderId,
      /* this.salesOrderItemNumber,
        this.salesOrderItemSeqNo,
        this.itemInvoiceNumber,*/
      this.productId,
      this.itemId,
      /* this.productPackId,
        this.langCode,*/
      this.productName,
        this.reviewsAvg,
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
        this.returnMsg,
        this.smallImageUrl,*/
      this.largeImageUrl,
      this.slug});

  SalesOrderItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    salesOrderId = json['sales_order_id'];
    /* salesOrderItemNumber = json['sales_order_item_number'];
    salesOrderItemSeqNo = json['sales_order_item_seq_no'];
    itemInvoiceNumber = json['item_invoice_number'];*/
    productId = json['product_id'];
    itemId = json['item_id'];
    reviewsAvg = double.parse(json['reviews_avg'].toString());
    //  productPackId = json['product_pack_id'];
    //langCode = json['lang_code'];
    productName = json['product_name'];
    /* itemSku = json['item_sku'];
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
    productReviewId = json['product_review_id'];*/
    productRating = json['product_rating'];
    /*productRatingTitle = json['product_rating_title'];
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
    returnMsg = json['return_msg'];
    smallImageUrl = json['small_image_url'];*/
    largeImageUrl = json['large_image_url'];
    if (json['slug'] != null) {
      slug = <Slug>[];
      json['slug'].forEach((v) {
        slug!.add(new Slug.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sales_order_id'] = this.salesOrderId;
    /* data['sales_order_item_number'] = this.salesOrderItemNumber;
    data['sales_order_item_seq_no'] = this.salesOrderItemSeqNo;
    data['item_invoice_number'] = this.itemInvoiceNumber;*/
    data['product_id'] = this.productId;
    data['item_id'] = this.itemId;
    data['reviews_avg'] = this.reviewsAvg;
    /*  data['product_pack_id'] = this.productPackId;
    data['lang_code'] = this.langCode;*/
    data['product_name'] = this.productName;
    /*data['item_sku'] = this.itemSku;
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
    data['product_review_id'] = this.productReviewId;*/
    data['product_rating'] = this.productRating;
    /*data['product_rating_title'] = this.productRatingTitle;
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
    data['return_msg'] = this.returnMsg;
    data['small_image_url'] = this.smallImageUrl;*/
    data['large_image_url'] = this.largeImageUrl;
    if (this.slug != null) {
      data['slug'] = this.slug!.map((v) => v.toJson()).toList();
    }
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
