import 'package:equatable/equatable.dart';
import 'package:pokedex/data/local/pokemon_adapter.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object?> get props => [];
}

class FavoriteInitialState extends FavoriteState {}

class FavoriteLoadingState extends FavoriteState {}

class FavoriteErrorState extends FavoriteState {
  final String error;
  const FavoriteErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class FavoriteSuccessState extends FavoriteState {
  final List<PokemonModel> data;
  const FavoriteSuccessState(this.data);

  @override
  List<Object?> get props => [data];
}
