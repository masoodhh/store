import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:store/core/params/params.dart';
import 'package:store/core/resources/data_state.dart';
import 'package:store/features/order/presentation/manager/order/order_bloc.dart';

import 'package:store/logger.dart';

import '../../../../../core/manager/cart/cart_bloc.dart';
import '../../../../../main.dart';
import '../../../../home/domain/entities/cart_entity.dart';
import '../../../../order/data/models/order.model.dart';
import '../../../../order/domain/entities/order.entity.dart';
import '../../../../order/domain/use_cases/add_order.usecase.dart';
import '../../../domin/entities/address_entity.dart';
import '../../../domin/entities/payment_card_entity.dart';

part 'checkout_event.dart';

part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final AddOrderUsecase addOrderUsecase = locator();

  CheckoutBloc() : super(CheckoutState.init()) {
    // * events

    on<initializeEvent>(_onInitializeEvent);
    on<disposEvent>(_onDisposEvent);
    on<addAddressEvent>(_onAddAddressEvent);
    on<addPaymentCardEvent>(_onAddPaymentCardEvent);
    on<changeSelectedAddressEvent>(_onChangeSelectedAddressEvent);
    on<changeSelectedPaymentCardEvent>(_onChangeSelectedPaymentCardEvent);
    on<confirmCheckoutEvent>(_confirmCheckoutEvent);
  }

  void _confirmCheckoutEvent(confirmCheckoutEvent event, Emitter<CheckoutState> emit) async {
    final cartBloc = locator<CartBloc>();
    OrderModel orderModel = OrderModel(
        products: cartBloc.state.cart, id: null, title: DateTime.now().toString().split(' ')[0], orderStages: []);
    final result = await addOrderUsecase.call(orderModel);
    if (result is DataSuccess) {
      logger.i("Order added successfully");
      emit(CheckoutState.init());
    }
    // TODO:
    /*CartBloc cartBloc = locator();
    final List<ProductEntity> products = cartBloc.state.cart;
    final AddressEntity addressEntity = state.addresses.firstWhere(
      (element) => element.isSelected,
    );
    final PaymentCardEntity paymentCardEntity = state.paymentCards.firstWhere(
      (element) => element.isSelected,
    );
    final confirm = ConfirmCheckoutUseCase(
        OrderEntity(products: products, address: addressEntity, paymentCard: paymentCardEntity));
  */
  }

  void _onInitializeEvent(initializeEvent event, Emitter<CheckoutState> emit) async {
    emit(state.copyWith(newAddressStatus: Status.LOADING));
    var addressBox = await Hive.openBox<AddressEntity>(hiveAddressBoxName);
    List<AddressEntity> newAddresses = addressBox.values.toList();
    newAddresses.sort((a, b) {
      if (a.isSelected && !b.isSelected) return -1;
      if (!a.isSelected && b.isSelected) return 1;
      return a.id.compareTo(b.id);
    });
    var paymentBox = await Hive.openBox<PaymentCardEntity>(hivePaymentCardBoxName);
    List<PaymentCardEntity> newPaymentCards = paymentBox.values.toList();
    newPaymentCards.sort((a, b) {
      if (a.isSelected && !b.isSelected) return -1;
      if (!a.isSelected && b.isSelected) return 1;
      return a.id.compareTo(b.id);
    });
    await Hive.close();
    emit(state.copyWith(
      newAddressStatus: Status.SUCCESS,
      newAddresses: newAddresses,
      newPaymentCards: newPaymentCards,
      newPaymentStatus: Status.SUCCESS,
    ));
  }

  void _onDisposEvent(disposEvent event, Emitter<CheckoutState> emit) async {
    var box = await Hive.openBox<AddressEntity>(hiveAddressBoxName);
    List<AddressEntity> addresses = [];
    for (AddressEntity address in state.addresses) {
      addresses.add(address);
    }
    box.clear();
    for (var address in addresses) {
      await box.add(address);
    }
  }

  void _onAddAddressEvent(addAddressEvent event, Emitter<CheckoutState> emit) async {
    logger.i("_onAddAddressEvent");
    emit(state.copyWith(newAddressStatus: Status.LOADING));
    var box = await Hive.openBox<AddressEntity>(hiveAddressBoxName);
    List<AddressEntity> addresses = [];
    int newId = 1;
    addresses.add(AddressEntity(
        id: newId, title: event.title, address: event.address, icon: event.icon, isSelected: true));
    newId++;
    for (AddressEntity address in box.values) {
      addresses.add(AddressEntity(
          id: newId, title: address.title, address: address.address, icon: address.icon, isSelected: false));
      newId++;
    }
    box.clear();
    for (AddressEntity address in addresses) {
      await box.add(address);
    }
    await Hive.close();
    emit(state.copyWith(
      newAddressStatus: Status.SUCCESS,
      newAddresses: addresses,
    ));
  }

  void _onAddPaymentCardEvent(addPaymentCardEvent event, Emitter<CheckoutState> emit) async {
    logger.i("AddPaymentCard");
    emit(state.copyWith(newPaymentStatus: Status.LOADING));
    var paymentCardBox = await Hive.openBox<PaymentCardEntity>(hivePaymentCardBoxName);
    List<PaymentCardEntity> paymentCards = [];
    int newId = 1;
    paymentCards.add(PaymentCardEntity(
        id: newId,
        title: event.title,
        card_number: event.card_number,
        CVV: event.CVV,
        date: event.date,
        icon: event.icon,
        isSelected: true));
    newId++;
    for (PaymentCardEntity paymentCard in paymentCardBox.values) {
      paymentCards.add(paymentCard.copyWith(newId: newId, newIsSelected: false));
      newId++;
    }
    paymentCardBox.clear();
    for (PaymentCardEntity paymentCard in paymentCards) {
      await paymentCardBox.add(paymentCard);
    }
    await Hive.close();
    emit(state.copyWith(
      newPaymentStatus: Status.SUCCESS,
      newPaymentCards: paymentCards,
    ));
  }

  void _onChangeSelectedAddressEvent(changeSelectedAddressEvent event, Emitter<CheckoutState> emit) async {
    emit(state.copyWith(newAddressStatus: Status.LOADING));
    List<AddressEntity> addresses = [];
    for (AddressEntity address in state.addresses) {
      if (address.id == event.id) {
        addresses.add(address.copyWith(newIsSelected: true));
      } else {
        addresses.add(address.copyWith(newIsSelected: false));
      }
    }
    var box = await Hive.openBox<AddressEntity>(hiveAddressBoxName);
    box.clear();
    for (AddressEntity address in addresses) {
      await box.add(address);
    }
    await Hive.close();
    emit(state.copyWith(newAddressStatus: Status.SUCCESS, newAddresses: addresses));
  }

  void _onChangeSelectedPaymentCardEvent(
      changeSelectedPaymentCardEvent event, Emitter<CheckoutState> emit) async {
    emit(state.copyWith(newPaymentStatus: Status.LOADING));
    List<PaymentCardEntity> paymentCards = [];
    for (PaymentCardEntity paymentCard in state.paymentCards) {
      if (paymentCard.id == event.id) {
        paymentCards.add(paymentCard.copyWith(newIsSelected: true));
      } else {
        paymentCards.add(paymentCard.copyWith(newIsSelected: false));
      }
    }
    var box = await Hive.openBox<PaymentCardEntity>(hivePaymentCardBoxName);
    box.clear();
    for (PaymentCardEntity paymentCard in paymentCards) {
      await box.add(paymentCard);
    }
    await Hive.close();
    emit(state.copyWith(newPaymentStatus: Status.SUCCESS, newPaymentCards: paymentCards));
  }
}
