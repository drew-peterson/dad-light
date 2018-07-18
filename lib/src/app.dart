import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/colors_settings.dart';
import 'screens/brightness_settings.dart';
import 'blocs/settings_provider.dart';
import 'screens/light.dart';

class App extends StatelessWidget {
  Widget build(context) {
    return SettingsProvider(
      child: MaterialApp(
        title: 'Dad Light',
        onGenerateRoute: routes,
      ),
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (context) {
          final bloc = SettingsProvider.of(context);
          bloc.fetchSelectedColor(); // default add to sink
          return tabController();
        },
      );
    } else {
      return MaterialPageRoute(
        builder: (context) {
          return Light();
        },
      );
    }
  }

  tabController() {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text('Dad Light'),
          bottom: TabBar(tabs: [
            Tab(icon: Icon(Icons.home)),
            Tab(icon: Icon(Icons.color_lens)),
            Tab(icon: Icon(Icons.lightbulb_outline)),
          ]),
        ),
        body: TabBarView(
          children: [
            Home(),
            ColorsSettings(),
            BrightnessSettings(),
          ],
        ),
      ),
    );
  }
}
