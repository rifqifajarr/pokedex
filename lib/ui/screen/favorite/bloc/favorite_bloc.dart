import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/data/db_helper.dart';
import 'package:pokedex/ui/screen/favorite/bloc/favorite_event.dart';
import 'package:pokedex/ui/screen/favorite/bloc/favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final PokemonDatabase db;

  FavoriteBloc(this.db) : super(FavoriteInitialState()) {
    on<FetchFavoriteEvent>((event, emit) async {
      emit(FavoriteLoadingState());
      try {
        final favorites = await db.getFavorites();
        emit(FavoriteSuccessState(favorites));
      } catch (e) {
        emit(FavoriteErrorState(e.toString()));
      }
    });
  }
}
