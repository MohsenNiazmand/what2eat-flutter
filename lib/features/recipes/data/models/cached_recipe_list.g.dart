// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cached_recipe_list.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CachedRecipeListAdapter extends TypeAdapter<CachedRecipeList> {
  @override
  final typeId = 2;

  @override
  CachedRecipeList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CachedRecipeList(
      recipes: (fields[0] as List).cast<Recipe>(),
      query: fields[1] as String,
      currentPage: (fields[3] as num).toInt(),
      totalPages: (fields[4] as num).toInt(),
      limit: (fields[5] as num).toInt(),
      total: (fields[6] as num).toInt(),
      category: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CachedRecipeList obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.recipes)
      ..writeByte(1)
      ..write(obj.query)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.currentPage)
      ..writeByte(4)
      ..write(obj.totalPages)
      ..writeByte(5)
      ..write(obj.limit)
      ..writeByte(6)
      ..write(obj.total);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CachedRecipeListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
