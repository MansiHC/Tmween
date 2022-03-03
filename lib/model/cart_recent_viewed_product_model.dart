class CartRecentViewedProductModel {
  const CartRecentViewedProductModel(
      {required this.title,
      required this.rating,
      required this.offerPrice,
      required this.price,
      required this.isFulFilled,
      required this.isYouSave,
      required this.image,
      required this.savePrice,
      required this.saveOffer});

  final String title;
  final String rating;
  final String offerPrice;
  final String price;
  final String image;
  final String savePrice;
  final String saveOffer;
  final bool isFulFilled;
  final bool isYouSave;

  static fromJson(responseJson) {
    return null;
  }
}
