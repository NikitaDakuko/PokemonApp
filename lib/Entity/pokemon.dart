import 'package:hive/hive.dart';
import 'enum_poke_type.dart';

@HiveType(typeId: 0)
class Pokemon extends HiveObject {
  Pokemon({
    required this.id,
    required this.name,
    required this.pictureURL,
    required this.types,
    required this.weight,
    required this.height,
  });

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String pictureURL;
  final List<PokeType> types;
  @HiveField(3)
  final int weight;
  @HiveField(4)
  final int height;

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      pictureURL: json['sprites']['front_default'],
      types: (json['types'] as List)
          .cast<Map<String, dynamic>>()
          .map((e) => PokeType.values.byName(e['type']['name']))
          .toList(),
      weight: json['weight'],
      height: json['height'],
    );
  }
}
