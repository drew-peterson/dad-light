import 'package:rxdart/rxdart.dart';
import 'dart:async';
import '../resources/settings.dart';

class SettingsBloc {
  final _selectedColor = BehaviorSubject<String>();

  // add data to stream
  Function(String) get setSelectedColor => _selectedColor.add;

  // get data from stream
  get selectedColor => _selectedColor.stream.transform(
        StreamTransformer.fromHandlers(
          handleData: (color, sink) async {
            print('Transform: $color');
            sink.add(color);
          },
        ),
      );

  fetchSelectedColor() async {
    final selectedcolor = await appSettings.getSelectedColor();
    _selectedColor.add(selectedcolor);
  }

  dispose() {
    _selectedColor.close();
  }
}
