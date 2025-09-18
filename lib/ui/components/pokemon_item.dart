import 'package:flutter/material.dart';
import 'package:pokedex/core/resources/colors.dart';
import 'package:pokedex/core/resources/themes.dart';
import 'package:pokedex/core/utils/extension.dart';
import 'package:pokedex/ui/components/custom_image.dart';

class PokemonItem extends StatelessWidget {
  const PokemonItem({
    super.key,
    required this.name,
    required this.elements,
    required this.photoUrl,
  });

  final String name;
  final List<String> elements;
  final String photoUrl;
  // TODO: handle different configuration

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

  final String type;

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
            type,
            style: TextStyle(
              color:
                  type == "Fighting" ||
                      type == "Dark" ||
                      type == "Dragon" ||
                      type == "Ghost"
                  ? Colors.white
                  : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

Color getTypeColor(BuildContext context, String type) {
  final colors = colorScheme(context);

  switch (type.toLowerCase()) {
    case 'bug':
      return colors.insect;
    case 'dark':
      return colors.nocturnal;
    case 'dragon':
      return colors.dragon;
    case 'electric':
      return colors.electric;
    case 'fairy':
      return colors.fairy;
    case 'fighting':
      return colors.fighter;
    case 'fire':
      return colors.fire;
    case 'flying':
      return colors.flying;
    case 'ghost':
      return colors.ghost;
    case 'grass':
      return colors.grass;
    case 'ground':
      return colors.terrestrial;
    case 'ice':
      return colors.ice;
    case 'normal':
      return colors.normal;
    case 'poison':
      return colors.poisonous;
    case 'psychic':
      return colors.psychic;
    case 'rock':
      return colors.stone;
    case 'steel':
      return colors.metal;
    case 'water':
      return colors.water;
    default:
      return colors.allType;
  }
}
