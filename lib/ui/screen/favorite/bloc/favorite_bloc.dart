import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/data/pokemon_repository.dart';
import 'package:pokedex/ui/screen/favorite/bloc/favorite_event.dart';
import 'package:pokedex/ui/screen/favorite/bloc/favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final PokemonRepository _repository;

  FavoriteBloc(this._repository) : super(FavoriteInitialState()) {
    on<FetchFavoriteEvent>((event, emit) async {
      emit(FavoriteLoadingState());
      try {
        final favorites = await _repository.getFavorites();
        emit(FavoriteSuccessState(favorites));
      } catch (e) {
        emit(FavoriteErrorState(e.toString()));
      }
    });
  }
}
