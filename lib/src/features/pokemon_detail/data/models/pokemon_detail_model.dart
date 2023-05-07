import '../../domain/entities/pokemon_detail.dart';


class PokemonDetailModel extends PokemonDetail{
  const PokemonDetailModel({
    required List<dynamic> abilities,
    required int height, 
    required int id,
    required String name,
    required int order,
    required Map<String, dynamic> species,
    required Map<String, dynamic> sprites,
    required List<dynamic> stats,
    required List<dynamic> types,
    required int weight
  }) : super(
    abilities: abilities,
    height: height,
    id: id,
    name: name,
    order: order,
    species: species,
    sprites: sprites,
    stats: stats,
    types: types,
    weight: weight
  );

  factory PokemonDetailModel.fromJSON(dynamic json){
    return PokemonDetailModel(
      abilities: json['abilities'], 
      height: json['height'], 
      id: json['id'], 
      name: json['name'],
      order: json['order'],
      species: json['species'],
      sprites: json['sprites'],
      stats: json['stats'],
      types: json['types'],
      weight: json['weight']
    );
  }
}