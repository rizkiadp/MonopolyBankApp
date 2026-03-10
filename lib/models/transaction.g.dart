// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionLogAdapter extends TypeAdapter<TransactionLog> {
  @override
  final int typeId = 2;

  @override
  TransactionLog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionLog(
      id: fields[0] as String,
      fromPlayerName: fields[1] as String,
      toPlayerName: fields[2] as String,
      amount: fields[3] as int,
      reason: fields[4] as String,
      timestamp: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, TransactionLog obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.fromPlayerName)
      ..writeByte(2)
      ..write(obj.toPlayerName)
      ..writeByte(3)
      ..write(obj.amount)
      ..writeByte(4)
      ..write(obj.reason)
      ..writeByte(5)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionLogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
