import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'payment_card_entity.g.dart';

const String hivePaymentCardBoxName = 'paymentBox';

@HiveType(typeId: 2)
class PaymentCardEntity extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String card_number;
  @HiveField(3)
  final int CVV;
  @HiveField(4)
  final String date;
  @HiveField(5)
  final IconData icon;
  @HiveField(6)
  bool isSelected = false;

  PaymentCardEntity(
      {required this.id,
      required this.title,
      required this.card_number,
      required this.CVV,
      required this.date,
      required this.icon,
      required this.isSelected});

  PaymentCardEntity copyWith(
      {int? newId,
      String? newTitle,
      String? newCard_number,
      int? newCVV,
      String? newDate,
      IconData? newIcon,
      bool? newIsSelected}) {
    return PaymentCardEntity(
        id: newId ?? id,
        title: newTitle ?? title,
        card_number: newCard_number ?? card_number,
        CVV: newCVV ?? CVV,
        date: newDate ?? date,
        icon: newIcon ?? icon,
        isSelected: newIsSelected ?? isSelected);
  }
}
