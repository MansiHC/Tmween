class DealsOfTheDayModel {
  const DealsOfTheDayModel(
      {required this.title,
      required this.image,
      required this.offer,
      required this.rating,
        required this.fulfilled,
      required this.price,
      this.beforePrice});

  final String title;
  final String image;
  final String offer;
  final String rating;
  final bool fulfilled;
  final String price;
  final String? beforePrice;
}
