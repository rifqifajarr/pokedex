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

      final box = await Hive.openBox<PokemonModel>('pokemonBox');
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

  Future<void> toggleFavorite(String id) async {
    final box = Hive.box<PokemonModel>('pokemonBox');
    final index = box.values.toList().indexWhere((element) => element.id == id);
    if (index != -1) {
      final pokemon = box.getAt(index);
      if (pokemon != null) {
        final update = pokemon.copyWith(isFavorite: !pokemon.isFavorite);
        await box.putAt(index, update);
      }
    }
  }

  Future<List<PokemonModel>> getFavorites() async {
    final box = Hive.box<PokemonModel>('pokemonBox');
    return box.values.where((element) => element.isFavorite).toList();
  }

  Future<List<PokemonModel>> searchPokemons(String keyword) async {
    final box = Hive.box<PokemonModel>('pokemonBox');
    final query = keyword.toLowerCase();
    return box.values
        .where((element) => element.name.toLowerCase().contains(query))
        .toList();
  }

  Future<List<PokemonModel>> filterByType(List<String> types) async {
    final box = Hive.box<PokemonModel>('pokemonBox');
    final query = types.map((e) => e.toLowerCase()).toList();

    return box.values.where((element) {
      final types = element.typeofpokemon.map((t) => t.toLowerCase()).toList();
      return query.every((element) => types.contains(element));
    }).toList();
  }

  Future<List<PokemonModel>> getPokemonByIds(List<String> ids) async {
    final box = Hive.box<PokemonModel>('pokemonBox');
    return box.values.where((element) => ids.contains(element.id)).toList();
  }

  Future<void> clearCache() async {
    final box = Hive.box<PokemonModel>('pokemonBox');
    await box.clear();
  }
}
