part of 'cart_bloc.dart';

abstract class CartEvent {}

class addProduct extends CartEvent {
  ProductEntity product;

  addProduct(this.product);
}

class removeProduct extends CartEvent {
  ProductEntity product;

  removeProduct(this.product);
}

class increamentProduct extends CartEvent {
  ProductEntity product;

  increamentProduct(this.product);
}

class decreaseProduct extends CartEvent {
  ProductEntity product;

  decreaseProduct(this.product);
}

class clearCart extends CartEvent {}

class getTotalPrice extends CartEvent {}

class changeCartCategory extends CartEvent {
  int cartCategory;

  changeCartCategory(this.cartCategory);
}
