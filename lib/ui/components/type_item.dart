import 'package:flutter/material.dart';
import 'package:pokedex/core/resources/colors.dart';
import 'package:pokedex/core/resources/themes.dart';
import 'package:pokedex/core/utils/extension.dart';

class TypeItem extends StatelessWidget {
  const TypeItem({
    super.key,
    required this.type,
    this.isInDetail = false,
    this.isWeakness = false,
    this.isEvolution = false,
  });

  final String type;
  final bool isInDetail;
  final bool isWeakness;
  final bool isEvolution;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isInDetail ? 6 : 3,
        horizontal: isInDetail ? 14 : 6,
      ),
      decoration: BoxDecoration(
        color: getTypeColor(context, type),
        borderRadius: BorderRadius.circular(50),
      ),
      child: isEvolution
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 29),
              child: Image.asset(
                getTypeSmallIconAsset(type),
                width: 12,
                height: 12,
              ),
            )
          : Row(
              mainAxisAlignment: isWeakness
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorScheme(context).surface,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Image.asset(
                      getTypeIconAsset(type),
                      width: isInDetail ? 18 : 12,
                      height: isInDetail ? 18 : 12,
                    ),
                  ),
                ),
                SizedBox(width: 6),
                Text(
                  type,
                  style: TextStyle(
                    fontSize: isInDetail ? 14 : 11,
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
