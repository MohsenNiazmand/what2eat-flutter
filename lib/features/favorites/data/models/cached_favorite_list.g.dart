// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cached_favorite_list.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CachedFavoriteListAdapter extends TypeAdapter<CachedFavoriteList> {
  @override
  final typeId = 4;

  @override
  CachedFavoriteList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CachedFavoriteList(favorites: (fields[0] as List).cast<Favorite>());
  }

  @override
  void write(BinaryWriter writer, CachedFavoriteList obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.favorites);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CachedFavoriteListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
