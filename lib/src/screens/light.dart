import 'package:flutter/material.dart';
import '../blocs/settings_provider.dart';
import '../app_constants.dart' as globals;

class Light extends StatelessWidget {
  Widget build(context) {
    final bloc = SettingsProvider.of(context);

    return StreamBuilder(
      stream: bloc.selectedColor,
      builder: (context, snapshot) {
        print('Light ${snapshot.data}');
        if (!snapshot.hasData) {
          return Text('loading...');
        }
        return Container(
          color: globals.colorMap[snapshot.data],
          child: Center(
            child: RaisedButton(
              color: Colors.red,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('go back'),
            ),
          ),
        );
      },
    );
  }
}
