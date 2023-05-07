import 'package:dio/dio.dart';

import '../../../../core/constants/http_client_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/searched_pokemon_model.dart';


abstract class SearchPokemonRemoteDataSource{
  Future<SearchedPokemonModel> searchPokemon({required String text});
}

class SearchPokemonRemoteDataSourceImpl implements SearchPokemonRemoteDataSource{
  SearchPokemonRemoteDataSourceImpl({required this.dioClient}){
    dioClient
      ..options.baseUrl = HTTPClientConstants.BASE_URL
      ..options.receiveDataWhenStatusError = true
      ..options.connectTimeout = HTTPClientConstants.CONNECT_TIMEOUT
      ..options.receiveTimeout = HTTPClientConstants.RECEIVE_TIMEOUT;
  }

  final Dio dioClient;
  
  @override
  Future<SearchedPokemonModel> searchPokemon({required String text}) async {
    Response response = await dioClient.get('pokemon/$text');
    if(response.statusCode == 200){
      return SearchedPokemonModel.fromJSON(response.data);
    } else {
      throw ServerException();
    }
  }

}