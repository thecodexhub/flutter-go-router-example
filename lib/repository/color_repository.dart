import 'package:flutter/material.dart';

class ColorRepository {
  Map<String, MaterialColor>? colorMap;

  void loadColorMap() {
    colorMap = {
      'red': Colors.red,
      'indigo': Colors.indigo,
      'lime': Colors.lime,
    };
  }

  MapEntry<String, MaterialColor> getMapEntryAt(int index) {
    return colorMap!.entries.elementAt(index);
  }

  MaterialColor getColorAt(int index) {
    return colorMap!.values.elementAt(index);
  }

  String getColorKeyAt(int index) {
    return colorMap!.keys.elementAt(index).capitalize;
  }

  Color computeTextColorFor(int index) {
    return colorMap!.values.elementAt(index).computeLuminance() > 0.4
        ? Colors.black
        : Colors.white;
  }
}

extension StringExt on String {
  String get capitalize {
    final modifiedStr = replaceAll('-', ' ').split(' ');
    for (int i = 0; i < modifiedStr.length; i++) {
      modifiedStr[i] = '${modifiedStr[i].substring(0, 1).toUpperCase()}'
          '${modifiedStr[i].substring(1).toLowerCase()}';
    }
    return modifiedStr.join(' ');
  }
}
