import 'package:flutter/material.dart';
import '../blocs/settings_provider.dart';
import '../app_constants.dart' as globals;

class Light extends StatelessWidget {
  Widget build(context) {
    final bloc = SettingsProvider.of(context);

    return StreamBuilder(
      stream: bloc.selectedColor,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(color: Colors.grey);
        }
        return Container(
          color: globals.colorMap[snapshot.data],
          child: Center(
              // child: OutlineButton(
              //   color: globals.colorMap[snapshot.data],
              //   borderSide: BorderSide(color: Colors.black, width: 1.0),
              //   onPressed: () {
              //     bloc.setLightEnabled(false);
              //   },
              //   child: Text('BACK'),
              // ),
              ),
        );
      },
    );
  }
}
