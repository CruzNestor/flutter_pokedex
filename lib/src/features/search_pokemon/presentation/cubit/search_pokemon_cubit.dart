import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/searched_pokemon.dart';
import '../../domain/usecases/search_pokemon.dart';

part 'search_pokemon_state.dart';


class SearchPokemonCubit extends Cubit<SearchPokemonState> {
  final SearchPokemon searchPokemonUseCase;

  SearchPokemonCubit({
    required this.searchPokemonUseCase
  }) : super(SearchPokemonInitial());

  Future<void> searchPokemon(String text) async {
    emit(LoadingSearchPokemon());
    final result = await searchPokemonUseCase.call(text);
    result.fold(
      (failure) => emit(SearchPokemonError(message: failure.message)), 
      (data) => emit(SearchPokemonData(searchedPokemon: data))
    );
  }
}
