// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipeAdapter extends TypeAdapter<Recipe> {
  @override
  final typeId = 1;

  @override
  Recipe read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Recipe(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String?,
      ingredients: fields[3] == null
          ? const []
          : (fields[3] as List).cast<Ingredient>(),
      instructions: fields[4] == null
          ? const []
          : (fields[4] as List).cast<String>(),
      category: fields[5] as String?,
      prepTime: (fields[6] as num?)?.toInt(),
      cookTime: (fields[7] as num?)?.toInt(),
      servings: (fields[8] as num?)?.toInt(),
      calories: (fields[9] as num?)?.toInt(),
      image: fields[10] as String?,
      createdAt: fields[11] as DateTime?,
      updatedAt: fields[12] as DateTime?,
      isFavorite: fields[13] == null ? false : fields[13] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Recipe obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.ingredients)
      ..writeByte(4)
      ..write(obj.instructions)
      ..writeByte(5)
      ..write(obj.category)
      ..writeByte(6)
      ..write(obj.prepTime)
      ..writeByte(7)
      ..write(obj.cookTime)
      ..writeByte(8)
      ..write(obj.servings)
      ..writeByte(9)
      ..write(obj.calories)
      ..writeByte(10)
      ..write(obj.image)
      ..writeByte(11)
      ..write(obj.createdAt)
      ..writeByte(12)
      ..write(obj.updatedAt)
      ..writeByte(13)
      ..write(obj.isFavorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
