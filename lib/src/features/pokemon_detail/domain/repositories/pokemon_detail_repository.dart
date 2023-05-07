import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/pokemon_detail.dart';


abstract class PokemonDetailRepository {
  Future<Either<Failure, PokemonDetail>> getPokemonDetail({required int pokeId});
}