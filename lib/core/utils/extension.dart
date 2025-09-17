import 'package:flutter/material.dart';
import 'package:pokedex/data/pokemon_response.dart';

extension WidgetExtensions on Widget {
  Widget dismissKeyboardOnTap(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: this,
    );
  }
}

final Map<Typeofpokemon, String> typeAssetMap = {
  Typeofpokemon.BUG: 'assets/type/bug.png',
  Typeofpokemon.DARK: 'assets/type/ghost.png',
  Typeofpokemon.DRAGON: 'assets/type/dragon.png',
  Typeofpokemon.ELECTRIC: 'assets/type/electric.png',
  Typeofpokemon.FAIRY: 'assets/type/fairy.png',
  Typeofpokemon.FIGHTING: 'assets/type/fighter.png',
  Typeofpokemon.FIRE: 'assets/type/fire.png',
  Typeofpokemon.FLYING: 'assets/type/flying.png',
  Typeofpokemon.GHOST: 'assets/type/ghost.png',
  Typeofpokemon.GRASS: 'assets/type/grass.png',
  Typeofpokemon.GROUND: 'assets/type/terrestrial.png',
  Typeofpokemon.ICE: 'assets/type/ice.png',
  Typeofpokemon.NONE: 'assets/type/normal.png',
  Typeofpokemon.NORMAL: 'assets/type/normal.png',
  Typeofpokemon.POISON: 'assets/type/poison.png',
  Typeofpokemon.PSYCHIC: 'assets/type/psychic.png',
  Typeofpokemon.ROCK: 'assets/type/stone.png',
  Typeofpokemon.STEEL: 'assets/type/metal.png',
  Typeofpokemon.WATER: 'assets/type/water.png',
};

String getTypeIconAsset(Typeofpokemon type) {
  return typeAssetMap[type] ?? 'assets/icons/none.png';
}

final malePercentageValuestoDouble = {
  "0%": 0.0,
  "100%": 1.0,
  "12.5%": 0.125,
  "25%": 0.25,
  "50%": 0.5,
  "75%": 0.75,
  "87.5%": 0.875,
};
