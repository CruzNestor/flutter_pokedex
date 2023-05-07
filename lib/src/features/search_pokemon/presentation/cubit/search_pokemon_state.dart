part of 'search_pokemon_cubit.dart';

abstract class SearchPokemonState extends Equatable {
  const SearchPokemonState();  

  @override
  List<Object> get props => [];
}

class SearchPokemonInitial extends SearchPokemonState {}

class LoadingSearchPokemon extends SearchPokemonState {}

class SearchPokemonData extends SearchPokemonState {
  const SearchPokemonData({
    required this.searchedPokemon
  });
  final SearchedPokemon searchedPokemon;
}

class SearchPokemonError extends SearchPokemonState {
  const SearchPokemonError({required this.message});
  final String message;
}
