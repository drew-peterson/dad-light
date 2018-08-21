import 'package:shared_preferences/shared_preferences.dart';
import '../blocs/settings_provider.dart';
import 'package:screen/screen.dart';
import 'dart:async';

class Settings {
  final _color = 'selectedColor';
  final _brightness = 'BRIGHTNESS';
  double defaultBrightness = 0.01; // STORE

  Future<double> getBrightness() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final b = await Screen.brightness;
    if (defaultBrightness == 0.01) {
      defaultBrightness = b;
    }
    return prefs.getDouble(_brightness) ?? b;
  }

  Future<String> getSelectedColor() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_color) ?? 'white';
  }

  Future setSelectedColor(String color, context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bloc = SettingsProvider.of(context);
    bloc.setSelectedColor(color);
    prefs.setString(_color, color);
  }

  Future setBrightness(double value, context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bloc = SettingsProvider.of(context);
    prefs.setDouble(_brightness, value);
    bloc.setBrightness(value);
  }
}

final appSettings = Settings();
