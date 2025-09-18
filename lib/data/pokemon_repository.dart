import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex/data/local/pokemon_adapter.dart';
import 'package:pokedex/data/network/pokemon_response.dart';
import 'package:pokedex/data/network/pokemon_service.dart';

class PokemonRepository {
  final PokemonService service;

  PokemonRepository({required this.service});

  Future<void> fetchAndCachePokemons() async {
    try {
      final response = await service.fetchData();
      final pokemons = response.map((p) => p.toModel()).toList();

      final box = await Hive.openBox('pokemonBox');
      await box.clear();
      await box.addAll(pokemons);
    } catch (e) {
      throw Exception("Failed to load pokemons: ${e.toString()}");
    }
  }

  Future<List<PokemonModel>> getPokemons() async {
    final box = Hive.box<PokemonModel>('pokemonBox');

    if (box.isEmpty) {
      await fetchAndCachePokemons();
      return box.values.toList();
    } else {
      return box.values.toList();
    }
  }

  Future<void> clearCache() async {
    final box = Hive.box<PokemonModel>('pokemonBox');
    await box.clear();
  }
}
