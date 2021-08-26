import '../utils/utility.dart';
import 'enums.dart';
import 'json_constants.dart';

class Plant {
  PlantType _type = PlantType.tree;
  String _name = '';
  String _plantedDate = '';
  String _description = '';

  Plant({required PlantType type}) {
    _type = type;
  }

  Plant.fromJson(Map<String, dynamic> json)
      : _type = stringToPlantType(json[kJsonType]),
        _name = json[kJsonPlantName],
        _plantedDate = json[kJsonPlantedDate],
        _description = json[kJsonDescription];

  Map<String, dynamic> toJson() => {kJsonType: plantTypeToString(_type), kJsonPlantName: _name, kJsonPlantedDate: _plantedDate, kJsonDescription: _description};

  PlantType get type => _type;
  String get name => _name;
  String get plantedDate => _plantedDate;
  String get description => _description;

  set type(PlantType value) => _type = value;
  set name(String value) => _name = value;
  set plantedDate(String value) => _plantedDate = value;
  set description(String value) => _description = value;
}
