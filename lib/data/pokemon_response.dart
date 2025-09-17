// hasil export dari quicktype

import 'dart:convert';

List<PokemonResponse> pokemonResponseFromJson(String str) =>
    List<PokemonResponse>.from(
      json.decode(str).map((x) => PokemonResponse.fromJson(x)),
    );

String pokemonResponseToJson(List<PokemonResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PokemonResponse {
  String name;
  String id;
  String imageurl;
  String xdescription;
  String ydescription;
  String height;
  String category;
  String weight;
  List<Typeofpokemon> typeofpokemon;
  List<Typeofpokemon> weaknesses;
  List<String> evolutions;
  List<String> abilities;
  int hp;
  int attack;
  int defense;
  int specialAttack;
  int specialDefense;
  int speed;
  int total;
  MalePercentage? malePercentage;
  MalePercentage? femalePercentage;
  int genderless;
  Cycles cycles;
  String eggGroups;
  String evolvedfrom;
  String reason;
  String baseExp;

  PokemonResponse({
    required this.name,
    required this.id,
    required this.imageurl,
    required this.xdescription,
    required this.ydescription,
    required this.height,
    required this.category,
    required this.weight,
    required this.typeofpokemon,
    required this.weaknesses,
    required this.evolutions,
    required this.abilities,
    required this.hp,
    required this.attack,
    required this.defense,
    required this.specialAttack,
    required this.specialDefense,
    required this.speed,
    required this.total,
    this.malePercentage,
    this.femalePercentage,
    required this.genderless,
    required this.cycles,
    required this.eggGroups,
    required this.evolvedfrom,
    required this.reason,
    required this.baseExp,
  });

  factory PokemonResponse.fromJson(Map<String, dynamic> json) {
    return PokemonResponse(
      name: json["name"] ?? '',
      id: json["id"] ?? '',
      imageurl: json["imageurl"] ?? '',
      xdescription: json["xdescription"] ?? '',
      ydescription: json["ydescription"] ?? '',
      height: json["height"] ?? '',
      category: json["category"] ?? '',
      weight: json["weight"] ?? '',
      typeofpokemon:
          (json["typeofpokemon"] as List?)
              ?.map((x) => typeofpokemonValues.map[x] ?? Typeofpokemon.NONE)
              .toList() ??
          [],
      weaknesses:
          (json["weaknesses"] as List?)
              ?.map((x) => typeofpokemonValues.map[x] ?? Typeofpokemon.NONE)
              .toList() ??
          [],
      evolutions:
          (json["evolutions"] as List?)?.map((x) => x.toString()).toList() ??
          [],
      abilities:
          (json["abilities"] as List?)?.map((x) => x.toString()).toList() ?? [],
      hp: json["hp"] ?? 0,
      attack: json["attack"] ?? 0,
      defense: json["defense"] ?? 0,
      specialAttack: json["special_attack"] ?? 0,
      specialDefense: json["special_defense"] ?? 0,
      speed: json["speed"] ?? 0,
      total: json["total"] ?? 0,
      malePercentage: malePercentageValues.map[json["male_percentage"]],
      femalePercentage: malePercentageValues.map[json["female_percentage"]],
      genderless: json["genderless"] ?? 0,
      cycles: cyclesValues.map[json["cycles"]] ?? Cycles.EMPTY,
      eggGroups: json["egg_groups"] ?? '',
      evolvedfrom: json["evolvedfrom"] ?? '',
      reason: json["reason"] ?? '',
      baseExp: json["base_exp"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
    "imageurl": imageurl,
    "xdescription": xdescription,
    "ydescription": ydescription,
    "height": height,
    "category": category,
    "weight": weight,
    "typeofpokemon": List<dynamic>.from(
      typeofpokemon.map((x) => typeofpokemonValues.reverse[x]),
    ),
    "weaknesses": List<dynamic>.from(
      weaknesses.map((x) => typeofpokemonValues.reverse[x]),
    ),
    "evolutions": List<dynamic>.from(evolutions.map((x) => x)),
    "abilities": List<dynamic>.from(abilities.map((x) => x)),
    "hp": hp,
    "attack": attack,
    "defense": defense,
    "special_attack": specialAttack,
    "special_defense": specialDefense,
    "speed": speed,
    "total": total,
    "male_percentage": malePercentageValues.reverse[malePercentage],
    "female_percentage": malePercentageValues.reverse[femalePercentage],
    "genderless": genderless,
    "cycles": cyclesValues.reverse[cycles],
    "egg_groups": eggGroups,
    "evolvedfrom": evolvedfrom,
    "reason": reason,
    "base_exp": baseExp,
  };
}

enum Cycles {
  EMPTY,
  THE_10,
  THE_120,
  THE_15,
  THE_19,
  THE_20,
  THE_25,
  THE_30,
  THE_35,
  THE_40,
  THE_5,
  THE_80,
}

final cyclesValues = EnumValues({
  "-": Cycles.EMPTY,
  "10 ": Cycles.THE_10,
  "120 ": Cycles.THE_120,
  "15 ": Cycles.THE_15,
  "19 ": Cycles.THE_19,
  "20 ": Cycles.THE_20,
  "25 ": Cycles.THE_25,
  "30 ": Cycles.THE_30,
  "35 ": Cycles.THE_35,
  "40 ": Cycles.THE_40,
  "5 ": Cycles.THE_5,
  "80 ": Cycles.THE_80,
});

enum MalePercentage { THE_0, THE_100, THE_125, THE_25, THE_50, THE_75, THE_875 }

final malePercentageValues = EnumValues({
  "0%": MalePercentage.THE_0,
  "100%": MalePercentage.THE_100,
  "12.5%": MalePercentage.THE_125,
  "25%": MalePercentage.THE_25,
  "50%": MalePercentage.THE_50,
  "75%": MalePercentage.THE_75,
  "87.5%": MalePercentage.THE_875,
});

enum Typeofpokemon {
  BUG,
  DARK,
  DRAGON,
  ELECTRIC,
  FAIRY,
  FIGHTING,
  FIRE,
  FLYING,
  GHOST,
  GRASS,
  GROUND,
  ICE,
  NONE,
  NORMAL,
  POISON,
  PSYCHIC,
  ROCK,
  STEEL,
  WATER,
}

final typeofpokemonValues = EnumValues({
  "Bug": Typeofpokemon.BUG,
  "Dark": Typeofpokemon.DARK,
  "Dragon": Typeofpokemon.DRAGON,
  "Electric": Typeofpokemon.ELECTRIC,
  "Fairy": Typeofpokemon.FAIRY,
  "Fighting": Typeofpokemon.FIGHTING,
  "Fire": Typeofpokemon.FIRE,
  "Flying": Typeofpokemon.FLYING,
  "Ghost": Typeofpokemon.GHOST,
  "Grass": Typeofpokemon.GRASS,
  "Ground": Typeofpokemon.GROUND,
  "Ice": Typeofpokemon.ICE,
  "None": Typeofpokemon.NONE,
  "Normal": Typeofpokemon.NORMAL,
  "Poison": Typeofpokemon.POISON,
  "Psychic": Typeofpokemon.PSYCHIC,
  "Rock": Typeofpokemon.ROCK,
  "Steel": Typeofpokemon.STEEL,
  "Water": Typeofpokemon.WATER,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
