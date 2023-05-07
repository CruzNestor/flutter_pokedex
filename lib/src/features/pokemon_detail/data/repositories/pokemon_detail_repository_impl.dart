import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/pokemon_detail.dart';
import '../../domain/repositories/pokemon_detail_repository.dart';
import '../datasources/pokemon_detail_remote_datasource.dart';


class PokemonDetailRepositoryImpl implements PokemonDetailRepository {

  PokemonDetailRepositoryImpl({
    required this.networkInfo,
    required this.remote
  });
  final NetworkInfo networkInfo;
  final PokemonDetailRemoteDataSource remote;

  @override
  Future<Either<Failure, PokemonDetail>> getPokemonDetail({required int pokeId}) async {
    if(await networkInfo.isConnected){
      try {
        final data = await remote.getPokemonDetail(pokeId: pokeId);
        return Right(data);
      } on DioError catch(e) {
        return Left(ServerFailure(
          DioException.fromDioError(e).toString()
        ));
      } on ServerException catch(e) {
        return Left(ServerFailure(e.toString()));
      }
    }
    return const Left(NetworkConnectionFailure(CONNECTION_FAILURE_MESSAGE));
  }
}