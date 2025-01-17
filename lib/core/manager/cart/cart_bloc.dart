import 'package:bloc/bloc.dart';

import '../../../features/home/domain/entities/product_entity.dart';
import '../../params/params.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState.init()) {
    // * events

    on<addProduct>(_onAddProductEvent);
    on<increamentProduct>(_onIncreamentProductEvent);
    on<decreaseProduct>(_onDecreaseProductEvent);
    on<removeProduct>(_onRemoveProductEvent);
    on<clearCart>(_onClearCartEvent);
    on<changeCartCategory>(_onChangeCartCategoryEvent);
    // on<getTotalPrice>(_onClearCartEvent);
  }

  // * events

  void _onAddProductEvent(addProduct event, Emitter<CartState> emit) {
    emit(state.copyWith(newStatus: Status.LOADING));
    final product = event.product;
    if (state.cart.any((p) => p.id == product.id)) {
      emit(state.copyWith(
          newStatus: Status.ERROR, newMessage: ErrorMessage("محصول از قبل در سبد خرید موجود است.")));
    } else {
      final cart = state.cart..add(product.copyWith(count: 1));
      double totalPrice = 0;
      for (var element in cart) {
        totalPrice += element.price * element.count;
      }
      emit(state.copyWith(
          newStatus: Status.SUCCESS,
          newCart: cart,
          newTotalPrice: totalPrice,
          newMessage: SuccessMessage("محصول به سبد خرید افزوده شد.")));
    }
  }

  void _onIncreamentProductEvent(increamentProduct event, Emitter<CartState> emit) {
    emit(state.copyWith(newStatus: Status.LOADING));
    final product = event.product;
    if (state.cart.any((p) => p.id == product.id)) {
      final cart = state.cart.map((p) {
        if (p.id == product.id) {
          return p.copyWith(count: p.count + 1);
        }
        return p;
      }).toList();
      double totalPrice = 0;
      for (var element in cart) {
        totalPrice += element.price * element.count;
      }
      emit(state.copyWith(
          newStatus: Status.SUCCESS,
          newCart: cart,
          newTotalPrice: totalPrice,
          newMessage: SuccessMessage("Added to cart successfully")));
    } else {
      final cart = state.cart..add(product.copyWith(count: 1));
      double totalPrice = 0;
      for (var element in cart) {
        totalPrice += element.price * element.count;
      }
      emit(state.copyWith(
          newStatus: Status.SUCCESS,
          newCart: cart,
          newTotalPrice: totalPrice,
          newMessage: SuccessMessage("Added to cart successfully")));
    }
  }

  void _onDecreaseProductEvent(decreaseProduct event, Emitter<CartState> emit) {
    emit(state.copyWith(newStatus: Status.LOADING));
    final product = event.product;
    if (state.cart.any((p) => p.id == product.id)) {
      final cart = state.cart
          .map((p) {
            if (p.id == product.id) {
              if (p.count > 1) {
                return p.copyWith(count: p.count - 1);
              } else {
                return null;
              }
            }
            return p;
          })
          .whereType<ProductEntity>()
          .toList();
      double totalPrice = 0;
      for (var element in cart) {
        totalPrice += element.price * element.count;
      }
      emit(state.copyWith(newStatus: Status.SUCCESS, newCart: cart, newTotalPrice: totalPrice));
    } else {
      emit(state.copyWith(newStatus: Status.SUCCESS));
    }
  }

  void _onRemoveProductEvent(removeProduct event, Emitter<CartState> emit) {
    emit(state.copyWith(newStatus: Status.LOADING));
    final product = event.product;
    final cart = state.cart.where((p) => p.id != product.id).toList();
    double totalPrice = 0;
    for (var element in cart) {
      totalPrice += element.price * element.count;
    }
    emit(state.copyWith(newStatus: Status.SUCCESS, newCart: cart, newTotalPrice: totalPrice));
  }

  void _onClearCartEvent(clearCart event, Emitter<CartState> emit) {
    emit(state.copyWith(newStatus: Status.LOADING));
    emit(state.copyWith(newStatus: Status.SUCCESS, newCart: [], newTotalPrice: 0));
  }

  void _onChangeCartCategoryEvent(changeCartCategory event, Emitter<CartState> emit) {
    emit(state.copyWith(newCartCategory: event.cartCategory));
  }
}
