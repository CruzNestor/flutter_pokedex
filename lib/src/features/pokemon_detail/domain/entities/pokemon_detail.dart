import 'package:equatable/equatable.dart';


class PokemonDetail extends Equatable {

  const PokemonDetail({
    required this.abilities,
    required this.height,
    required this.id,
    required this.name,
    required this.order,
    required this.species,
    required this.sprites,
    required this.stats,
    required this.types,
    required this.weight
  });

  final List<dynamic> abilities;
  final int height; // decimetres
  final int id;
  final String name;
  final int order;
  final Map<String, dynamic> species;
  final Map<String, dynamic> sprites;
  final List<dynamic> stats;
  final List<dynamic> types;
  final int weight; // hectograms

  @override
  List<Object?> get props => [abilities, height, id, name, order, species, sprites, stats, types, weight];
}