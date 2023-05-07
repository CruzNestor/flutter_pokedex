import 'package:dio/dio.dart';

import '../../../../core/constants/http_client_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/pokemon_detail_model.dart';


abstract class PokemonDetailRemoteDataSource{
  Future<PokemonDetailModel> getPokemonDetail({required int pokeId});
}

class PokemonDetailRemoteDataSourceImpl implements PokemonDetailRemoteDataSource {

  PokemonDetailRemoteDataSourceImpl({required this.dioClient}){
    dioClient
      ..options.baseUrl = HTTPClientConstants.BASE_URL
      ..options.receiveDataWhenStatusError = true
      ..options.connectTimeout = HTTPClientConstants.CONNECT_TIMEOUT
      ..options.receiveTimeout = HTTPClientConstants.RECEIVE_TIMEOUT;
  }

  final Dio dioClient;

  @override
  Future<PokemonDetailModel> getPokemonDetail({required int pokeId}) async {
    Response response = await dioClient.get('pokemon/$pokeId');
    if(response.statusCode == 200){
      return PokemonDetailModel(
        abilities: response.data['abilities'], 
        height: response.data['height'], 
        id: response.data['id'], 
        name: response.data['name'],
        order: response.data['order'],
        species: await getSpecie(pokeId: pokeId),
        sprites: response.data['sprites'],
        stats: response.data['stats'],
        types: response.data['types'],
        weight: response.data['weight']
      );
    } else {
      throw ServerException();
    }
  }

  Future<Map<String, dynamic>> getSpecie({required int pokeId}) async {
    try {
      Response response = await dioClient.get('pokemon-species/$pokeId');
      String genus = '';
      String flavorText = '';
      
      if(response.statusCode == 200){
        for (var element in response.data['genera']) {
          if(element['language']['name'] == 'en'){
            genus = element['genus'];
          }
        }
        for (var element in response.data['flavor_text_entries']) {
          if(element['language']['name'] == 'en'){
            flavorText = element['flavor_text'].replaceAll('\n', ' ');
          }
        }
        return {'flavor_text' : flavorText, 'genus': genus};
      } else {
        throw ServerException();
      }
    } on DioError catch(e) {
      if(e.response?.statusCode == 404){
        return {'flavor_text' : '', 'genus': ''};
      }
      throw ServerException();
    }
    
  }

}