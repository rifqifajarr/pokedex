import 'package:flutter/material.dart';
import 'package:pokedex/core/resources/themes.dart';
import 'package:pokedex/ui/components/custom_image.dart';
import 'package:pokedex/ui/components/type_item.dart';

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
                      .map((type) => TypeItem(type: type))
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
