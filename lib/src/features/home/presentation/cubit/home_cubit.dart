import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/pokemon_page.dart';
import '../../domain/usecases/get_pokemon_page.dart';

part 'home_state.dart';


class HomeCubit extends Cubit<HomeState> {

  final GetPokemonPage getPokemonPageUseCase;
  
  HomeCubit({
    required this.getPokemonPageUseCase,
  }) : super(HomeInitial());

  Future<void> getPokemonPage(int page) async {
    emit(LoadingPokemonPage());
    final result = await getPokemonPageUseCase.call(page);
    result.fold(
      (failure) => emit(PokemonPageError(message: failure.message, page: page)), 
      (data) => emit(PokemonPageData(pokemonPage: data, page: page))
    );
  }

}
