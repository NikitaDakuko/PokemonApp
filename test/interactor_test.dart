import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:pokemon_application/Entity/enum_poke_type.dart';
import 'package:pokemon_application/Entity/pokemon.dart';
import 'package:pokemon_application/Interactor/pokemon_interactor.dart';

import 'interactor_test.mocks.dart';

@GenerateMocks([http.Client])
void main() async {
  ///////////////////////////////////////////////
  //////////////////MOCK CLIENT//////////////////
  ///////////////////////////////////////////////

  const listResponse =
      '{"results":[{"name":"bulbasaur","url":"https://pokeapi.co/api/v2/pokemon/1/"},{"name":"ivysaur","url":"https://pokeapi.co/api/v2/pokemon/2/"},{"name":"venusaur","url":"https://pokeapi.co/api/v2/pokemon/3/"}]}';

  Map<String, int> pokemonListResult = {
    "bulbasaur": 1,
    "ivysaur": 2,
    "venusaur": 3
  };

  const pokemonResponse =
      '{ "height": 7, "id": 69, "is_default": true, "name": "bellsprout", "order": 110, "sprites": { "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/69.png" }, "types": [ { "slot": 1, "type": { "name": "grass", "url": "https://pokeapi.co/api/v2/type/12/" } }, { "slot": 2, "type": { "name": "poison", "url": "https://pokeapi.co/api/v2/type/4/" } } ], "weight": 40 }';

  final pokemonResult = Pokemon(
      id: 69,
      name: "bellsprout",
      pictureURL:
          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/69.png",
      types: [PokeType.grass, PokeType.poison],
      weight: 40,
      height: 7);

  final client = MockClient();
  when(client.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/69/')))
      .thenAnswer((_) async => http.Response(pokemonResponse, 200));
  when(client
          .get(Uri.parse('https://pokeapi.co/api/v2/pokemon?offset=0&limit=3')))
      .thenAnswer((_) async => http.Response(listResponse, 200));

  ///////////////////////////////////////////////
  /////////////////////TESTS/////////////////////
  ///////////////////////////////////////////////

  group('PokemonInteractor testing start', () {
    final PokemonInteractor pokemonInteractor = PokemonInteractor();
    pokemonInteractor.cache.openDB();

    test('JSON should be parsed', () {
      expect(pokemonInteractor.parseListOfPokemon(listResponse),
          pokemonListResult);
    });

    test('List of Pokemon should be fetched and parsed', () async {
      expect(await pokemonInteractor.fetchListOfPokemon(client, 3, 0),
          pokemonListResult);
    });

    test('Pokemon should be fetched and parsed', () async {
      expect((await pokemonInteractor.fetchPokemon(client, 69)).toString(),
          pokemonResult.toString());
    });
  });
}
