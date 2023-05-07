import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../../../injection_container.dart';
import '../../../../core/constants/http_client_constants.dart';
import '../../../pokemon_detail/presentation/pages/pokemon_detail_page.dart';
import '../../domain/entities/searched_pokemon.dart';
import '../cubit/search_pokemon_cubit.dart';

part '../widgets/search_pokemon_widgets.dart';


class SearchPokemonPage extends StatelessWidget {
  const SearchPokemonPage({super.key});

  void searchPokemon(BuildContext context, String text) async {
    final provider = BlocProvider.of<SearchPokemonCubit>(context, listen: false);
    await Future.delayed(const Duration(milliseconds: 200));
    provider.searchPokemon(text);
  }

  void goToDetail(BuildContext context, int pokeId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PokemonDetailPage(pokeId: pokeId)
      )
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SearchPokemonCubit>(),
      child: BlocBuilder<SearchPokemonCubit, SearchPokemonState>(
        builder: (context, state) => buildScaffold(context, state)
      )
    );
  }

  Widget buildScaffold(BuildContext context, SearchPokemonState state) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          key: const Key('backButton'),
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: TextField(
          autofocus: true,
          decoration: const InputDecoration.collapsed(
            hintText: 'Search by name or ID'
          ),
          onSubmitted: (text) {
            searchPokemon(context, text);
          }
        )
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: LayoutBuilder(
          builder: (_, constraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: checkState(context, state),
            )
          )
        )
      )
    );
  }

  Widget checkState(BuildContext context, dynamic state) {
    switch (state.runtimeType) {
      case SearchPokemonData:
        return buildPokemonImage(context, state.searchedPokemon, onTap: () {
          goToDetail(context, state.searchedPokemon.id);
        });
      case SearchPokemonError:
        return messageWidget(child: Text(state.message));
      case LoadingSearchPokemon:
        return messageWidget(child: const CircularProgressIndicator());
      default:
        return messageWidget(child: const SizedBox());
    }
  }

}