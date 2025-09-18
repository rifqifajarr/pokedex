import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  Widget dismissKeyboardOnTap(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: this,
    );
  }
}

final Map<String, String> typeAssetMap = {
  'bug': 'assets/type/bug.png',
  'dark': 'assets/type/nocturnal.png',
  'dragon': 'assets/type/dragon.png',
  'electric': 'assets/type/electric.png',
  'fairy': 'assets/type/fairy.png',
  'fighting': 'assets/type/fighter.png',
  'fire': 'assets/type/fire.png',
  'flying': 'assets/type/flying.png',
  'ghost': 'assets/type/ghost.png',
  'grass': 'assets/type/grass.png',
  'ground': 'assets/type/terrestrial.png',
  'ice': 'assets/type/ice.png',
  'normal': 'assets/type/normal.png',
  'poison': 'assets/type/poison.png',
  'psychic': 'assets/type/psychic.png',
  'rock': 'assets/type/stone.png',
  'steel': 'assets/type/metal.png',
  'water': 'assets/type/water.png',
  'none': 'assets/type/normal.png',
};

String getTypeIconAsset(String type) {
  return typeAssetMap[type.toLowerCase()] ?? 'assets/type/normal.png';
}

String getTypeSmallIconAsset(String type) {
  final path =
      typeAssetMap[type.toLowerCase()] ?? 'assets/type/normal_small.png';
  return path.replaceFirst('.png', '_small.png');
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

final List<String> pokemonTypes = [
  'Bug',
  'Dark',
  'Dragon',
  'Electric',
  'Fairy',
  'Fighting',
  'Fire',
  'Flying',
  'Ghost',
  'Grass',
  'Ground',
  'Ice',
  'Normal',
  'Poison',
  'Psychic',
  'Rock',
  'Steel',
  'Water',
];
