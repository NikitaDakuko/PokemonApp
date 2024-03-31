import 'package:flutter/material.dart';
import '../Entity/pokemon.dart';

class PokemonView extends StatelessWidget {
  const PokemonView({super.key, required this.pokemon});

  final TextStyle ts = const TextStyle(fontSize: 30);
  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    List<Widget> types = [];

    for (var t in pokemon.types) {
      types.add(
        Container(
          margin: const EdgeInsets.all(5.0),
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: t.color,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            t.name,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w200,
                color: t.color.computeLuminance() < 0.5
                    ? Colors.white
                    : Colors.black),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(pokemon.name),
      ),
      body: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              pokemon.pictureURL,
              scale: 0.3,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Name: ${pokemon.name}',
                  style: ts,
                ),
                Text(
                  'Weight: ${pokemon.weight}',
                  style: ts,
                ),
                Text(
                  'Height: ${pokemon.height}',
                  style: ts,
                ),
                Wrap(
                  children: types,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
