import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/pokemon_page.dart';
import '../repositories/home_repository.dart';


class GetPokemonPage implements UseCase<PokemonPage, int> {
  GetPokemonPage({required this.repository});
  final HomeRepository repository;

  @override
  Future<Either<Failure, PokemonPage>> call(int page) async {
    return await repository.getPokemonPage(page: page);
  }
}