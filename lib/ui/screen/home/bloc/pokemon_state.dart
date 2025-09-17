import 'package:equatable/equatable.dart';
import 'package:pokedex/data/pokemon_response.dart';

abstract class PokemonState extends Equatable {
  const PokemonState();

  @override
  List<Object?> get props => [];
}

class PokemonInitialState extends PokemonState {}

class PokemonLoadingState extends PokemonState {}

class PokemonErrorState extends PokemonState {
  final String error;
  const PokemonErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class PokemonSuccessState extends PokemonState {
  final List<PokemonResponse> data;
  const PokemonSuccessState(this.data);

  @override
  List<Object?> get props => [data];
}

class DataAddedToDb extends PokemonState {}
