// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthStoreAdapter extends TypeAdapter<AuthStore> {
  @override
  final int typeId = 3;

  @override
  AuthStore read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AuthStore(
      userId: fields[0] as String,
      accessToken: fields[1] as String,
      refreshToken: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AuthStore obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.accessToken)
      ..writeByte(2)
      ..write(obj.refreshToken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthStoreAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
