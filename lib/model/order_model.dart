class OrderModel {
  const OrderModel({
    required this.title,
    required this.image,
    required this.deliveryStatus,
     this.rating,
     this.ratingStatus,
    required this.isRating,
  });

  final String title;
  final String image;
  final String deliveryStatus;
  final double? rating;
  final String? ratingStatus;
  final bool isRating;

  static fromJson(responseJson) {
    return null;
  }
}
