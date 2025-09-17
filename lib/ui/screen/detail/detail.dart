import 'package:flutter/material.dart';
import 'package:pokedex/core/resources/colors.dart';
import 'package:pokedex/core/resources/themes.dart';
import 'package:pokedex/core/utils/extension.dart';
import 'package:pokedex/data/pokemon_response.dart';
import 'package:pokedex/ui/components/custom_image.dart';
import 'package:pokedex/ui/components/pokemon_item.dart';

class Detail extends StatefulWidget {
  const Detail({super.key, required this.data});

  final PokemonResponse data;

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                color: getTypeColor(context, widget.data.typeofpokemon.first),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(250),
                  bottomRight: Radius.circular(250),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 50,
                    left: 20,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 28,
                        color: colorScheme(context).surface,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Positioned(
                    top: 50,
                    right: 20,
                    child: IconButton(
                      icon: Icon(
                        Icons.favorite_border,
                        size: 28,
                        color: colorScheme(context).surface,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  const Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: CustomImage(
                        url:
                            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
                        width: 250,
                        height: 250,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    widget.data.name,
                    style: textTheme(
                      context,
                    ).headlineLarge?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: widget.data.typeofpokemon
                        .map(
                          (type) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: BuildElement(type: type),
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(height: 20),
                  Text(
                    widget.data.xdescription,
                    style: textTheme(context).bodyLarge,
                  ),
                  SizedBox(height: 20),
                  Divider(),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatItem('WEIGHT', widget.data.weight),
                      ),
                      Expanded(
                        child: _buildStatItem('HEIGHT', widget.data.height),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatItem('CATEGORY', widget.data.category),
                      ),
                      Expanded(
                        child: _buildStatItem(
                          'ABILITY',
                          widget.data.abilities.first,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text('GENDER', style: textTheme(context).labelLarge),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(10),
                        child: SizedBox(
                          width: double.infinity,
                          height: 8,
                          child: LinearProgressIndicator(
                            value:
                                malePercentageValuestoDouble[malePercentageValues
                                    .reverse[widget.data.malePercentage]],
                            backgroundColor: colorScheme(context).psychic,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              colorScheme(context).dragon,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.male, size: 18),
                              Text(
                                malePercentageValues.reverse[widget
                                        .data
                                        .malePercentage] ??
                                    "",
                                style: textTheme(context).labelMedium,
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              const Icon(Icons.female, size: 18),
                              Text(
                                malePercentageValues.reverse[widget
                                        .data
                                        .femalePercentage] ??
                                    "",
                                style: textTheme(context).labelMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text("Weakness", style: textTheme(context).titleMedium),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    childAspectRatio: 4 / 1,
                    children: widget.data.weaknesses
                        .map(
                          (type) => SizedBox(child: BuildElement(type: type)),
                        )
                        .toList(),
                  ),
                  SizedBox(height: 20),
                  Text("Evolution", style: textTheme(context).titleMedium),
                  SizedBox(height: 10),
                  // TODO: ambil data evolution dari id
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: _buildEvolutionItem("test", "1", false),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildStatItem(String label, String value) {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              label == 'WEIGHT'
                  ? Icons.monitor_weight_outlined
                  : label == 'HEIGHT'
                  ? Icons.height
                  : label == 'CATEGORY'
                  ? Icons.category_outlined
                  : Icons.flash_on,
              size: 16,
              color: Colors.grey,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: BoxBorder.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Center(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildEvolutionItem(String name, String number, bool isSelected) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: isSelected
          ? const Color(0xFF6FBF73).withOpacity(0.1)
          : Colors.grey.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFF6FBF73),
            borderRadius: BorderRadius.circular(25),
          ),
          child: const Icon(
            Icons.catching_pokemon,
            color: Colors.white,
            size: 24,
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected ? const Color(0xFF6FBF73) : Colors.black87,
              ),
            ),
            Text(
              '#$number',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        const Spacer(),
        // Row(
        //   children: [
        //     _buildSmallTypeChip(const Color(0xFF6FBF73)),
        //     const SizedBox(width: 4),
        //     _buildSmallTypeChip(const Color(0xFFA569BD)),
        //   ],
        // ),
      ],
    ),
  );
}
