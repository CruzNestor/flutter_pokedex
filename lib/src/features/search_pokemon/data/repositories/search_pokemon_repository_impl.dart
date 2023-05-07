import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/searched_pokemon.dart';
import '../../domain/repositories/search_pokemon_repository.dart';
import '../datasources/search_pokemon_remote_datasource.dart';


class SearchPokemonRepositoryImpl implements SearchPokemonRepository {

  SearchPokemonRepositoryImpl({
    required this.networkInfo,
    required this.remote
  });

  final NetworkInfo networkInfo;
  final SearchPokemonRemoteDataSource remote;

  @override
  Future<Either<Failure, SearchedPokemon>> searchPokemon({required String text}) async {
    if(await networkInfo.isConnected){
      try {
        final data = await remote.searchPokemon(text: text);
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