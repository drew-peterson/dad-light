import 'package:flutter/material.dart';
import '../blocs/settings_provider.dart';
import '../widgets/color_box.dart';
// import '../resources/settings.dart';
// import 'package:screen/screen.dart';
import '../widgets/brightness_slider.dart';

class ColorsSettings extends StatelessWidget {
  Widget build(BuildContext context) {
    final bloc = SettingsProvider.of(context);
    return StreamBuilder(
      stream: bloc.selectedColor,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            color: Colors.grey[300],
            margin: EdgeInsets.all(5.0),
          );
        }
        return Container(
          color: Colors.grey[200],
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              BrightnessSlider(),
              Container(
                margin: EdgeInsets.only(top: 10.0),
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  children: buildBoxList(snapshot),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<ColorBox> buildBoxList(AsyncSnapshot snapshot) {
    final List<String> colors = ['white', 'yellow', 'red', 'green', 'blue'];
    return colors
        .map(
          (color) => ColorBox(
                color: color,
                selected: color == snapshot.data,
              ),
        )
        .toList();
  }
}
