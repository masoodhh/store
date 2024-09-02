part of 'home_bloc.dart';

abstract class HomeState {}

class HomeInitState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<Product> products;
  final List<Category> categories;

  HomeLoadedState({required this.products, required this.categories});

  HomeLoadedState copyWith({
    List<Product>? products,
    List<Category>? categories,
  }) {
    return HomeLoadedState(
      products: products ?? this.products,
      categories: categories ?? this.categories,
    );
  }
  factory HomeLoadedState.fromModel({
    required home_products_model.HomeProductsModel model,required List<Category> categories}) {
    List<Product> products = [];
    if (model.products != null) {
      model.products!.forEach((product) =>
          products.add(Product.fromModel(product)));
    }
    return HomeLoadedState(products:products,categories: categories);
  }
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

  Product({required this.image,
    required this.title,
    required this.description,
    required this.price});

  factory Product.fromModel(home_products_model.Product productModel) {
    return Product(
        image: productModel.image!,
        title: productModel.title!,
        description: productModel.description!,
        price: productModel.price!
    );
  }
}
