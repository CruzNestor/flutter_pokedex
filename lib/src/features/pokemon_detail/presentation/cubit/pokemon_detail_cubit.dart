import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/pokemon_detail.dart';
import '../../domain/usecases/get_pokemon_detail.dart';

part 'pokemon_detail_state.dart';


class PokemonDetailCubit extends Cubit<PokemonDetailState> {

  final GetPokemonDetail getPokemonDetailUseCase;

  PokemonDetailCubit({
    required this.getPokemonDetailUseCase
  }) : super(PokemonDetailInitial());

  Future<void> getPokemonData(int id) async {
    emit(LoadingPokemonDetail());
    final result = await getPokemonDetailUseCase.call(id);
    result.fold(
      (failure) => emit(PokemonDetailError(message: failure.message)), 
      (data) => emit(PokemonDetailData(pokemonDetail: data))
    );
  }
}
