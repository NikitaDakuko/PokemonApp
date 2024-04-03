import 'dart:ui';

import 'package:hive/hive.dart';

@HiveType(typeId: 2)
enum PokeType {
  normal(Color(0xFFa8a878)),
  fire(Color(0xFFf08030)),
  water(Color(0xFF6890f0)),
  electric(Color(0xFFf8d030)),
  grass(Color(0xFF78c850)),
  ice(Color(0xFF98d8d8)),
  fighting(Color(0xFFc03028)),
  poison(Color(0xFFa040a0)),
  ground(Color(0xFFe0c068)),
  flying(Color(0xFFa890f0)),
  psychic(Color(0xFFf85888)),
  bug(Color(0xFFa8b820)),
  rock(Color(0xFFb8a038)),
  ghost(Color(0xFF705898)),
  dragon(Color(0xFF7038f8)),
  dark(Color(0xFF705848)),
  steel(Color(0xFFb8b8d0)),
  fairy(Color(0xFFf0b6bc)),
  stellar(Color(0xFF35ace7));

  const PokeType(this.color);
  final Color color;
}
