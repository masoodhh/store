part of 'checkout_bloc.dart';

class CheckoutState {
  final List<AddressEntity> addresses;

  final List<PaymentCardEntity> paymentCards;

  final Status addressStatus;
  final Status paymentStatus;

  CheckoutState(
      {required this.addresses,
      required this.paymentCards,
      required this.addressStatus,
      required this.paymentStatus});

  factory CheckoutState.init() {
    return CheckoutState(
        addressStatus: Status.INITIAL, paymentStatus: Status.INITIAL, addresses: [], paymentCards: []);
  }

  CheckoutState copyWith(
      {List<AddressEntity>? newAddresses,
      List<PaymentCardEntity>? newPaymentCards,
      Status? newAddressStatus,
      Status? newPaymentStatus}) {
    return CheckoutState(
      addresses: newAddresses ?? addresses,
      paymentCards: newPaymentCards ?? paymentCards,
      addressStatus: newAddressStatus ?? addressStatus,
      paymentStatus: newPaymentStatus ?? paymentStatus,
    );
  }
}
