import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/data/pokemon_repository.dart';
import 'package:pokedex/ui/screen/home/bloc/pokemon_event.dart';
import 'package:pokedex/ui/screen/home/bloc/pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonRepository _repository;

  PokemonBloc(this._repository) : super(PokemonInitialState()) {
    on<FetchPokemonEvent>((event, emit) async {
      emit(PokemonLoadingState());
      try {
        final data = await _repository.getPokemons();
        emit(PokemonSuccessState(data));
      } catch (e) {
        emit(PokemonErrorState(e.toString()));
      }
    });

    on<SearchPokemonEvent>((event, emit) async {
      emit(PokemonLoadingState());
      try {
        final data = await _repository.searchPokemons(event.name);
        if (data.isEmpty) {
          emit(NoPokemonState());
        }
        emit(PokemonSuccessState(data));
      } catch (e) {
        emit(PokemonErrorState(e.toString()));
      }
    });

    on<FilterPokemonEvent>((event, emit) async {
      emit(PokemonLoadingState());
      try {
        final data = await _repository.filterByType(event.types);
        emit(PokemonSuccessState(data));
      } catch (e) {
        emit(PokemonErrorState(e.toString()));
      }
    });
  }
}
