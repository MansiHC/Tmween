class NotificationModel {
  const NotificationModel({
    required this.title,
    required this.desc,
    required this.date,
    required this.time,
  });

  final String title;
  final String desc;
  final String date;
  final String time;

  static fromJson(responseJson) {
    return null;
  }
}
