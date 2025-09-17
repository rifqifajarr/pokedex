import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/core/resources/colors.dart';
import 'package:pokedex/core/resources/themes.dart';
import 'package:pokedex/data/db_helper.dart';
import 'package:pokedex/data/pokemon_service.dart';
import 'package:pokedex/ui/screen/favorite/bloc/favorite_bloc.dart';
import 'package:pokedex/ui/screen/favorite/favorite.dart';
import 'package:pokedex/ui/screen/home/bloc/pokemon_bloc.dart';
import 'package:pokedex/ui/screen/home/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PokemonBloc(PokemonService())),
        BlocProvider(
          create: (context) => FavoriteBloc(PokemonDatabase.instance),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme(
          context,
        ).copyWith(textTheme: textTheme(context).apply(fontFamily: 'Poppins')),
        home: MainPage(),
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
