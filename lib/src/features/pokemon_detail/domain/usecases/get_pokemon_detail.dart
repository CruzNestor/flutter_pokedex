import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/pokemon_detail.dart';
import '../repositories/pokemon_detail_repository.dart';


class GetPokemonDetail implements UseCase<PokemonDetail, int> {
  GetPokemonDetail({required this.repository});
  final PokemonDetailRepository repository;

  @override
  Future<Either<Failure, PokemonDetail>> call(int pokeId) async {
    return await repository.getPokemonDetail(pokeId: pokeId);
  }
}