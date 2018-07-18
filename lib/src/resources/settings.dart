import 'package:shared_preferences/shared_preferences.dart';
import '../blocs/settings_provider.dart';
import 'dart:async';

class Settings {
  final _color = 'selectedColor';

  Future<String> getSelectedColor() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print('getSelectedColor');
    return prefs.getString(_color) ?? 'white';
  }

  Future<bool> setSelectedColor(String color, context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bloc = SettingsProvider.of(context);
    print('setSelectedColor $color');
    bloc.setSelectedColor(color);
    return prefs.setString(_color, color);
  }
}

final appSettings = Settings();
