import 'package:equatable/equatable.dart';
import 'package:pokedex/data/local/pokemon_adapter.dart';

abstract class DetailState extends Equatable {
  const DetailState();

  @override
  List<Object?> get props => [];
}

class EvolutionInitialState extends DetailState {}

class EvolutionLoadingState extends DetailState {}

class NoEvolutionState extends DetailState {}

class EvolutionErrorState extends DetailState {
  final String error;
  const EvolutionErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class EvolutionSuccessState extends DetailState {
  final List<PokemonModel> data;
  const EvolutionSuccessState(this.data);

  @override
  List<Object?> get props => [data];
}
