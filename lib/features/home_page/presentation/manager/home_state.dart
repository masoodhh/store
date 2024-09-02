part of 'home_bloc.dart';

enum Status {
  INITIAL,
  LOADING,
  SUCCESS,
  ERROR,
}

class HomeState {
  CategoryState categoryState;
  ProductState productState;

  HomeState({required this.categoryState, required this.productState});

  HomeState copyWith({
    CategoryState? newCategoryState,
    ProductState? newProductState,
  }) {
    return HomeState(
      categoryState: newCategoryState ?? categoryState,
      productState: newProductState ?? productState,
    );
  }
}


@immutable
abstract class CategoryState {}

@immutable
abstract class ProductState {}

class ProductInitState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductLoadedState extends ProductState {
  final List<Product> products;

  ProductLoadedState({required this.products});

  factory ProductLoadedState.fromModel(
      {required home_products_model.HomeProductsModel model}) {
    List<Product> products = [];
    if (model.products != null) {
      model.products!
          .forEach((product) => products.add(Product.fromModel(product)));
    }
    return ProductLoadedState(products: products);
  }
}

class CategoryInitState extends CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategoryLoadedState extends CategoryState {
  List<Category> categories;

  CategoryLoadedState({required this.categories});

//todo: بین دو متد زیر هر کدام بهتر بود نگه دار
// این متد استیت کنکونی را تغییر میدهد
  OnChanged(int categoryId) {
    categories.forEach((category) {
      category.id == categoryId
          ? category.isChecked = true
          : category.isChecked = false;
    });
    return CategoryLoadedState;
  }

//این متد یک کانستراکتور است
  CategoryLoadedState changeSelect(int categoryId) {
    //ToDo: باید تست شه که درست کار میکنه یا نه و اگر نشد باید یک متغییر جدید ساخته بشه
    List<Category> newCategories = [];
    categories.forEach((category) {
      if (category.id == categoryId) {
        newCategories.add(
            Category(id: category.id, title: category.title, isChecked: true));
      } else {
        newCategories.add(
            Category(id: category.id, title: category.title, isChecked: false));
      }
    });
    return CategoryLoadedState(categories: categories);
  }
// TODO:هنوز کتگوری مدل را نساختم
}

class Category {
  final int id;
  final String title;
  bool isChecked;

  Category({required this.id, required this.title, this.isChecked = false});

  factory Category.fromModel(home_products_model.Category categoryModel) {
    return Category(
        id: categoryModel.categoryId!,
        isChecked: false,
        title: categoryModel.categoryTitle!);
  }
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

  factory Product.fromModel(home_products_model.Product productModel) {
    return Product(
        image: productModel.image!,
        title: productModel.title!,
        description: productModel.description!,
        price: productModel.price!);
  }
}
