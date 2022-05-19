class EditCartQuantityModel {
  int? statusCode;
  String? statusMessage;
  String? message;
  Data? data;

  EditCartQuantityModel(
      {this.statusCode, this.statusMessage, this.message, this.data});

  EditCartQuantityModel.fromJson(Map<String, dynamic> json) {
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
  List<Quote>? quote;
  List<QuoteItem>? quoteItem;
  int? cartTotalItems;

  Data({this.quote, this.quoteItem, this.cartTotalItems});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['quote'] != null) {
      quote = <Quote>[];
      json['quote'].forEach((v) {
        quote!.add(new Quote.fromJson(v));
      });
    }
    if (json['quote_item'] != null) {
      quoteItem = <QuoteItem>[];
      json['quote_item'].forEach((v) {
        quoteItem!.add(new QuoteItem.fromJson(v));
      });
    }
    cartTotalItems = json['cart_total_items'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.quote != null) {
      data['quote'] = this.quote!.map((v) => v.toJson()).toList();
    }
    if (this.quoteItem != null) {
      data['quote_item'] = this.quoteItem!.map((v) => v.toJson()).toList();
    }
    data['cart_total_items'] = this.cartTotalItems;
    return data;
  }
}

class Quote {
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

  Quote(
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
      this.ip});

  Quote.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class QuoteItem {
  int? id;
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
  double? finalPrice;
  double? retailPrice;
  int? unitId;
  int? quantity;
  int? weight;
  int? weightUnitId;
  int? freeShipping;
  double? itemFinalTotal;
  double? shippingPrice;
  Null? daEstimatedDeliveryDate;
  int? deliveryTimeFactor;
  double? normalDeliveryPrice;
  double? quickDeliveryPrice;
  double? taxAmount;
  double? itemTotalAmount;
  int? status;
  String? createdAt;
  String? updatedAt;

  QuoteItem(
      {this.id,
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
      this.shippingPrice,
      this.daEstimatedDeliveryDate,
      this.deliveryTimeFactor,
      this.normalDeliveryPrice,
      this.quickDeliveryPrice,
      this.taxAmount,
      this.itemTotalAmount,
      this.status,
      this.createdAt,
      this.updatedAt});

  QuoteItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    finalPrice = double.parse(json['final_price'].toString());
    retailPrice = double.parse(json['retail_price'].toString());
    unitId = json['unit_id'];
    quantity = json['quantity'];
    weight = json['weight'];
    weightUnitId = json['weight_unit_id'];
    freeShipping = json['free_shipping'];
    itemFinalTotal = double.parse(json['item_final_total'].toString());
    shippingPrice = double.parse(json['shipping_price'].toString());
    daEstimatedDeliveryDate = json['da_estimated_delivery_date'];
    deliveryTimeFactor = json['delivery_time_factor'];
    normalDeliveryPrice =
        double.parse(json['normal_delivery_price'].toString());
    quickDeliveryPrice = double.parse(json['quick_delivery_price'].toString());
    taxAmount = double.parse(json['tax_amount'].toString());
    itemTotalAmount = double.parse(json['item_total_amount'].toString());
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
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
    data['shipping_price'] = this.shippingPrice;
    data['da_estimated_delivery_date'] = this.daEstimatedDeliveryDate;
    data['delivery_time_factor'] = this.deliveryTimeFactor;
    data['normal_delivery_price'] = this.normalDeliveryPrice;
    data['quick_delivery_price'] = this.quickDeliveryPrice;
    data['tax_amount'] = this.taxAmount;
    data['item_total_amount'] = this.itemTotalAmount;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
