import '../../domain/entities/pokemon_page.dart';


class PokemonPageModel extends PokemonPage {
  
  const PokemonPageModel({
    required int count,
    required String? next,
    required String? previous,
    required List<dynamic> results
  }) : super(count: count, next: next, previous: previous, results: results);

  factory PokemonPageModel.fromJSON(dynamic json){
    return PokemonPageModel(
      count: json['count'], 
      next: json['next'],
      previous: json['previous'],
      results: json['results'],
    );
  }
}