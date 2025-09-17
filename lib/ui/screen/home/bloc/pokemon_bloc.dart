import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/data/db_helper.dart';
import 'package:pokedex/data/pokemon_response.dart';
import 'package:pokedex/data/pokemon_service.dart';
import 'package:pokedex/ui/screen/home/bloc/pokemon_event.dart';
import 'package:pokedex/ui/screen/home/bloc/pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonService _service;
  final db = PokemonDatabase.instance;
  final List<PokemonResponse> _remoteData = [];

  PokemonBloc(this._service) : super(PokemonInitialState()) {
    on<FetchPokemonEvent>((event, emit) async {
      emit(PokemonLoadingState());
      try {
        final data = await _service.fetchData();
        debugPrint("masuk try bloc");
        _remoteData.addAll(data);
        emit(PokemonSuccessState(data));
      } catch (e) {
        emit(PokemonErrorState(e.toString()));
      }
    });
    on<PutDataToDbEvent>((event, emit) async {
      for (final p in _remoteData) {
        await db.insertPokemon(p);
      }
      emit(DataAddedToDb());
    });
  }
}
