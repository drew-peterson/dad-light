import 'package:flutter/material.dart';
import '../resources/settings.dart';
import '../app_constants.dart' as globals;

class ColorBox extends StatelessWidget {
  final String color;
  final bool selected;

  ColorBox({this.color, this.selected});

  Widget build(context) {
    return InkWell(
      onTap: () => appSettings.setSelectedColor(color, context),
      child: Card(
        color: globals.colorMap[color],
        elevation: selected ? 4.0 : 1.0,
        margin: EdgeInsets.all(5.0),
        child: selected
            ? Center(
                child: Icon(
                  Icons.check,
                  size: 40.0,
                ),
              )
            : null,
      ),
    );
  }
}
