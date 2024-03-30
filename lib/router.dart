import 'package:flutter/material.dart';
import 'package:pokemon_application/Entity/pokemon.dart';

import 'View/pokemon_view.dart';

class PokemonRouter {
    void presentPokemon(BuildContext context, Pokemon pokemon){
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => PokemonView(pokemon: pokemon)));
    }

}