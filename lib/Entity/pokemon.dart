import 'enum_poke_type.dart';

class Pokemon {
  Pokemon({
    required this.name,
    this.pictureURL = '',
    required this.types,
    required this.weight,
    required this.height,
  });

  String name;
  String pictureURL;
  List<PokeType> types;
  int weight;
  int height;

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      pictureURL: json['sprites']['front_default'],
      weight: json['weight'],
      height: json['height'],
      types: (json['types'] as List)
          .cast<Map<String, dynamic>>()
          .map((e) => PokeType.values.byName(e['type']['name']))
          .toList(),
    );
  }
}
