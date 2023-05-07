import 'package:dio/dio.dart';

import '../../../../core/constants/http_client_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/pokemon_page_model.dart';


abstract class HomeRemoteDataSource{
  Future<PokemonPageModel> getPokemonPage({required int offset, required int limit});
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource{
  HomeRemoteDataSourceImpl({required this.dioClient}){
    dioClient
      ..options.baseUrl = HTTPClientConstants.BASE_URL
      ..options.receiveDataWhenStatusError = true
      ..options.connectTimeout = HTTPClientConstants.CONNECT_TIMEOUT
      ..options.receiveTimeout = HTTPClientConstants.RECEIVE_TIMEOUT;
  }

  final Dio dioClient;
  
  @override
  Future<PokemonPageModel> getPokemonPage({required int offset, required int limit}) async {
    int sum = offset + HTTPClientConstants.limit;
    bool hasNext = true;
    
    if(sum > HTTPClientConstants.TOTAL_POKEMON){
      limit = HTTPClientConstants.TOTAL_POKEMON - offset;
      hasNext = false;
    }

    Response response = await dioClient.get('pokemon?offset=$offset&limit=$limit');
    
    if(response.statusCode == 200){
      return PokemonPageModel(
        count: HTTPClientConstants.TOTAL_POKEMON,
        next: hasNext ? response.data['next'] : null, 
        previous: response.data['previous'],
        results: response.data['results']
      );
    } else {
      throw ServerException();
    }
  }

}