import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'address_entity.g.dart'; // فایل auto-generated
const String hiveAddressBoxName = 'addressBox';

@HiveType(typeId: 0)
class AddressEntity extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String address;
  @HiveField(3)
  final IconData icon;
  @HiveField(4)

  bool isSelected = false;

  AddressEntity({required this.id, required this.title, required this.address, required this.icon, required this.isSelected});

  AddressEntity copyWith({String? newTitle, String? newAddress, IconData? newIcon, bool? newIsSelected}) {
    return AddressEntity(
      id: id,
      title: newTitle ?? title,
      address: newAddress ?? address,
      icon: newIcon ?? icon,
      isSelected: newIsSelected ?? isSelected,
    );
  }
}
