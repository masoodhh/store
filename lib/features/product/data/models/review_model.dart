import 'package:store/features/product/domin/entities/review_entity.dart';

class ReviewModel extends ReviewEntity {
  ReviewModel(
      {required super.id,
      required super.userId,
      required super.userName,
      super.userImage,
      required super.rating,
      required super.comment,
      required super.date});

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
        id: json['id'],
        userId: json['user']['id'],
        userName: json['user']['name'],
        userImage: json['user']['avatar'],
        rating: double.parse(json['rating']),
        comment: json['comment'],
        date: DateTime.parse(json['created_at']),
      );
}
