import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/constants/http_client_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/pokemon_page.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_datasource.dart';


class HomeRepositoryImpl implements HomeRepository {

  HomeRepositoryImpl({
    required this.networkInfo,
    required this.remote
  });

  final NetworkInfo networkInfo;
  final HomeRemoteDataSource remote;

  @override
  Future<Either<Failure, PokemonPage>> getPokemonPage({required int page}) async {
    int offset = (page - 1) * HTTPClientConstants.limit;
    if(await networkInfo.isConnected){
      try {
        final data = await remote.getPokemonPage(offset: offset, limit: HTTPClientConstants.limit);
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