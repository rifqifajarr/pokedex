import 'package:flutter/material.dart';
import 'package:pokedex/core/resources/themes.dart';
import 'package:pokedex/data/local/pokemon_adapter.dart';
import 'package:pokedex/ui/components/custom_image.dart';
import 'package:pokedex/ui/components/type_item.dart';

class EvolutionItem extends StatelessWidget {
  const EvolutionItem({super.key, required this.data});

  final PokemonModel data;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            height: 76,
            decoration: BoxDecoration(
              border: BoxBorder.all(),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              children: [
                Container(
                  width: 138,
                  decoration: BoxDecoration(
                    color: getTypeColor(context, data.typeofpokemon.first),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Center(
                      child: OverflowBox(
                        maxHeight: double.infinity,
                        maxWidth: double.infinity,
                        child: CustomImage(
                          url: data.imageurl,
                          width: 92,
                          height: 92,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.name, style: textTheme(context).titleLarge),
                    SizedBox(height: 8),
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: data.typeofpokemon
                          .map(
                            (type) => TypeItem(type: type, isEvolution: true),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
