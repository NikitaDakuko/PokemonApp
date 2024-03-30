import 'package:flutter/material.dart';
import '../Entity/pokemon.dart';

class PokemonView extends StatelessWidget {
  const PokemonView({super.key, required this.pokemon});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    List<Widget> types = [];

    for (var t in pokemon.types) {
      types.add(Container(
        decoration: BoxDecoration(
          color: t.color,
        ),
        child: Text(t.name),
      ));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(pokemon.name),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Name: ${pokemon.name}'),
            Text('Weight: ${pokemon.weight}'),
            Text('Height: ${pokemon.height}'),
            Wrap(
              children: types,
            )
          ],
        ),
      ),
    );
  }
}