import 'dart:convert';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'pokemon_response.dart';

class PokemonDatabase {
  static final PokemonDatabase instance = PokemonDatabase._init();
  static Database? _database;

  PokemonDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('pokemon.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE pokemon(
      id TEXT PRIMARY KEY,
      name TEXT,
      imageurl TEXT,
      xdescription TEXT,
      ydescription TEXT,
      height TEXT,
      category TEXT,
      weight TEXT,
      typeofpokemon TEXT,
      weaknesses TEXT,
      evolutions TEXT,
      abilities TEXT,
      hp INTEGER,
      attack INTEGER,
      defense INTEGER,
      specialAttack INTEGER,
      specialDefense INTEGER,
      speed INTEGER,
      total INTEGER,
      malePercentage TEXT,
      femalePercentage TEXT,
      genderless INTEGER,
      cycles TEXT,
      eggGroups TEXT,
      evolvedfrom TEXT,
      reason TEXT,
      baseExp TEXT,
      isFavorite INTEGER DEFAULT 0
    )
    ''');
  }

  Future<void> insertPokemon(PokemonResponse pokemon) async {
    final db = await instance.database;
    await db.insert('pokemon', {
      'id': pokemon.id,
      'name': pokemon.name,
      'imageurl': pokemon.imageurl,
      'xdescription': pokemon.xdescription,
      'ydescription': pokemon.ydescription,
      'height': pokemon.height,
      'category': pokemon.category,
      'weight': pokemon.weight,
      'typeofpokemon': jsonEncode(
        pokemon.typeofpokemon
            .map((x) => typeofpokemonValues.reverse[x])
            .toList(),
      ),
      'weaknesses': jsonEncode(
        pokemon.weaknesses.map((x) => typeofpokemonValues.reverse[x]).toList(),
      ),
      'evolutions': jsonEncode(pokemon.evolutions),
      'abilities': jsonEncode(pokemon.abilities),
      'hp': pokemon.hp,
      'attack': pokemon.attack,
      'defense': pokemon.defense,
      'specialAttack': pokemon.specialAttack,
      'specialDefense': pokemon.specialDefense,
      'speed': pokemon.speed,
      'total': pokemon.total,
      'malePercentage': malePercentageValues.reverse[pokemon.malePercentage],
      'femalePercentage':
          malePercentageValues.reverse[pokemon.femalePercentage],
      'genderless': pokemon.genderless,
      'cycles': cyclesValues.reverse[pokemon.cycles],
      'eggGroups': pokemon.eggGroups,
      'evolvedfrom': pokemon.evolvedfrom,
      'reason': pokemon.reason,
      'baseExp': pokemon.baseExp,
      'isFavorite': 0,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<PokemonResponse>> getAllPokemon() async {
    final db = await instance.database;
    final maps = await db.query('pokemon');

    return maps.map((map) {
      return PokemonResponse(
        id: map['id'] as String,
        name: map['name'] as String,
        imageurl: map['imageurl'] as String,
        xdescription: map['xdescription'] as String,
        ydescription: map['ydescription'] as String,
        height: map['height'] as String,
        category: map['category'] as String,
        weight: map['weight'] as String,
        typeofpokemon: (jsonDecode(map['typeofpokemon'] as String) as List)
            .map((e) => typeofpokemonValues.map[e] ?? Typeofpokemon.NONE)
            .toList(),
        weaknesses: (jsonDecode(map['weaknesses'] as String) as List)
            .map((e) => typeofpokemonValues.map[e] ?? Typeofpokemon.NONE)
            .toList(),
        evolutions: List<String>.from(jsonDecode(map['evolutions'] as String)),
        abilities: List<String>.from(jsonDecode(map['abilities'] as String)),
        hp: map['hp'] as int,
        attack: map['attack'] as int,
        defense: map['defense'] as int,
        specialAttack: map['specialAttack'] as int,
        specialDefense: map['specialDefense'] as int,
        speed: map['speed'] as int,
        total: map['total'] as int,
        malePercentage: malePercentageValues.map[map['malePercentage']],
        femalePercentage: malePercentageValues.map[map['femalePercentage']],
        genderless: map['genderless'] as int,
        cycles: cyclesValues.map[map['cycles']] ?? Cycles.EMPTY,
        eggGroups: map['eggGroups'] as String,
        evolvedfrom: map['evolvedfrom'] as String,
        reason: map['reason'] as String,
        baseExp: map['baseExp'] as String,
      );
    }).toList();
  }

  Future<List<PokemonResponse>> getFavorites() async {
    final db = await instance.database;
    final maps = await db.query(
      'pokemon',
      where: 'isFavorite = ?',
      whereArgs: [1],
    );

    return maps.map((map) {
      return PokemonResponse(
        id: map['id'] as String,
        name: map['name'] as String,
        imageurl: map['imageurl'] as String,
        xdescription: map['xdescription'] as String,
        ydescription: map['ydescription'] as String,
        height: map['height'] as String,
        category: map['category'] as String,
        weight: map['weight'] as String,
        typeofpokemon: (jsonDecode(map['typeofpokemon'] as String) as List)
            .map((e) => typeofpokemonValues.map[e] ?? Typeofpokemon.NONE)
            .toList(),
        weaknesses: (jsonDecode(map['weaknesses'] as String) as List)
            .map((e) => typeofpokemonValues.map[e] ?? Typeofpokemon.NONE)
            .toList(),
        evolutions: List<String>.from(jsonDecode(map['evolutions'] as String)),
        abilities: List<String>.from(jsonDecode(map['abilities'] as String)),
        hp: map['hp'] as int,
        attack: map['attack'] as int,
        defense: map['defense'] as int,
        specialAttack: map['specialAttack'] as int,
        specialDefense: map['specialDefense'] as int,
        speed: map['speed'] as int,
        total: map['total'] as int,
        malePercentage: malePercentageValues.map[map['malePercentage']],
        femalePercentage: malePercentageValues.map[map['femalePercentage']],
        genderless: map['genderless'] as int,
        cycles: cyclesValues.map[map['cycles']] ?? Cycles.EMPTY,
        eggGroups: map['eggGroups'] as String,
        evolvedfrom: map['evolvedfrom'] as String,
        reason: map['reason'] as String,
        baseExp: map['baseExp'] as String,
      );
    }).toList();
  }

  Future<void> toggleFavorite(String id, bool isFavorite) async {
    final db = await instance.database;
    await db.update(
      'pokemon',
      {'isFavorite': isFavorite ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<bool> hasData() async {
    final db = await instance.database;
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM pokemon');
    final count = Sqflite.firstIntValue(result) ?? 0;
    return count > 0;
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
