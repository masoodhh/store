part of 'cart_bloc.dart';

class CartState {
  Status status;
  List<CartEntity> cart = [];
  double totalPrice;
  int cart_category;
  StateMessage? message;

/*
  cart_category
  0 : all Orders
  1 : pending
  2 : completed
 */

  CartState(
      {required this.status,
      required this.cart,
      required this.totalPrice,
      required this.cart_category,
      this.message});

  CartState copyWith(
      {Status? newStatus,
      List<CartEntity>? newCart,
      double? newTotalPrice,
      int? newCartCategory,
      StateMessage? newMessage}) {
    return CartState(
      status: newStatus ?? this.status,
      cart: newCart ?? this.cart,
      totalPrice: newTotalPrice ?? this.totalPrice,
      cart_category: newCartCategory ?? this.cart_category,
      message: newMessage ?? null,
    );
  }

  factory CartState.init() {
    return CartState(status: Status.INITIAL, cart: [], totalPrice: 0, cart_category: 0, message: null);
  }
}
