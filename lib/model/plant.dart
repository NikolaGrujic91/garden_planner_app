import 'enums.dart';
import '../utils/utility.dart';

class Plant {
  PlantType _type = PlantType.tree;
  String _name = '';
  String _plantedDate = '';

  Plant({required PlantType type}) {
    _type = type;
  }

  Plant.fromJson(Map<String, dynamic> json)
      : _type = stringToPlantType(json['type']),
        _name = json['plantName'],
        _plantedDate = json['plantedDate'];

  Map<String, dynamic> toJson() => {'type': plantTypeToString(_type), 'plantName': _name, 'plantedDate': _plantedDate};

  PlantType get type => _type;
  String get name => _name;
  String get plantedDate => _plantedDate;

  set type(PlantType value) => _type = value;
  set name(String value) => _name = value;
  set plantedDate(String value) => _plantedDate = value;
}
