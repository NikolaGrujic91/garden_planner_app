import 'package:garden_planner_app/model/enums.dart';
import 'package:garden_planner_app/model/plant_parameter_object.dart';
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

  /// Pesticide start date
  @HiveField(kHiveFieldId12)
  String pesticideStartDate = '';

  /// Pesticide frequency in days
  @HiveField(kHiveFieldId13)
  int pesticideFrequency = 0;

  /// Watering dates
  /// Key - date
  /// Value - List of plants to water on a date
  @HiveField(kHiveFieldId10)
  Map<DateTime, String> wateringDates = <DateTime, String>{};

  /// Fertilizing dates
  /// Key - date
  /// Value - List of plants to fertilize on a date
  @HiveField(kHiveFieldId11)
  Map<DateTime, String> fertilizingDates = <DateTime, String>{};

  /// Pesticide dates
  /// Key - date
  /// Value - List of plants to apply pesticide on a date
  @HiveField(kHiveFieldId14)
  Map<DateTime, String> pesticideDates = <DateTime, String>{};

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
  void update({required PlantParameterObject parameter}) {
    final wateringChanged = wateringStartDate != parameter.wateringStartDate ||
        wateringFrequency != parameter.wateringFrequency;

    final fertilizingChanged =
        fertilizingStartDate != parameter.fertilizingStartDate ||
            fertilizingFrequency != parameter.fertilizingFrequency;

    final pesticideChanged =
        pesticideStartDate != parameter.pesticideStartDate ||
            pesticideFrequency != parameter.pesticideFrequency;

    name = parameter.name;
    plantedDate = parameter.plantedDate;
    wateringStartDate = parameter.wateringStartDate;
    wateringFrequency = parameter.wateringFrequency;
    fertilizingStartDate = parameter.fertilizingStartDate;
    fertilizingFrequency = parameter.fertilizingFrequency;
    pesticideStartDate = parameter.pesticideStartDate;
    pesticideFrequency = parameter.pesticideFrequency;
    type = parameter.type;
    description = parameter.description;

    if (wateringChanged) {
      _calculateDates(
        wateringStartDate,
        wateringFrequency,
        wateringDates,
        'Water $name',
      );
    }

    if (fertilizingChanged) {
      _calculateDates(
        fertilizingStartDate,
        fertilizingFrequency,
        fertilizingDates,
        'Fertilize $name',
      );
    }

    if (pesticideChanged) {
      _calculateDates(
        pesticideStartDate,
        pesticideFrequency,
        pesticideDates,
        'Pesticide $name',
      );
    }
  }

  void _calculateDates(
    String startDate,
    int frequency,
    Map<DateTime, String> dates,
    String text,
  ) {
    if (startDate.isEmpty) {
      return;
    }

    dates.clear();

    final startDateTime = _stringToDateTime(startDate);

    for (var i = 0; i < 400; i++) {
      final increasedDate = startDateTime.add(Duration(days: frequency * i));

      final dateKey = DateTime(
        increasedDate.year,
        increasedDate.month,
        increasedDate.day,
      );

      dates.putIfAbsent(
        dateKey,
        () => text,
      );
    }
  }

  DateTime _stringToDateTime(String value) {
    if (value.isEmpty) {
      return DateTime.now();
    }

    final dateParts = value.split('.');
    final day = int.parse(dateParts[0]);
    final month = int.parse(dateParts[1]);
    final year = int.parse(dateParts[2]);

    return DateTime(year, month, day);
  }
}
