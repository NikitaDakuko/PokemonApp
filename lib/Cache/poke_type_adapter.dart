import 'package:hive/hive.dart';
import 'package:pokemon_application/Entity/enum_poke_type.dart';

class PokeTypeAdapter extends TypeAdapter<PokeType> {
  @override
  final typeId = 1;

  @override
  PokeType read(BinaryReader reader) {
    return PokeType.values.byName(reader.read());
  }

  @override
  void write(BinaryWriter writer, PokeType obj) {
    writer.write(obj.name);
  }
}