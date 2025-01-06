// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_card_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PaymentCardEntityAdapter extends TypeAdapter<PaymentCardEntity> {
  @override
  final int typeId = 2;

  @override
  PaymentCardEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PaymentCardEntity(
      id: fields[0] as int,
      title: fields[1] as String,
      card_number: fields[2] as String,
      CVV: fields[3] as int,
      date: fields[4] as String,
      icon: fields[5] as IconData,
      isSelected: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, PaymentCardEntity obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.card_number)
      ..writeByte(3)
      ..write(obj.CVV)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.icon)
      ..writeByte(6)
      ..write(obj.isSelected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentCardEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
