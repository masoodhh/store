
import 'package:store/features/home/data/models/product_model.dart';

import 'category_model.dart';

/// category : {"category_id":"Development","category_title":"Development"}
/// products : [{"image":"lib/assets/images/fruit/apple.png","title":"سیب","description":"کیک ساده با میزان ترش بالا","price":1000},{"image":"lib/assets/images/fruit/gilas.png","title":"گیلاس","description":"کیک با میوه،به تازگی به منو اضافه شده","price":1500},{"image":"lib/assets/images/fruit/limo.png","title":"لیمو","description":"کیک با لواجه انگور و زرد آلو با میزان ترش بالا","price":1800},{"image":"lib/assets/images/fruit/orange.jpg","title":"پرتقال","description":"کیک با میوه خوری و لواجه انگور با میزان ترش بالا","price":2000},{"image":"lib/assets/images/fruit/fruits.png","title":"میوه","description":"کیک با لواجه انگور و زرد آلو با میزان ترش بالا","price":2500}]

class HomeProductsModel {
  final CategoryModel? category;
  final List<ProductModel>? products;

  HomeProductsModel({
    this.category,
    this.products,
  });

  factory HomeProductsModel.fromJson(dynamic json) {
    final category = json['home_products']['category'] != null
        ? CategoryModel.fromjson(json['home_products']['category'])
        : null;

    final List<ProductModel> products = [];
    if (json['home_products']['products'] != null) {
      json['home_products']['products'].forEach((v) {
        products.add(ProductModel.fromJson(v));
      });
    }
    return HomeProductsModel(category: category, products: products);
  }
}
