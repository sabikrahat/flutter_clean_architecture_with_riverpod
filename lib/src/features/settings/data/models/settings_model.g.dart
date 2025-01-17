// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppSettingsAdapter extends TypeAdapter<AppSettings> {
  @override
  final int typeId = 2;

  @override
  AppSettings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppSettings()
      ..firstRun = fields[0] as bool
      ..performanceOverlayEnable = fields[1] as bool
      ..dateFormat = fields[2] as String
      ..timeFormat = fields[3] as String
      ..firstRunDateTime = fields[4] as DateTime
      ..fontFamily = fields[5] as String
      ..theme = fields[6] as ThemeProfile
      ..locale = fields[7] as LocaleProfile
      ..isProduction = fields[8] as bool;
  }

  @override
  void write(BinaryWriter writer, AppSettings obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.firstRun)
      ..writeByte(1)
      ..write(obj.performanceOverlayEnable)
      ..writeByte(2)
      ..write(obj.dateFormat)
      ..writeByte(3)
      ..write(obj.timeFormat)
      ..writeByte(4)
      ..write(obj.firstRunDateTime)
      ..writeByte(5)
      ..write(obj.fontFamily)
      ..writeByte(6)
      ..write(obj.theme)
      ..writeByte(7)
      ..write(obj.locale)
      ..writeByte(8)
      ..write(obj.isProduction);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppSettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
