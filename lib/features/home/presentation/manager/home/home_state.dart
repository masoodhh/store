part of 'home_bloc.dart';

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


  factory HomeState.init() {
    return HomeState(
        categoryState: CategoryState(categories: [], status: Status.INITIAL),
        productState: ProductState(products: [], status: Status.INITIAL));
  }
}

class ProductState {
  final List<ProductEntity> products;
  Status status;

  ProductState({required this.products, required this.status});

  ProductState copyWith({
    List<ProductEntity>? newProducts,
    Status? newStatus,
  }) {
    return ProductState(
      products: newProducts ?? products,
      status: newStatus ?? status,
    );
  }

/*
  factory ProductState.fromModel(
      {required Status status,
      required home_products_model.HomeProductsModel model}) {
    List<ProductEntity> products = [];
    if (model.products != null) {
      model.products!
          .forEach((product) => products.add(Product.fromModel(product)));
    }
    return ProductState(products: products, status: status);
  }
*/
}

class CategoryState {
  final List<CategoryEntity> categories;
  Status status;

  CategoryState({required this.categories, required this.status});

  CategoryState copyWith({
    List<CategoryEntity>? newCategories,
    Status? newStatus,
  }) {
    return CategoryState(
      categories: newCategories ?? categories,
      status: newStatus ?? status,
    );
  }

//todo: بین دو متد زیر هر کدام بهتر بود نگه دار
// این متد استیت کنکونی را تغییر میدهد
  OnChanged(int categoryId, Status status) {
    for (var category in categories) {
      category.id == categoryId ? category.isChecked = true : category.isChecked = false;
    }
    return CategoryState(status: status, categories: categories);
  }

/*//این متد یک کانستراکتور است
  CategoryState changeSelect(int categoryId) {
    //ToDo: باید تست شه که درست کار میکنه یا نه و اگر نشد باید یک متغییر جدید ساخته بشه
    List<CategoryEntity> newCategories = [];
    categories.forEach((category) {
      if (category.id == categoryId) {
        newCategories.add(CategoryEntity(
            id: category.id, title: category.title, isChecked: true));
      } else {
        newCategories.add(CategoryEntity(
            id: category.id, title: category.title, isChecked: false));
      }
    });
    return CategoryState(categories: newCategories, status: status);
  }*/
// TODO:هنوز کتگوری مدل را نساختم
}
/*

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
*/
