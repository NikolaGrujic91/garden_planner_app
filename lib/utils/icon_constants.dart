import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final _isApple = Platform.isIOS || Platform.isMacOS;

/// Back Icon
IconData kBackIcon = _isApple ? CupertinoIcons.back : Icons.arrow_back;

/// Forward Icon
IconData kForwardIcon = _isApple ? CupertinoIcons.forward : Icons.arrow_forward;

/// Delete Icon
IconData kDeleteIcon = _isApple ? CupertinoIcons.delete : Icons.delete;

/// Edit Icon
IconData kEditIcon = _isApple ? CupertinoIcons.pencil : Icons.edit;

/// Calendar Icon
IconData kCalendarIcon =
    _isApple ? CupertinoIcons.calendar : Icons.calendar_today;

/// Dropdown Arrow Icon
IconData kDropdownArrow =
    _isApple ? CupertinoIcons.arrow_down : Icons.arrow_downward;

/// Grid Icon
IconData kGridIcon = _isApple ? CupertinoIcons.circle_grid_3x3 : Icons.grid_4x4;

/// Camera Icon
IconData kCameraIcon = _isApple ? CupertinoIcons.camera_fill : Icons.camera_alt;

/// Add Icon
IconData kAddIcon = _isApple ? CupertinoIcons.add : Icons.add;

/// Water
IconData kWater = CupertinoIcons.drop;

/// Insects
IconData kAnt = CupertinoIcons.ant;

/// Fertilize
IconData kFertilize = Icons.agriculture;
