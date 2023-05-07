// ignore_for_file: constant_identifier_names

class UIConstants {
  static const String APP_NAME = 'Pokedex';
  static const String LOGO = 'assets/images/pokemon_logo_small.png';
  static const String SPACE_BACKGROUND = 'assets/images/space_background.jpg';

  // Pokemon types
  static const String TYPE_BUG = 'assets/images/pokemon_type_bug.png';
  static const String TYPE_DARK = 'assets/images/pokemon_type_dark.png';
  static const String TYPE_DRAGON = 'assets/images/pokemon_type_dragon.png';
  static const String TYPE_ELECTRIC = 'assets/images/pokemon_type_electric.png';
  static const String TYPE_FAIRY = 'assets/images/pokemon_type_fairy.png';
  static const String TYPE_FIGHTING = 'assets/images/pokemon_type_fighting.png';
  static const String TYPE_FIRE = 'assets/images/pokemon_type_fire.png';
  static const String TYPE_FLYING = 'assets/images/pokemon_type_flying.png';
  static const String TYPE_GHOST = 'assets/images/pokemon_type_ghost.png';
  static const String TYPE_GRASS = 'assets/images/pokemon_type_grass.png';
  static const String TYPE_GROUND = 'assets/images/pokemon_type_ground.png';
  static const String TYPE_ICE = 'assets/images/pokemon_type_ice.png';
  static const String TYPE_NORMAL = 'assets/images/pokemon_type_normal.png';
  static const String TYPE_POISON = 'assets/images/pokemon_type_poison.png';
  static const String TYPE_PSYCHIC = 'assets/images/pokemon_type_psychic.png';
  static const String TYPE_ROCK = 'assets/images/pokemon_type_rock.png';
  static const String TYPE_STEEL = 'assets/images/pokemon_type_steel.png';
  static const String TYPE_WATER = 'assets/images/pokemon_type_water.png';
  
  static String getPokemonTypeImage(String type) {
    switch (type) {
      case 'bug':
        return UIConstants.TYPE_BUG;
      case 'dark':
        return UIConstants.TYPE_DARK;
      case 'dragon':
        return UIConstants.TYPE_DRAGON;
      case 'electric':
        return UIConstants.TYPE_ELECTRIC;
      case 'fairy':
        return UIConstants.TYPE_FAIRY;
      case 'fighting':
        return UIConstants.TYPE_FIGHTING;
      case 'fire':
        return UIConstants.TYPE_FIRE;
      case 'flying':
        return UIConstants.TYPE_FLYING;
      case 'ghost':
        return UIConstants.TYPE_GHOST;
      case 'grass':
        return UIConstants.TYPE_GRASS;
      case 'ground':
        return UIConstants.TYPE_GROUND;
      case 'ice':
        return UIConstants.TYPE_ICE;
      case 'poison':
        return UIConstants.TYPE_POISON;
      case 'psychic':
        return UIConstants.TYPE_PSYCHIC;
      case 'rock':
        return UIConstants.TYPE_ROCK;
      case 'steel':
        return UIConstants.TYPE_STEEL;
      case 'water':
        return UIConstants.TYPE_WATER;
      default:
        return UIConstants.TYPE_NORMAL;
    }
  }
}