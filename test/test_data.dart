import 'package:pokemon_application/Entity/enum_poke_type.dart';
import 'package:pokemon_application/Entity/pokemon.dart';

class TestData {
  //////////////////MOCK CLIENT//////////////////

  final pokemonListURL = 'https://pokeapi.co/api/v2/pokemon?offset=0&limit=3';
  final listResponse = {
    "results": [
      {"name": "bulbasaur", "url": "https://pokeapi.co/api/v2/pokemon/1/"},
      {"name": "ivysaur", "url": "https://pokeapi.co/api/v2/pokemon/2/"},
      {"name": "venusaur", "url": "https://pokeapi.co/api/v2/pokemon/3/"}
    ]
  };

  Map<String, int> pokemonListResult = {
    "bulbasaur": 1,
    "ivysaur": 2,
    "venusaur": 3
  };

  final pokemonURL = 'https://pokeapi.co/api/v2/pokemon/69/';
  final pokemonResponse =
      '{ "height": 7, "id": 69, "is_default": true, "name": "bellsprout", "order": 110, "sprites": { "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/69.png" }, "types": [ { "slot": 1, "type": { "name": "grass", "url": "https://pokeapi.co/api/v2/type/12/" } }, { "slot": 2, "type": { "name": "poison", "url": "https://pokeapi.co/api/v2/type/4/" } } ], "weight": 40 }';

  final pokemonResult = Pokemon(
      id: 69,
      name: "bellsprout",
      pictureURL:
          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/69.png",
      types: [PokeType.grass, PokeType.poison],
      weight: 40,
      height: 7);
}
