part of 'checkout_bloc.dart';

abstract class CheckoutEvent {}

class initializeEvent extends CheckoutEvent {}

class disposEvent extends CheckoutEvent {}

class addAddressEvent extends CheckoutEvent {
  final String title;
  final String address;
  final IconData icon;

  addAddressEvent({required this.title, required this.address, required this.icon});
}

class changeSelectedAddressEvent extends CheckoutEvent {
  final int id;

  changeSelectedAddressEvent({required this.id});
}

class removeAddressEvent extends CheckoutEvent {}

class addPaymentCardEvent extends CheckoutEvent {
  final String title;
  final String card_number;
  final int CVV;
  final String date;
  final IconData icon;
  bool isSelected = true;

  addPaymentCardEvent({
    required this.title,
    required this.card_number,
    required this.CVV,
    required this.date,
    required this.icon,
  });
}

class changeSelectedPaymentCardEvent extends CheckoutEvent {
  final int id;

  changeSelectedPaymentCardEvent({required this.id});
}

class removePaymetCardEvent extends CheckoutEvent {}
class confirmCheckoutEvent extends CheckoutEvent {}
