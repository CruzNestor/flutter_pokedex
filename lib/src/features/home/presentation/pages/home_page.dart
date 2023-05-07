import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../injection_container.dart';
import '../../../../core/constants/http_client_constants.dart';
import '../../../../core/constants/ui_constants.dart';
import '../../../search_pokemon/presentation/pages/search_pokemon_page.dart';
import '../cubit/home_cubit.dart';
import '../widgets/home_widgets.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});
  
  void onPressedLastPage(BuildContext context, int count) {
    int lastPage = (count / HTTPClientConstants.limit).ceil();
    final provider = BlocProvider.of<HomeCubit>(context, listen: false);
    provider.getPokemonPage(lastPage);
  }

  void getPokemonPage(BuildContext context, int page) {
    final provider = BlocProvider.of<HomeCubit>(context, listen: false);
    provider.getPokemonPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HomeCubit>(),
      child: Scaffold(
        appBar: buildAppBar(context),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return buildContentBody(context, state);
          }
        )
      )
    );
  }

  PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      title: Image.asset(UIConstants.LOGO, width: 100, height: 40),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Tooltip(
            message: 'Search',
            child: IconButton(
              onPressed: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SearchPokemonPage())
                );
              },
              icon: const Icon(Icons.search_outlined, size: 30)
            )
          )
        )
      ]
    );
  }

  Widget buildContentBody(BuildContext context, HomeState state) {
    return RefreshIndicator(
      onRefresh: () async {
        if(state is PokemonPageData){
          getPokemonPage(context, state.page);
        } else if(state is PokemonPageError){
          getPokemonPage(context, state.page);
        }
      },
      child: Column(
        children: [
          checkState(context, state),
          buildSectionButtons(context, state)
        ]
      )
    );
  }

  Widget checkState(BuildContext context, dynamic state){
    switch (state.runtimeType) {
      case HomeInitial:
        getPokemonPage(context, 1);
        return buildLoading();
      case PokemonPageData:
        return buildPokemonList(context, state.pokemonPage);
      case PokemonPageError:
        return buildErrorMessage(state.message);
      default:
        return buildLoading();
    }
  }

  Widget buildSectionButtons(BuildContext context, dynamic state){
    switch (state.runtimeType) {
      case PokemonPageData:
        return buildPaginationButtons(
          context: context,
          currentPage: state.page.toString(),
          onPressedPage: () {
            dialogPage(context: context, count: state.pokemonPage.count);
          },
          onPressedFirstPage: () {
            getPokemonPage(context, 1);
          },
          onPressedPreviousPage: () {
            int page = state.page - 1;
            getPokemonPage(context , page);
          },
          onPressedNextPage: () {
            int page = state.page + 1;
            getPokemonPage(context, page);
          },
          onPressedLastPage: () {
            onPressedLastPage(context, state.pokemonPage.count);
          },
          pokemonPage: state.pokemonPage,
        );
      default:
        return buildPaginationButtons(context: context);
    }
  }

  void dialogPage({required BuildContext context, required int count}){
    int pages = (count / HTTPClientConstants.limit).ceil();
    double height = MediaQuery.of(context).size.height * 0.50;
    double width = MediaQuery.of(context).size.height * 0.40;

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (_, __, ___) => AlertDialog(
        backgroundColor: Theme.of(context).canvasColor,
        insetPadding: EdgeInsets.zero,
        contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
        shape: const RoundedRectangleBorder(
          borderRadius:BorderRadius.all(Radius.circular(8.0)),
        ),
        title: Text('Pages', 
          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
        content: SizedBox(
          height: height,
          width: width,
          child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: pages,
            itemBuilder: (_, index) {
              int idx = index + 1;
              return InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  getPokemonPage(context, idx);
                },
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  alignment: Alignment.centerLeft,
                  child: Text('Page $idx')
                )
              );
            }
          )
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            )
          )
        ]
      ),
      transitionBuilder: (_, a1, a2, child) =>Transform.scale(
        scale: a1.value,
        child: child,
      )
    );
  }

  Widget buildErrorMessage(String message){
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ListView(children: [
            Container(
              alignment: Alignment.center,
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Text(message)
            )
          ]);
        }
      )
    );
  }

  Widget buildLoading(){
    return const Expanded(
      child: Center(child: CircularProgressIndicator())
    );
  }
  
}