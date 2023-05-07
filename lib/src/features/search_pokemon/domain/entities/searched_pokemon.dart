import 'package:equatable/equatable.dart';


class SearchedPokemon extends Equatable {
  const SearchedPokemon({
    required this.id,
    required this.name
  });
  final int id;
  final String name;
  
  @override
  List<Object?> get props => [id, name];
}