import 'enum_poke_type.dart';

class Pokemon {
  const Pokemon({
    required this.id,
    required this.name,
    required this.pictureURL,
    required this.types,
    required this.weight,
    required this.height,
  });

  final int id;
  final String name;
  final String pictureURL;
  final List<PokeType> types;
  final int weight;
  final int height;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'pictureURL': pictureURL,
      'typesParsed': types,
      'weight': weight,
      'height': height,
    };
  }

  factory Pokemon.fromMap(Map<String, dynamic> map) {
    return Pokemon(
      id: map['id'],
      name: map['name'],
      pictureURL: map['pictureURL'],
      types: map['typesParsed'],
      weight: map['weight'],
      height: map['height'],
    );
  }

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    json['pictureURL'] = json['sprites']['front_default'];
    json['typesParsed'] = (json['types'] as List)
        .cast<Map<String, dynamic>>()
        .map((e) => PokeType.values.byName(e['type']['name']))
        .toList();

    return Pokemon.fromMap(json);
  }
}
