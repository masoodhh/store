part of 'home_bloc.dart';

abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<Product> products;
  final List<Category> categories;

  HomeLoadedState({required this.products, required this.categories});
}

class Category {
  final int id;
  final String name;
  final bool isChecked;

  Category({required this.id, required this.name, this.isChecked = false});
}

class Product {
  final String image;
  final String title;
  final String description;
  final int price;

  Product(
      {required this.image,
      required this.title,
      required this.description,
      required this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      image: json['image'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
    );
  }
}
