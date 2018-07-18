import 'package:flutter/material.dart';
import 'settings_bloc.dart';
export 'settings_bloc.dart'; // so when we import provider you get stories

class SettingsProvider extends InheritedWidget {
  final SettingsBloc bloc;

  // boilerplate for provider /bloc setup....
  SettingsProvider({Key key, Widget child})
      : bloc = SettingsBloc(),
        super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static SettingsBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(SettingsProvider)
            as SettingsProvider)
        .bloc;
  }
}
