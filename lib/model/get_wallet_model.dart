class GetWalletModel {
  int? statusCode;
  String? statusMessage;
  String? message;
  WalletData? data;

  GetWalletModel(
      {this.statusCode, this.statusMessage, this.message, this.data});

  GetWalletModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    statusMessage = json['status_message'];
    message = json['message'];
    if (statusCode == 200)
      data = json['data'] != null ? new WalletData.fromJson(json['data']) : null;
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

class WalletData {
  String? currencySymbol;
  String? balance;
  List<WalletTransactions>? walletTransactions;

  WalletData({this.currencySymbol, this.balance, this.walletTransactions});

  WalletData.fromJson(Map<String, dynamic> json) {
    currencySymbol = json['currency_symbol'];
    balance = json['balance'];
    if (json['wallet_transactions'] != null) {
      walletTransactions = <WalletTransactions>[];
      json['wallet_transactions'].forEach((v) {
        walletTransactions!.add(new WalletTransactions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currency_symbol'] = this.currencySymbol;
    data['balance'] = this.balance;
    if (this.walletTransactions != null) {
      data['wallet_transactions'] =
          this.walletTransactions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WalletTransactions {
  String? month;
  List<MonthData>? monthData;

  WalletTransactions({this.month, this.monthData});

  WalletTransactions.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    if (json['monthData'] != null) {
      monthData = <MonthData>[];
      json['monthData'].forEach((v) {
        monthData!.add(new MonthData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    if (this.monthData != null) {
      data['monthData'] = this.monthData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MonthData {
  int? id;
  int? walletId;
  int? entityType;
  int? entityId;
  int? amount;
  int? transactionType;
  int? balanceType;
  String? message;
  int? referenceType;
  int? referenceId;
  String? createdAt;
  int? paymentMethodId;
  int? transactionStatus;
  int? paymentStatus;
  String? paymentTransactionId;
  String? paymentRequest;
  String? paymentResponse;

  MonthData(
      {this.id,
      this.walletId,
      this.entityType,
      this.entityId,
      this.amount,
      this.transactionType,
      this.balanceType,
      this.message,
      this.referenceType,
      this.referenceId,
      this.createdAt,
      this.paymentMethodId,
      this.transactionStatus,
      this.paymentStatus,
      this.paymentTransactionId,
      this.paymentRequest,
      this.paymentResponse});

  MonthData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    walletId = json['wallet_id'];
    entityType = json['entity_type'];
    entityId = json['entity_id'];
    amount = json['amount'];
    transactionType = json['transaction_type'];
    balanceType = json['balance_type'];
    message = json['message'];
    referenceType = json['reference_type'];
    referenceId = json['reference_id'];
    createdAt = json['created_at'];
    paymentMethodId = json['payment_method_id'];
    transactionStatus = json['transaction_status'];
    paymentStatus = json['payment_status'];
    paymentTransactionId = json['payment_transaction_id'];
    paymentRequest = json['payment_request'];
    paymentResponse = json['payment_response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['wallet_id'] = this.walletId;
    data['entity_type'] = this.entityType;
    data['entity_id'] = this.entityId;
    data['amount'] = this.amount;
    data['transaction_type'] = this.transactionType;
    data['balance_type'] = this.balanceType;
    data['message'] = this.message;
    data['reference_type'] = this.referenceType;
    data['reference_id'] = this.referenceId;
    data['created_at'] = this.createdAt;
    data['payment_method_id'] = this.paymentMethodId;
    data['transaction_status'] = this.transactionStatus;
    data['payment_status'] = this.paymentStatus;
    data['payment_transaction_id'] = this.paymentTransactionId;
    data['payment_request'] = this.paymentRequest;
    data['payment_response'] = this.paymentResponse;
    return data;
  }
}
