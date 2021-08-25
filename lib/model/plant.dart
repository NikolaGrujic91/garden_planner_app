import '../utils/utility.dart';
import 'enums.dart';
import 'json_constants.dart';

class Plant {
  PlantType _type = PlantType.tree;
  String _name = '';
  String _plantedDate = '';

  Plant({required PlantType type}) {
    _type = type;
  }

  Plant.fromJson(Map<String, dynamic> json)
      : _type = stringToPlantType(json[kJsonType]),
        _name = json[kJsonPlantName],
        _plantedDate = json[kJsonPlantedDate];

  Map<String, dynamic> toJson() => {kJsonType: plantTypeToString(_type), kJsonPlantName: _name, kJsonPlantedDate: _plantedDate};

  PlantType get type => _type;
  String get name => _name;
  String get plantedDate => _plantedDate;

  set type(PlantType value) => _type = value;
  set name(String value) => _name = value;
  set plantedDate(String value) => _plantedDate = value;
}
