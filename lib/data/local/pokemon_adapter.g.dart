// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PokemonModelAdapter extends TypeAdapter<PokemonModel> {
  @override
  final int typeId = 1;

  @override
  PokemonModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PokemonModel(
      name: fields[0] as String,
      id: fields[1] as String,
      imageurl: fields[2] as String,
      xdescription: fields[3] as String,
      ydescription: fields[4] as String,
      height: fields[5] as String,
      category: fields[6] as String,
      weight: fields[7] as String,
      typeofpokemon: (fields[8] as List).cast<String>(),
      weaknesses: (fields[9] as List).cast<String>(),
      evolutions: (fields[10] as List).cast<String>(),
      abilities: (fields[11] as List).cast<String>(),
      hp: fields[12] as int,
      attack: fields[13] as int,
      defense: fields[14] as int,
      specialAttack: fields[15] as int,
      specialDefense: fields[16] as int,
      speed: fields[17] as int,
      total: fields[18] as int,
      malePercentage: fields[19] as String,
      femalePercentage: fields[20] as String,
      genderless: fields[21] as int,
      cycles: fields[22] as String,
      eggGroups: fields[23] as String,
      evolvedfrom: fields[24] as String,
      reason: fields[25] as String,
      baseExp: fields[26] as String,
      isFavorite: fields[27] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, PokemonModel obj) {
    writer
      ..writeByte(28)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.imageurl)
      ..writeByte(3)
      ..write(obj.xdescription)
      ..writeByte(4)
      ..write(obj.ydescription)
      ..writeByte(5)
      ..write(obj.height)
      ..writeByte(6)
      ..write(obj.category)
      ..writeByte(7)
      ..write(obj.weight)
      ..writeByte(8)
      ..write(obj.typeofpokemon)
      ..writeByte(9)
      ..write(obj.weaknesses)
      ..writeByte(10)
      ..write(obj.evolutions)
      ..writeByte(11)
      ..write(obj.abilities)
      ..writeByte(12)
      ..write(obj.hp)
      ..writeByte(13)
      ..write(obj.attack)
      ..writeByte(14)
      ..write(obj.defense)
      ..writeByte(15)
      ..write(obj.specialAttack)
      ..writeByte(16)
      ..write(obj.specialDefense)
      ..writeByte(17)
      ..write(obj.speed)
      ..writeByte(18)
      ..write(obj.total)
      ..writeByte(19)
      ..write(obj.malePercentage)
      ..writeByte(20)
      ..write(obj.femalePercentage)
      ..writeByte(21)
      ..write(obj.genderless)
      ..writeByte(22)
      ..write(obj.cycles)
      ..writeByte(23)
      ..write(obj.eggGroups)
      ..writeByte(24)
      ..write(obj.evolvedfrom)
      ..writeByte(25)
      ..write(obj.reason)
      ..writeByte(26)
      ..write(obj.baseExp)
      ..writeByte(27)
      ..write(obj.isFavorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
