import 'package:flutter/material.dart';
import '../blocs/settings_provider.dart';
import '../resources/settings.dart';

class BrightnessSlider extends StatelessWidget {
  Widget build(BuildContext context) {
    final bloc = SettingsProvider.of(context);
    return StreamBuilder(
      stream: bloc.brightness, // Get the current brightness:
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text('loading...');
        }
        return Container(
          child: Column(children: [
            Text('Brightness: ${snapshot.data.toStringAsFixed(2)}'),
            Slider(
              min: 0.0,
              max: 1.0,
              value: snapshot.data,
              onChanged: (double value) =>
                  appSettings.setBrightness(value, context),
            ),
          ]),
        );
      },
    );
  }
}
