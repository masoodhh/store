class ReviewEntity {
  final int id;
  final int userId;
  final String userName;
  final String? userImage;
  final double rating;
  final String comment;
  final DateTime date;

  ReviewEntity({
    required this.id,
    required this.userId,
    required this.userName,
    this.userImage,
    required this.rating,
    required this.comment,
    required this.date,
  });
}
