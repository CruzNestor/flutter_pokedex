import '../../domain/entities/searched_pokemon.dart';


class SearchedPokemonModel extends SearchedPokemon {
  
  const SearchedPokemonModel({
    required int id,
    required String name
  }) : super(
    id: id,
    name: name
  );

  factory SearchedPokemonModel.fromJSON(dynamic json){
    return SearchedPokemonModel(
      id: json['id'], 
      name: json['name']
    );
  }
}