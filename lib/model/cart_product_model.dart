class CartProductModel {
  const CartProductModel(
      {required this.title,
      required this.rating,
      required this.price,
      required this.isFulFilled,
      required this.specifications,
      required this.inStock,
      required this.isFree,
      required this.image,
       this.stockCount,
      required this.count,
});

  final String title;
  final String rating;
  final String price;
  final String image;
  final String count;
  final String? stockCount;
  final bool isFulFilled;
  final bool inStock;
  final bool isFree;
  final List<Map> specifications;

  static fromJson(responseJson) {
    return null;
  }
}
