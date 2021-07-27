import 'dart:collection';
import 'enums.dart';
import 'tile.dart';

class Garden {
  String _name = '';
  int _rows = 0;
  int _columns = 0;
  List<Tile> _tiles = <Tile>[];

  Garden({required String name, required int rows, required int columns}) {
    _name = name;
    _rows = rows;
    _columns = columns;
    _createTiles();
  }

  Garden.fromJson(Map<String, dynamic> json)
      : _name = json['name'],
        _rows = json['rows'],
        _columns = json['columns'],
        _tiles = (json['tiles'] as List).map((i) => Tile.fromJson(i)).toList();

  Map<String, dynamic> toJson() => {'name': _name, 'rows': _rows, 'columns': _columns, 'tiles': _tiles};

  String get name => _name;
  int get rows => _rows;
  int get columns => _columns;
  UnmodifiableListView<Tile> get tiles => UnmodifiableListView(_tiles);

  set name(String value) => _name = value;
  set rows(int value) => _rows = value;
  set columns(int value) => _columns = value;

  void updateTiles() {
    var newSize = _columns * _rows;

    // Grid expanding
    if (_tiles.length < newSize) {
      for (int index = 0; index <= newSize; index++) {
        if (_tiles.length > index) {
          continue;
        }

        _tiles.add(Tile(type: TileType.plant));
      }
    }

    // Grid shrinking
    if (_tiles.length > newSize) {
      while (_tiles.length > newSize) {
        _tiles.removeLast();
      }
    }
  }

  void updateTileType({required int index, required TileType type}) {
    _tiles[index].type = type;
  }

  void addTilePlant({required int tileIndex, required PlantType plantType}) {
    _tiles[tileIndex].addPlant(plantType: plantType);
  }

  void _createTiles() {
    for (int row = 0; row < _rows; row++) {
      for (int column = 0; column < _columns; column++) {
        _tiles.add(Tile(type: TileType.plant));
      }
    }
  }
}
