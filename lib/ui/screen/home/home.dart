import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/core/resources/themes.dart';
import 'package:pokedex/core/utils/extension.dart';
import 'package:pokedex/data/db_helper.dart';
import 'package:pokedex/ui/components/custom_search_bar.dart';
import 'package:pokedex/ui/components/custom_shimmer.dart';
import 'package:pokedex/ui/components/pokemon_item.dart';
import 'package:pokedex/ui/screen/detail/detail.dart';
import 'package:pokedex/ui/screen/home/bloc/pokemon_bloc.dart';
import 'package:pokedex/ui/screen/home/bloc/pokemon_event.dart';
import 'package:pokedex/ui/screen/home/bloc/pokemon_state.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    context.read<PokemonBloc>().add(FetchPokemonEvent());
    _checkData();
  }

  Future<void> _checkData() async {
    final db = PokemonDatabase.instance;
    final isDataAvailable = await db.hasData();
    if (!isDataAvailable) {
      context.read<PokemonBloc>().add(PutDataToDbEvent());
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: CustomSearchBar(controller: _searchController),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[850],
                  padding: EdgeInsets.symmetric(vertical: 9),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "All Type",
                      style: textTheme(context).titleMedium?.copyWith(
                        color: colorScheme(context).surface,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: colorScheme(context).surface,
                      size: 24,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<PokemonBloc, PokemonState>(
                builder: (context, state) {
                  if (state is PokemonInitialState ||
                      state is PokemonLoadingState) {
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
                  } else if (state is PokemonErrorState) {
                    debugPrint(state.error);
                    return Center(child: Text("Error Ketika Mendapatkan Data"));
                  } else if (state is PokemonSuccessState) {
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
                  return Center(
                    child: Text("Kesalahan Ketika Mendapatkan Data"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ).dismissKeyboardOnTap(context);
  }
}
