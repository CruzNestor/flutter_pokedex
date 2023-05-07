import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../../injection_container.dart';
import '../../../../core/constants/ui_constants.dart';
import '../../../../core/utils/converter.dart';
import '../../domain/entities/pokemon_detail.dart';
import '../cubit/pokemon_detail_cubit.dart';

part '../widgets/pokemon_detail_widgets.dart';


class PokemonDetailPage extends StatelessWidget {

  const PokemonDetailPage({required int pokeId, super.key}) : _pokeId = pokeId;
  final int _pokeId;

  void getPokemonData(BuildContext context, int pokeId) {
    final provider = BlocProvider.of<PokemonDetailCubit>(context, listen: false);
    provider.getPokemonData(pokeId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PokemonDetailCubit>(),
      child: BlocBuilder<PokemonDetailCubit, PokemonDetailState>(
        builder: (context, state) => buildScaffold(context, state)
      )
    );
  }

  Widget buildScaffold(BuildContext context, PokemonDetailState state){
    return Container(
      decoration:  BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        image: state is PokemonDetailData
          ? DecorationImage(
            fit: BoxFit.cover,
            image: Image.asset(UIConstants.SPACE_BACKGROUND).image,
          ) 
          : null
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: buildAppBar(context, state),
        body: buildBody(context, state)
      )
    );
  }

  PreferredSizeWidget buildAppBar(BuildContext context, PokemonDetailState state){
    return PreferredSize(
      preferredSize: const Size.fromHeight(0),
      child: AppBar(
        elevation: 0,
        backgroundColor: state is PokemonDetailData 
          ? Colors.transparent 
          : Theme.of(context).scaffoldBackgroundColor,
      )
    );
  }

  Widget buildBody(BuildContext context, PokemonDetailState state) {
    return RefreshIndicator(
      onRefresh: () async {
        getPokemonData(context, _pokeId);
      },
      child: checkState(context, state)
    );
  }

  Widget checkState(BuildContext context, dynamic state){
    switch (state.runtimeType) {
      case PokemonDetailInitial:
        getPokemonData(context, _pokeId);
        return buildLoading();
      case PokemonDetailData:
        return buildContentDetail(context, state.pokemonDetail);
      case PokemonDetailError:
        return buildErrorMessage(state.message);
      default:
        return buildLoading();
    }
  }

  Widget buildContentDetail(BuildContext context, PokemonDetail poke){
    return CustomScrollView(slivers: [
      // Appbar 
      SliverToBoxAdapter(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 14.0),
              child:  GestureDetector(
                key: const Key('backButton'),
                onTap: () => Navigator.of(context).pop(),
                child: ClipOval(
                  child: Container(width: 35,height: 35,
                    color: Colors.white70,
                    child: const Icon(Icons.close, color: Colors.black)
                  )
                )
              )
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 14.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(width: 65, height: 35,
                  color: Colors.white70,
                  child: Center(
                    child: Text('#${poke.id}', 
                      style: const TextStyle(fontWeight: FontWeight.bold)
                    )
                  )
                )
              )
            )
          ]
        )
      ),

      // Content
      SliverStack(children: [
        // Card
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.only(top: 130.0, right: 14.0, bottom: 14.0, left: 14.0),
            padding: const EdgeInsets.only(top: 30.0, bottom: 20.0),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(8)
            ),
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 0.70
            ),
            child: Column(children: [
              buildSectionName(poke.name),
              buildSectionWTH(poke.height, poke.weight, poke.types), // section weight, type and height
              titleHeader('BASE STATS'),
              buildSectionBaseStats(poke.stats),
              titleHeader('ABILITIES'),
              buildSectionAbilities(poke.abilities),
              buildSectionDescription(poke.species),
            ])
          )
        ),

        // Image pokemon
        SliverPositioned(
          top: 10.0, right: 8.0, left: 8.0,
          child: buildPokemonImage(poke.sprites)
        )
      ])
    ]);
  }

  Widget buildErrorMessage(String message) {
    return Column(children: [
      Expanded(
        child: LayoutBuilder(
          builder: (context, constraints) => ListView(children: [
            Container(
              alignment: Alignment.center,
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Text(message)
            )
          ])
        )
      )
    ]);
  }

  Widget buildLoading() {
    return Column(children: const [
      Expanded(
        child: Center(child: CircularProgressIndicator())
      )
    ]);
  }

}