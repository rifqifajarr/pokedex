import 'package:hive/hive.dart';

part 'pokemon_adapter.g.dart';

@HiveType(typeId: 0)
class PokemonModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String id;

  @HiveField(2)
  String imageurl;

  @HiveField(3)
  String xdescription;

  @HiveField(4)
  String ydescription;

  @HiveField(5)
  String height;

  @HiveField(6)
  String category;

  @HiveField(7)
  String weight;

  @HiveField(8)
  List<String> typeofpokemon;

  @HiveField(9)
  List<String> weaknesses;

  @HiveField(10)
  List<String> evolutions;

  @HiveField(11)
  List<String> abilities;

  @HiveField(12)
  int hp;

  @HiveField(13)
  int attack;

  @HiveField(14)
  int defense;

  @HiveField(15)
  int specialAttack;

  @HiveField(16)
  int specialDefense;

  @HiveField(17)
  int speed;

  @HiveField(18)
  int total;

  @HiveField(19)
  String malePercentage;

  @HiveField(20)
  String femalePercentage;

  @HiveField(21)
  int genderless;

  @HiveField(22)
  String cycles;

  @HiveField(23)
  String eggGroups;

  @HiveField(24)
  String evolvedfrom;

  @HiveField(25)
  String reason;

  @HiveField(26)
  String baseExp;

  PokemonModel({
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
    required this.malePercentage,
    required this.femalePercentage,
    required this.genderless,
    required this.cycles,
    required this.eggGroups,
    required this.evolvedfrom,
    required this.reason,
    required this.baseExp,
  });
}
