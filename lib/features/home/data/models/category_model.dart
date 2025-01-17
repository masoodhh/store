import '../../domain/entities/category_entity.dart';

/// category_id : "Development"
/// category_title : "Development"

class CategoryModel extends CategoryEntity {
  CategoryModel({required super.id, required super.title});

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json['id'],
        title: json['title'],
      );

}
