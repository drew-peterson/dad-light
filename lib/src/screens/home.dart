import 'package:flutter/material.dart';
import '../blocs/settings_provider.dart';
import '../app_constants.dart' as globals;

class Home extends StatelessWidget {
  Widget build(context) {
    final bloc = SettingsProvider.of(context);

    return StreamBuilder(
        stream: bloc.selectedColor,
        builder: (colorContext, snapShot) {
          if (!snapShot.hasData) {
            return Text('loading home.....');
          }
          return Container(
            alignment: Alignment.center,
            color: globals.colorMap[snapShot.data],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.rotate_90_degrees_ccw,
                  size: 40.0,
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                ),
                Text(
                  'Rotate to turn on light!',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                RaisedButton(
                  onPressed: () => Navigator.pushNamed(context, '/light'),
                  child: Text('goto light'),
                ),
              ],
            ),
          );
        });
  }
}
