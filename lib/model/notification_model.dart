class NotificationModel {
  int? statusCode;
  String? statusMessage;
  String? message;
  Data? data;

  NotificationModel(
      {this.statusCode, this.statusMessage, this.message, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
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
  List<NotificationsData>? notificationsData;

  Data({this.notificationsData});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['notifications_data'] != null) {
      notificationsData = <NotificationsData>[];
      json['notifications_data'].forEach((v) {
        notificationsData!.add(new NotificationsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notificationsData != null) {
      data['notifications_data'] =
          this.notificationsData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationsData {
  int? id;
  int? entityId;
  String? title;
  String? message;
  String? image;
  int? redirectTo;
  int? redirectToId;
  int? sentDate;
  int? status;
  int? isRead;
  String? createdAt;
  String? updatedAt;
  String? createdAtDisplay;
  String? scheduledDateDisplay;
  String? isReadLable;
  String? redirectLable;

  NotificationsData(
      {this.id,
      this.entityId,
      this.title,
      this.message,
      this.image,
      this.redirectTo,
      this.redirectToId,
      this.sentDate,
      this.status,
      this.isRead,
      this.createdAt,
      this.updatedAt,
      this.createdAtDisplay,
      this.scheduledDateDisplay,
      this.isReadLable,
      this.redirectLable});

  NotificationsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    entityId = json['entity_id'];
    title = json['title'];
    message = json['message'];
    image = json['image'];
    redirectTo = json['redirect_to'];
    redirectToId = json['redirect_to_id'];
    sentDate = json['sent_date'];
    status = json['status'];
    isRead = json['is_read'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdAtDisplay = json['created_at_display'];
    scheduledDateDisplay = json['scheduled_date_display'];
    isReadLable = json['is_read_lable'];
    redirectLable = json['redirect_lable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['entity_id'] = this.entityId;
    data['title'] = this.title;
    data['message'] = this.message;
    data['image'] = this.image;
    data['redirect_to'] = this.redirectTo;
    data['redirect_to_id'] = this.redirectToId;
    data['sent_date'] = this.sentDate;
    data['status'] = this.status;
    data['is_read'] = this.isRead;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_at_display'] = this.createdAtDisplay;
    data['scheduled_date_display'] = this.scheduledDateDisplay;
    data['is_read_lable'] = this.isReadLable;
    data['redirect_lable'] = this.redirectLable;
    return data;
  }
}
