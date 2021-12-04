import 'package:garden_planner_app/model/enums.dart';
import 'package:garden_planner_app/utils/hive_field_id.dart';
import 'package:garden_planner_app/utils/hive_type_id.dart';
import 'package:garden_planner_app/utils/json_constants.dart';
import 'package:garden_planner_app/utils/utility.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'plant.g.dart';

/// Model class that stores Plant data
@HiveType(typeId: kHiveTypeId0)
class Plant extends HiveObject {
  /// Creates a new instance
  Plant({required this.type});

  /// Creates a new instance from JSON
  Plant.fromJson(Map<String, dynamic> json)
      : id = json[kJsonId].toString(),
        type = stringToPlantType(json[kJsonType].toString()),
        name = json[kJsonPlantName].toString(),
        plantedDate = json[kJsonPlantedDate].toString(),
        description = json[kJsonDescription].toString();

  /// ID
  @HiveField(kHiveFieldId0)
  String id = const Uuid().v1();

  /// Plant type
  @HiveField(kHiveFieldId1)
  PlantType type = PlantType.tree;

  /// Name
  @HiveField(kHiveFieldId2)
  String name = '';

  /// Planted date
  @HiveField(kHiveFieldId3)
  String plantedDate = '';

  /// Additional description
  @HiveField(kHiveFieldId4)
  String description = '';

  /// List of image guids
  @HiveField(kHiveFieldId5)
  List<String>? images = <String>[];

  /// Watering start date
  @HiveField(kHiveFieldId6)
  String wateringStartDate = '';

  /// Watering frequency in days
  @HiveField(kHiveFieldId7)
  int wateringFrequency = 0;

  /// Fertilizing start date
  @HiveField(kHiveFieldId8)
  String fertilizingStartDate = '';

  /// Fertilizing frequency in days
  @HiveField(kHiveFieldId9)
  int fertilizingFrequency = 0;

  /// Watering dates
  /// Key - date
  /// Value - List of plants to water on a date
  @HiveField(kHiveFieldId10)
  Map<DateTime, List<String>> wateringDates = <DateTime, List<String>>{};

  /// Fertilizing dates
  /// Key - date
  /// Value - List of plants to fertilize on a date
  @HiveField(kHiveFieldId11)
  Map<DateTime, List<String>> fertilizingDates = <DateTime, List<String>>{};

  /// Convert object data to JSON
  Map<String, dynamic> toJson() => <String, dynamic>{
        kJsonId: id,
        kJsonType: plantTypeToString(type),
        kJsonPlantName: name,
        kJsonPlantedDate: plantedDate,
        kJsonDescription: description,
      };

  /// Add image to plant images
  void addImage({required String image}) {
    images ??= <String>[];
    images!.add(image);
  }

  /// Remove image from plant at index
  void removeImage({required int index}) {
    if (images == null) {
      return;
    }

    if (index >= images!.length) {
      return;
    }

    images!.removeAt(index);
  }

  /// Update plant data
  void update({
    required String name,
    required String plantedDate,
    required String wateringStartDate,
    required int wateringFrequency,
    required String fertilizingStartDate,
    required int fertilizingFrequency,
    required PlantType type,
    required String description,
  }) {
    final wateringChanged = this.wateringStartDate != wateringStartDate ||
        this.wateringFrequency != wateringFrequency;

    final fertilizingChanged =
        this.fertilizingStartDate != fertilizingStartDate ||
            this.fertilizingFrequency != fertilizingFrequency;

    this.name = name;
    this.plantedDate = plantedDate;
    this.wateringStartDate = wateringStartDate;
    this.wateringFrequency = wateringFrequency;
    this.fertilizingStartDate = fertilizingStartDate;
    this.fertilizingFrequency = fertilizingFrequency;
    this.type = type;
    this.description = description;

    if (wateringChanged) {
      _calculateWateringDates();
    }

    if (fertilizingChanged) {
      _calculateFertilizingDates();
    }
  }

  /// Calculate watering dates
  void _calculateWateringDates() {
    wateringDates.clear();

    final startDate = _stringToDateTime(wateringStartDate);
    final dateValue = ['Water $name'];

    for (var i = 0; i < 400; i++) {
      final dateKey = startDate.add(Duration(days: wateringFrequency * i));

      wateringDates.putIfAbsent(
        dateKey,
        () => dateValue,
      );
    }
  }

  /// Calculate fertilizing dates
  void _calculateFertilizingDates() {
    fertilizingDates.clear();

    final startDate = _stringToDateTime(fertilizingStartDate);
    final dateValue = ['Fertilize $name'];

    for (var i = 0; i < 400; i++) {
      final dateKey = startDate.add(Duration(days: fertilizingFrequency * i));

      fertilizingDates.putIfAbsent(
        dateKey,
        () => dateValue,
      );
    }
  }

  DateTime _stringToDateTime(String value) {
    final dateParts = value.split('.');
    final day = int.parse(dateParts[0]);
    final month = int.parse(dateParts[1]);
    final year = int.parse(dateParts[2]);

    return DateTime(year, month, day);
  }
}
