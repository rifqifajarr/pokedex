import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/core/resources/colors.dart';
import 'package:pokedex/core/resources/themes.dart';
import 'package:pokedex/core/utils/extension.dart';
import 'package:pokedex/data/local/pokemon_adapter.dart';
import 'package:pokedex/data/pokemon_repository.dart';
import 'package:pokedex/ui/components/custom_image.dart';
import 'package:pokedex/ui/components/custom_shimmer.dart';
import 'package:pokedex/ui/components/evolution_item.dart';
import 'package:pokedex/ui/components/type_item.dart';
import 'package:pokedex/ui/screen/detail/bloc/detail_bloc.dart';
import 'package:pokedex/ui/screen/detail/bloc/detail_event.dart';
import 'package:pokedex/ui/screen/detail/bloc/detail_state.dart';
import 'package:pokedex/ui/screen/favorite/bloc/favorite_bloc.dart';
import 'package:pokedex/ui/screen/favorite/bloc/favorite_event.dart';
import 'package:pokedex/ui/screen/favorite/bloc/favorite_state.dart';

class Detail extends StatefulWidget {
  const Detail({super.key, required this.data});

  final PokemonModel data;

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  void initState() {
    super.initState();
    context.read<DetailBloc>().add(FetchEvolution(widget.data.evolutions));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getTypeColor(context, widget.data.typeofpokemon.first),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: colorScheme(context).surface,
            child: Column(
              children: [
                _buildImage(
                  context,
                  widget.data.imageurl,
                  widget.data.typeofpokemon.first,
                  widget.data.id,
                ),
                _buildData(context, widget.data),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      border: BoxBorder.all(),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: BlocBuilder<DetailBloc, DetailState>(
                      builder: (context, state) {
                        if (state is EvolutionInitialState ||
                            state is EvolutionLoadingState) {
                          return ShimmeringObject(width: 136, height: 96);
                        } else if (state is EvolutionErrorState) {
                          return Center(child: Text(state.error));
                        } else if (state is EvolutionSuccessState) {
                          return ListView.separated(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: state.data.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          Detail(data: state.data[index]),
                                    ),
                                  );
                                },
                                child: EvolutionItem(data: state.data[index]),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Center(
                                child: Image.asset(
                                  'assets/images/arrow_down.png',
                                ),
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: Text("hmm evolution is still evolving.."),
                          );
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildImage(
  BuildContext context,
  String imageUrl,
  String type,
  String id,
) {
  final color = getTypeColor(context, type);

  return SizedBox(
    height: 300,
    width: double.infinity,
    child: Stack(
      children: [
        Transform.translate(
          offset: const Offset(0, -520),
          child: OverflowBox(
            maxWidth: double.infinity,
            maxHeight: double.infinity,
            alignment: Alignment.topCenter,
            child: ClipOval(
              child: Container(width: 800, height: 800, color: color),
            ),
          ),
        ),
        Positioned(
          top: 19,
          left: 32,
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 28,
              color: colorScheme(context).surface,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        Positioned(
          top: 19,
          right: 32,
          child: BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, state) {
              bool isFavorite = false;

              if (state is FavoriteSuccessState) {
                isFavorite = state.data.any((pokemon) => pokemon.id == id);
              }

              return IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
                  size: 28,
                  color: isFavorite
                      ? colorScheme(context).error
                      : colorScheme(context).surface,
                ),
                onPressed: () {
                  context.read<PokemonRepository>().toggleFavorite(id);
                  context.read<FavoriteBloc>().add(FetchFavoriteEvent());
                },
              );
            },
          ),
        ),
        Positioned(
          bottom: -10,
          left: 0,
          right: 0,
          child: CustomImage(
            url: imageUrl,
            width: 250,
            height: 250,
            fit: BoxFit.contain,
          ),
        ),
      ],
    ),
  );
}

Widget _buildData(BuildContext context, PokemonModel data) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          data.name,
          style: textTheme(
            context,
          ).headlineLarge?.copyWith(fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 20),
        Row(
          children: data.typeofpokemon
              .map(
                (type) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: TypeItem(type: type, isInDetail: true),
                ),
              )
              .toList(),
        ),
        SizedBox(height: 20),
        Text(data.xdescription, style: textTheme(context).bodyLarge),
        SizedBox(height: 20),
        Divider(),
        Row(
          children: [
            Expanded(child: _buildStatItem('WEIGHT', data.weight)),
            Expanded(child: _buildStatItem('HEIGHT', data.height)),
          ],
        ),
        Row(
          children: [
            Expanded(child: _buildStatItem('CATEGORY', data.category)),
            Expanded(child: _buildStatItem('ABILITY', data.abilities.first)),
          ],
        ),
        const SizedBox(height: 20),
        Center(
          child: Text(
            data.genderless == 0 ? 'GENDER' : 'GENDERLESS',
            style: textTheme(context).labelLarge,
          ),
        ),
        const SizedBox(height: 8),
        if (data.genderless == 0)
          Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(10),
                child: SizedBox(
                  width: double.infinity,
                  height: 8,
                  child: data.genderless == 0
                      ? LinearProgressIndicator(
                          value:
                              malePercentageValuestoDouble[data.malePercentage],
                          backgroundColor: colorScheme(context).psychic,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            colorScheme(context).dragon,
                          ),
                        )
                      : SizedBox(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.male, size: 18),
                      Text(
                        data.malePercentage,
                        style: textTheme(context).labelMedium,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.female, size: 18),
                      Text(
                        data.femalePercentage,
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
          padding: EdgeInsets.only(top: 12),
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 16,
          childAspectRatio: 4 / 1,
          children: data.weaknesses
              .map(
                (type) => SizedBox(
                  child: TypeItem(
                    type: type,
                    isInDetail: true,
                    isWeakness: true,
                  ),
                ),
              )
              .toList(),
        ),
        SizedBox(height: 20),
        Text("Evolution", style: textTheme(context).titleMedium),
        SizedBox(height: 10),
      ],
    ),
  );
}

Widget _buildStatItem(String label, String value) {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(
              label == 'WEIGHT'
                  ? "assets/images/weight.png"
                  : label == 'HEIGHT'
                  ? "assets/images/height.png"
                  : label == 'CATEGORY'
                  ? "assets/images/category.png"
                  : "assets/images/home.png",
              width: 16,
              height: 16,
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
