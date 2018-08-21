import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/colors_settings.dart';
import 'blocs/settings_provider.dart';
import 'screens/light.dart';
// import './app_constants.dart' as globals;

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
    return MaterialPageRoute(
      builder: (context) {
        final bloc = SettingsProvider.of(context);

        return StreamBuilder(
          stream: bloc.drewLight,
          builder: (lightContext, snapshot) {
            if (!snapshot.hasData) {
              return tabController();
            }

            if (snapshot.data) {
              return Light();
            }
            return tabController();
          },
        );
      },
    );
  }

  tabController() {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Text('Dad Light'),
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.lightbulb_outline)),
              Tab(icon: Icon(Icons.color_lens)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Home(),
            ColorsSettings(),
          ],
        ),
      ),
    );
  }
}
