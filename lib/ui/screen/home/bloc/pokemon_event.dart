import 'package:equatable/equatable.dart';

abstract class PokemonEvent extends Equatable {
  const PokemonEvent();

  @override
  List<Object?> get props => [];
}

class FetchPokemonEvent extends PokemonEvent {}

class SearchPokemonEvent extends PokemonEvent {
  final String name;
  const SearchPokemonEvent(this.name);

  @override
  List<Object?> get props => [name];
}

class FilterPokemonEvent extends PokemonEvent {
  final List<String> types;
  const FilterPokemonEvent(this.types);

  @override
  List<Object?> get props => [types];
}
