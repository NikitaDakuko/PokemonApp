import 'package:flutter/material.dart';
import 'package:pokemon_application/Interactor/pokemon_interactor.dart';

class PokemonPresenter {
  PokemonPresenter(this.pokemonInteractor);

  final PokemonInteractor pokemonInteractor;

  List<Widget> getTypes() {
    List<Widget> w = [];

    for (var t in pokemonInteractor.pokemon.types) {
      w.add(Container(
        decoration: BoxDecoration(
          color: t.color,
        ),
        child: Text(t.name),
      ));
    }
    return w;
  }
}
