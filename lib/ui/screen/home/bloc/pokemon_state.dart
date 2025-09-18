import 'package:equatable/equatable.dart';
import 'package:pokedex/data/local/pokemon_adapter.dart';

abstract class PokemonState extends Equatable {
  const PokemonState();

  @override
  List<Object?> get props => [];
}

class PokemonInitialState extends PokemonState {}

class PokemonLoadingState extends PokemonState {}

class NoPokemonState extends PokemonState {}

class PokemonErrorState extends PokemonState {
  final String error;
  const PokemonErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class PokemonSuccessState extends PokemonState {
  final List<PokemonModel> data;
  const PokemonSuccessState(this.data);

  @override
  List<Object?> get props => [data];
}
