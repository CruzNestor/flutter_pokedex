import 'package:equatable/equatable.dart';

class PokemonPage extends Equatable {
  const PokemonPage({
    this.count = 0,
    this.next,
    this.previous,
    this.results = const []
  });
  final int count;
  final String? next;
  final String? previous;
  final List<dynamic> results;
  
  @override
  List<Object?> get props => [count, next, previous, results];
}