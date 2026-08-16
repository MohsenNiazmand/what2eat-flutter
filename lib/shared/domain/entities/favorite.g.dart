// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteAdapter extends TypeAdapter<Favorite> {
  @override
  final typeId = 3;

  @override
  Favorite read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Favorite(
      id: fields[0] as String,
      recipeId: fields[1] as String,
      createdAt: fields[2] as DateTime,
      recipe: fields[3] as Recipe?,
    );
  }

  @override
  void write(BinaryWriter writer, Favorite obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.recipeId)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.recipe);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
