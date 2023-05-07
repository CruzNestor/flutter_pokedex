import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/searched_pokemon.dart';
import '../repositories/search_pokemon_repository.dart';


class SearchPokemon implements UseCase<SearchedPokemon, String> {
  SearchPokemon({required this.repository});
  final SearchPokemonRepository repository;

  @override
  Future<Either<Failure, SearchedPokemon>> call(String text) async {
    return await repository.searchPokemon(text: text);
  }
}