import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/searched_pokemon.dart';


abstract class SearchPokemonRepository {
  Future<Either<Failure, SearchedPokemon>> searchPokemon({required String text});
}