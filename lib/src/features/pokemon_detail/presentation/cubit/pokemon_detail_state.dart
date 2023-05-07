part of 'pokemon_detail_cubit.dart';

abstract class PokemonDetailState extends Equatable {
  const PokemonDetailState();

  @override
  List<Object?> get props => [];
}

class PokemonDetailInitial extends PokemonDetailState {}

class LoadingPokemonDetail extends PokemonDetailState {
  @override
  List<Object?> get props => [];
}

class PokemonDetailError extends PokemonDetailState {
  const PokemonDetailError({required this.message});
  final String message;
}

class PokemonDetailData extends PokemonDetailState {
  const PokemonDetailData({required this.pokemonDetail});
  final PokemonDetail pokemonDetail;
}
