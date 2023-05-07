import 'dart:io';

import 'package:flutter/material.dart';

import 'package:marquee/marquee.dart';
import 'package:path/path.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../../core/constants/http_client_constants.dart';
import '../../../pokemon_detail/presentation/pages/pokemon_detail_page.dart';
import '../../domain/entities/pokemon_page.dart';


Widget buildPokemonList(BuildContext context, PokemonPage data) {
  return Expanded(
    child: GridView.count(
      crossAxisCount: 4,
      childAspectRatio: 0.62,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      children: List.generate(data.results.length, (index) {
        File file = File(data.results[index]['url']); 
        String pokeId = basename(file.path);
        return itemPokemonList(context, int.parse(pokeId), data.results[index]['name']);
      })
    )
  );
}

Widget itemPokemonList(BuildContext context, int id, String name){
  return Card(
    margin: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 4.0),
    child: GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PokemonDetailPage(pokeId: id)
          )
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.topRight,
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 4.0),
            child: Text('#$id', style: const TextStyle(fontSize: 12))
          ),
          SizedBox(
            height: 85,
            child: FadeInImage.memoryNetwork(
              image: '${HTTPClientConstants.POKEMON_ARTWORK}$id.png',
              placeholder: kTransparentImage,
              imageErrorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                return Container(
                  alignment: Alignment.center,
                  child: const Text('Image Not Found', style: TextStyle(fontSize: 10))
                );
              }
            )
          ),
          buildLabelName(name)
        ]
      )
    )
  );
}

Widget buildLabelName(String text) {
  TextStyle style = const TextStyle(fontSize: 10, fontWeight: FontWeight.bold);
  return SizedBox(
    width: 88,
    height: 28,
    child: text.length > 12
    ? Padding(
        padding: const EdgeInsets.only(top: 7),
        child: Marquee(
          text: text.toUpperCase(),
          style: style,
          crossAxisAlignment: CrossAxisAlignment.start,
          blankSpace: 15.0,
          pauseAfterRound: const Duration(seconds: 2),
          startPadding: 5.0,
          velocity: 40.0,
        )
      )
    : Container(
        alignment: Alignment.center,
        child: Text(text.toUpperCase(), textAlign: TextAlign.start, style: style)
      )
  );
}

Widget buildPaginationButtons({
  required BuildContext context,
  PokemonPage? pokemonPage,
  String currentPage = ' ',
  void Function()? onPressedPage,
  void Function()? onPressedFirstPage,
  void Function()? onPressedPreviousPage,
  void Function()? onPressedNextPage,
  void Function()? onPressedLastPage
}) {
  return Container(
    height: 60,
    decoration: BoxDecoration(
      border: Border(top: BorderSide(color: Theme.of(context).primaryColor.withOpacity(0.4), width: 0.5))
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: 100,
          child: Tooltip(
            message: 'Show pages',
            child: OutlinedButton(
              onPressed: onPressedPage, 
              child: Text('Page: $currentPage', 
                style: TextStyle(
                  fontSize: 16,
                  color: pokemonPage == null
                    ? Theme.of(context).disabledColor
                    : Theme.of(context).primaryColor
                )
              )
            )
          )
        ),
        Tooltip(
          message: 'First page',
          child: TextButton(
            onPressed:  pokemonPage?.previous == null 
              ? null
              : onPressedFirstPage,
            child: Text('First', 
              style: TextStyle(
                fontSize: 16, 
                color: pokemonPage?.previous == null 
                  ? Theme.of(context).disabledColor
                  : Theme.of(context).primaryColor
              )
            )
          )
        ),
        Tooltip(
          message: 'Previous',
          child: TextButton(
            onPressed: pokemonPage?.previous == null 
              ? null 
              : onPressedPreviousPage,
            child: Icon(Icons.chevron_left, 
              size: 32,
              color: pokemonPage?.previous == null 
                ? Theme.of(context).disabledColor
                : Theme.of(context).primaryColor
            )
          )
        ),
        Tooltip(
          message: 'Next',
          child: TextButton(
            onPressed: pokemonPage?.next == null 
              ? null 
              : onPressedNextPage,
            child: Icon(Icons.chevron_right, 
              size: 32,
              color: pokemonPage?.next == null 
                ? Theme.of(context).disabledColor
                : Theme.of(context).primaryColor
            )
          )
        ),
        Tooltip(
          message: 'Last page',
          child: TextButton(
            onPressed: pokemonPage?.next == null 
              ? null 
              : onPressedLastPage,
            child: Text('Last', 
              style: TextStyle(
                fontSize: 16,
                color: pokemonPage?.next == null 
                  ? Theme.of(context).disabledColor
                  : Theme.of(context).primaryColor
              )
            )
          )
        )
      ]
    )
  );
}