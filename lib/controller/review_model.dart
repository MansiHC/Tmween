class ReviewModel {
  const ReviewModel(
      {required this.rating,
        required this.name,
        required this.date,
        required this.desc,
      });

  final String rating;
  final String name;
  final String date;
  final String desc;

  static fromJson(responseJson) {}
}

