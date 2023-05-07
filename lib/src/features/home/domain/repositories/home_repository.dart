import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/pokemon_page.dart';


abstract class HomeRepository {
  Future<Either<Failure, PokemonPage>> getPokemonPage({required int page});
}