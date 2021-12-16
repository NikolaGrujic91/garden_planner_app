import 'package:garden_planner_app/model/enums.dart';

/// Plant parameter object. Used for updating plant.
class PlantParameterObject {
  /// Creates a new instance
  PlantParameterObject({
    required this.type,
    required this.name,
    required this.plantedDate,
    required this.description,
    required this.wateringStartDate,
    required this.wateringFrequency,
    required this.fertilizingStartDate,
    required this.fertilizingFrequency,
    required this.pesticideStartDate,
    required this.pesticideFrequency,
  });

  /// Plant index
  late int index;

  /// Plant type
  PlantType type;

  /// Name
  String name;

  /// Planted date
  String plantedDate;

  /// Additional description
  String description;

  /// Watering start date
  String wateringStartDate;

  /// Watering frequency in days
  int wateringFrequency;

  /// Fertilizing start date
  String fertilizingStartDate;

  /// Fertilizing frequency in days
  int fertilizingFrequency;

  /// Pesticide start date
  String pesticideStartDate;

  /// Pesticide frequency in days
  int pesticideFrequency;
}
