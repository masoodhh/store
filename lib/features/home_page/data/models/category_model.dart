import 'package:store/features/home_page/domain/entities/category_entity.dart';

/// category_id : "Development"
/// category_title : "Development"

class CategoryModel extends CategoryEntity {
  CategoryModel({required super.id, required super.title});

  factory CategoryModel.fromjson(Map<String, dynamic> json) => CategoryModel(
        id: json['category_id'],
        title: json['category_title'],
      );
}
