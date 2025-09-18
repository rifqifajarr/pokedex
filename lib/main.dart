import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex/core/resources/colors.dart';
import 'package:pokedex/core/resources/themes.dart';
import 'package:pokedex/data/local/pokemon_adapter.dart';
import 'package:pokedex/data/network/pokemon_service.dart';
import 'package:pokedex/data/pokemon_repository.dart';
import 'package:pokedex/ui/screen/detail/bloc/detail_bloc.dart';
import 'package:pokedex/ui/screen/favorite/bloc/favorite_bloc.dart';
import 'package:pokedex/ui/screen/favorite/favorite.dart';
import 'package:pokedex/ui/screen/home/bloc/pokemon_bloc.dart';
import 'package:pokedex/ui/screen/home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PokemonModelAdapter());
  await Hive.openBox<PokemonModel>('pokemonBox');

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  final repository = PokemonRepository(service: PokemonService());

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PokemonBloc(repository)),
        BlocProvider(create: (context) => FavoriteBloc(repository)),
        BlocProvider(create: (context) => DetailBloc(repository)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme(
          context,
        ).copyWith(textTheme: textTheme(context).apply(fontFamily: 'Poppins')),
        home: FutureBuilder(
          future: repository.fetchAndCachePokemons(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                backgroundColor: colorScheme(context).dragon,
                body: Center(
                  child: Text(
                    "Pokedéx",
                    style: textTheme(context).displayMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: colorScheme(context).surface,
                    ),
                  ),
                ),
              );
            } else {
              return MainPage();
            }
          },
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [Home(), Favorite()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: SizedBox(
        height: 72,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(2, (index) {
              final isSelected = _selectedIndex == index;
              String path;
              if (index == 0) {
                path = isSelected
                    ? "assets/images/home_active.png"
                    : "assets/images/home.png";
              } else {
                path = isSelected
                    ? "assets/images/favorite_active.png"
                    : "assets/images/favorite.png";
              }
              final label = index == 0 ? "Pokedéx" : "Favorite";
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(path, width: 24, height: 24),
                    if (isSelected)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          label,
                          style: TextStyle(
                            color: colorScheme(context).dragon,
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
