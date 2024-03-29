import 'package:flutter/material.dart';
import 'package:pokemon_application/Presenter/pokemon_presenter.dart';

class PokemonView extends StatefulWidget{
  const PokemonView({super.key});

  @override
  State<StatefulWidget> createState() => _PokemonViewState();
}

class _PokemonViewState extends State<PokemonView>{
  late PokemonPresenter pokemonPresenter;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}