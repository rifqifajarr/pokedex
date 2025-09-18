import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/data/pokemon_repository.dart';
import 'package:pokedex/ui/screen/detail/bloc/detail_event.dart';
import 'package:pokedex/ui/screen/detail/bloc/detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final PokemonRepository _repository;

  DetailBloc(this._repository) : super(EvolutionInitialState()) {
    on<FetchEvolution>((event, emit) async {
      emit(EvolutionLoadingState());
      try {
        final data = await _repository.getPokemonByIds(event.ids);
        emit(EvolutionSuccessState(data));
      } catch (e) {
        emit(EvolutionErrorState(e.toString()));
      }
    });
  }
}
