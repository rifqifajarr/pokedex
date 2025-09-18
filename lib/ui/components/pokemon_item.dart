import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/core/resources/themes.dart';
import 'package:pokedex/data/pokemon_repository.dart';
import 'package:pokedex/ui/components/custom_image.dart';
import 'package:pokedex/ui/components/type_item.dart';
import 'package:pokedex/ui/screen/favorite/bloc/favorite_bloc.dart';
import 'package:pokedex/ui/screen/favorite/bloc/favorite_event.dart';
import 'package:pokedex/ui/screen/favorite/bloc/favorite_state.dart';

class PokemonItem extends StatelessWidget {
  const PokemonItem({
    super.key,
    required this.id,
    required this.name,
    required this.elements,
    required this.photoUrl,
  });

  final String id;
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
                const SizedBox(height: 8),
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
          const Spacer(),
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
                  child: BlocBuilder<FavoriteBloc, FavoriteState>(
                    builder: (context, state) {
                      bool isFavorite = false;
                      if (state is FavoriteSuccessState) {
                        isFavorite = state.data.any(
                          (pokemon) => pokemon.id == id,
                        );
                      }
                      return GestureDetector(
                        onTap: () {
                          context.read<PokemonRepository>().toggleFavorite(id);
                          context.read<FavoriteBloc>().add(
                            FetchFavoriteEvent(),
                          );
                        },
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(102),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1),
                          ),
                          child: Center(
                            child: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined,
                              color: isFavorite
                                  ? colorScheme(context).error
                                  : Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      );
                    },
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
