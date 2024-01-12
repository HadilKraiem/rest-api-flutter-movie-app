import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './pages/splash_page.dart';
import './pages/main_page.dart';

void main() {
  runApp(
    ProviderScope(
      child: SplashPage(
        key: UniqueKey(),
        onInitializationComplete: () => runApp(MyApp()),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
        child: MaterialApp(
            title: 'CinéHolic',
            initialRoute: 'home',
            routes: {
              'home': (BuildContext context) => MainPage(),
            },
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            )));
  }
}
