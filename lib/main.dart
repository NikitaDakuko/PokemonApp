import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pokemon_application/Cache/pokemon_adapter.dart';

import 'View/home_page.dart';

void main() {
  Hive.registerAdapter(PokemonAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Pokemon app'),
    );
  }
}

