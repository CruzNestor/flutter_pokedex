part of 'home_cubit.dart';

abstract class HomeState extends Equatable{
  const HomeState();  

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class LoadingPokemonPage extends HomeState {}

class PokemonPageData extends HomeState {
  const PokemonPageData({
    required this.page,
    required this.pokemonPage,
  });
  final int page;
  final PokemonPage pokemonPage;
}

class PokemonPageError extends HomeState {
  const PokemonPageError({required this.message, required this.page});
  final String message;
  final int page;
}
