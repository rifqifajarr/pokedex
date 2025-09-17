import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/data/pokemon_response.dart';

class PokemonService {
  static const String _baseUrl =
      "https://gist.githubusercontent.com/hungps/0bfdd96d3ab9ee20c2e572e47c6834c7/raw/pokemons.json";

  Future<List<PokemonResponse>> fetchData() async {
    try {
      final response = await http
          .get(Uri.parse(_baseUrl))
          .timeout(Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = pokemonResponseFromJson(response.body);
        debugPrint("masuk 200");
        return data;
      } else {
        throw Exception(response.body);
      }
    } on SocketException {
      throw SocketException("No Internet!");
    } catch (e) {
      debugPrint("masuk exception");
      throw Exception("Error fetchData() $e");
    }
  }
}
