// ignore_for_file: constant_identifier_names

class HTTPClientConstants {
  //? HTTP CLIENT OPTIONS
  // Timeout
  static const Duration CONNECT_TIMEOUT = Duration(seconds: 5);
  static const Duration RECEIVE_TIMEOUT = Duration(seconds: 5);
  static const int limit = 24;

  // Total pokemon
  static const int TOTAL_POKEMON = 1010; // total national pokedex

  // Base url
  static const String BASE_URL = 'https://pokeapi.co/api/v2/';

  // Image url
  static const String POKEMON_ARTWORK = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/';
  
}