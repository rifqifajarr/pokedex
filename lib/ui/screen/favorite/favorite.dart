import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/core/resources/themes.dart';
import 'package:pokedex/ui/components/custom_shimmer.dart';
import 'package:pokedex/ui/components/pokemon_item.dart';
import 'package:pokedex/ui/screen/detail/detail.dart';
import 'package:pokedex/ui/screen/favorite/bloc/favorite_bloc.dart';
import 'package:pokedex/ui/screen/favorite/bloc/favorite_event.dart';
import 'package:pokedex/ui/screen/favorite/bloc/favorite_state.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  void initState() {
    super.initState();
    context.read<FavoriteBloc>().add(FetchFavoriteEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Favorite",
                style: textTheme(
                  context,
                ).headlineSmall?.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            Divider(),
            SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<FavoriteBloc, FavoriteState>(
                builder: (context, state) {
                  if (state is FavoriteInitialState ||
                      state is FavoriteLoadingState) {
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ShimmeringObject(
                          height: 118,
                          radius: BorderRadius.circular(15),
                        ),
                      ),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                    );
                  } else if (state is FavoriteErrorState) {
                    debugPrint(state.error);
                    return Center(child: Text("Error Ketika Mendapatkan Data"));
                  } else if (state is FavoriteSuccessState) {
                    final data = state.data;
                    return ListView.separated(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => Detail(data: data[index]),
                                ),
                              );
                            },
                            child: PokemonItem(
                              name: data[index].name,
                              elements: data[index].typeofpokemon,
                              photoUrl: data[index].imageurl,
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 12),
                    );
                  }
                  return Center(child: Text("Tidak Ada Data"));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
