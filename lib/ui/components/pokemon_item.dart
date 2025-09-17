import 'package:flutter/material.dart';
import 'package:pokedex/core/resources/colors.dart';
import 'package:pokedex/core/resources/themes.dart';
import 'package:pokedex/core/utils/extension.dart';
import 'package:pokedex/data/pokemon_response.dart';
import 'package:pokedex/ui/components/custom_image.dart';

class PokemonItem extends StatelessWidget {
  const PokemonItem({
    super.key,
    required this.name,
    required this.elements,
    required this.photoUrl,
  });

  final String name;
  final List<Typeofpokemon> elements;
  final String photoUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: textTheme(
                    context,
                  ).titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: elements
                      .map((type) => BuildElement(type: type))
                      .toList(),
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            width: 138,
            decoration: BoxDecoration(
              color: getTypeColor(context, elements.first),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Center(
                    child: CustomImage(url: photoUrl, width: 92, height: 92),
                  ),
                ),
                Positioned(
                  top: 6,
                  right: 6,
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(102),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.favorite_border_outlined,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BuildElement extends StatelessWidget {
  const BuildElement({super.key, required this.type});

  final Typeofpokemon type;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 6),
      decoration: BoxDecoration(
        color: getTypeColor(context, type),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme(context).surface,
            ),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Image.asset(getTypeIconAsset(type), width: 12, height: 12),
            ),
          ),
          SizedBox(width: 6),
          Text(
            typeofpokemonValues.reverse[type] ?? "Unknown",
            style: TextStyle(
              color: type == Typeofpokemon.FIGHTING
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

Color getTypeColor(BuildContext context, Typeofpokemon type) {
  final colors = colorScheme(context);

  switch (type) {
    case Typeofpokemon.BUG:
      return colors.insect;
    case Typeofpokemon.DARK:
      return colors.nocturnal;
    case Typeofpokemon.DRAGON:
      return colors.dragon;
    case Typeofpokemon.ELECTRIC:
      return colors.electric;
    case Typeofpokemon.FAIRY:
      return colors.fairy;
    case Typeofpokemon.FIGHTING:
      return colors.fighter;
    case Typeofpokemon.FIRE:
      return colors.fire;
    case Typeofpokemon.FLYING:
      return colors.flying;
    case Typeofpokemon.GHOST:
      return colors.ghost;
    case Typeofpokemon.GRASS:
      return colors.grass;
    case Typeofpokemon.GROUND:
      return colors.terrestrial;
    case Typeofpokemon.ICE:
      return colors.ice;
    case Typeofpokemon.NORMAL:
      return colors.normal;
    case Typeofpokemon.POISON:
      return colors.poisonous;
    case Typeofpokemon.PSYCHIC:
      return colors.psychic;
    case Typeofpokemon.ROCK:
      return colors.stone;
    case Typeofpokemon.STEEL:
      return colors.metal;
    case Typeofpokemon.WATER:
      return colors.water;
    default:
      return colors.allType;
  }
}
