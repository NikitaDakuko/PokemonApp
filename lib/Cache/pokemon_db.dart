import 'dart:collection';

import 'package:pokemon_application/Entity/pokemon.dart';

class PokemonDB extends ListBase<Pokemon> {
  final List<Map<String, Object?>> list;
  late List<Pokemon?> _cachePokemon;

  PokemonDB(this.list) {
    _cachePokemon = List.generate(list.length, (index) => null);
  }

  @override
  int get length => list.length;

  @override
  Pokemon operator [](int index) {
    return _cachePokemon[index] ??= Pokemon.fromMap(list[index]);
  }

  @override
  void operator []=(int index, Pokemon value) {
    _cachePokemon[index] = value;
  }

  @override
  set length(int newLength) => throw 'read-only';
}