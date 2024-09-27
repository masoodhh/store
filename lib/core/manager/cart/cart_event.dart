part of 'cart_bloc.dart';

abstract class CartEvent {}

class addProduct extends CartEvent {
  CartEntity product;

  addProduct(this.product);
}

class removeProduct extends CartEvent {
  CartEntity product;

  removeProduct(this.product);
}
class increamentProduct extends CartEvent {
  CartEntity product;

  increamentProduct(this.product);
}class decreaseProduct extends CartEvent {
  CartEntity product;

  decreaseProduct(this.product);
}

class clearCart extends CartEvent {}

class getTotalPrice extends CartEvent {}

class changeCartCategory extends CartEvent {
  int cartCategory;

  changeCartCategory(this.cartCategory);
}
