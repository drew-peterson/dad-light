import 'package:rxdart/rxdart.dart';
import 'dart:io';
import 'dart:async';
import '../resources/settings.dart';
import 'package:sensors/sensors.dart';
import 'package:proximity_plugin/proximity_plugin.dart';
import 'package:screen/screen.dart';

class SettingsBloc {
  final _selectedColor = BehaviorSubject<String>();
  // final _lightEnabled = PublishSubject<bool>(); // return observerable
  final _lightEnabled = BehaviorSubject(); // return stream
  final _brightness = BehaviorSubject<double>();

  // add data to stream
  Function(String) get setSelectedColor => _selectedColor.add;
  Function(double) get setBrightness => _brightness.add;
  Function(bool) get setLightEnabled => _lightEnabled.add;

  // get data from stream
  get selectedColor => _selectedColor.stream.transform(
        StreamTransformer.fromHandlers(
          handleData: (color, sink) async {
            sink.add(color);
          },
        ),
      );

  get brightness => _brightness.stream.transform(
        StreamTransformer.fromHandlers(
          handleData: (value, sink) async {
            sink.add(value);
          },
        ),
      );

  Stream<bool> get drewLight => Observable.combineLatest2(
        _lightEnabled,
        _brightness,
        (enabled, b) {
          _setTest(enabled, b);
          return enabled;
        },
      );

  _setTest(enabled, b) async {
    if (enabled) {
      // print('ENABLED $b');
      Screen.setBrightness(b);
      // final test = await Screen.brightness;
      // print('brightness is now $test');
    } else {
      // print(' default ${appSettings.defaultBrightness}');
      Screen.setBrightness(appSettings.defaultBrightness);
    }
  }

  SettingsBloc() {
    print('.........INIT........');
    _init();
  }

  _init() async {
    final sc = await appSettings.getSelectedColor();
    final b = await appSettings.getBrightness();
    _selectedColor.add(sc);
    _brightness.add(b);
    _lightEnabled.add(false);

    proximityEvents.listen(_proximityEvents);
    accelerometerEvents.listen(_accelerometerEvents);
  }

  _accelerometerEvents(value) {
    if (value.z <= -3) {
      _lightEnabled.add(true);
    } else {
      _lightEnabled.add(false);
    }
  }

  _proximityEvents(value) {
    // Future<T> timeout(Duration timeLimit, {FutureOr<T> onTimeout()});
    if (value.x == 'Yes') {
      Screen.setBrightness(appSettings.defaultBrightness);
      Screen.keepOn(false);
      exit(0);
    }
  }

  // Stream<bool> get lightEnabled => Observable.combineLatest3(
  //       accelerometerEvents,
  //       proximityEvents,
  //       brightness,
  //       (a, p, b) {
  //         if (p.x == 'Yes') {
  //           Screen.setBrightness(appSettings.defaultBrightness);
  //           // Screen.keepOn(false);
  //           exit(0);
  //         }
  //         // print(a.z);
  //         if (a.z <= -3) {
  //           // print('SHOW----------------:');
  //           Screen.setBrightness(brightness);

  //           // Screen.keepOn(true);
  //           _lightEnabled.add(true);
  //           return true;
  //         }
  //         print('HIDE----------------');
  //         // Screen.keepOn(false);
  //         Screen.setBrightness(appSettings.defaultBrightness);
  //         _lightEnabled.add(false);
  //         return false;
  //       },
  //     );

  dispose() {
    _selectedColor.close();
    _lightEnabled.close();
    _brightness.close();
  }
}
