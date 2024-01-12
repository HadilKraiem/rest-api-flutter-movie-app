import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/services.dart';
import '../models/app_config.dart';
import '../services/http_service.dart';
import '../services/movie_service.dart';

class SplashPage extends StatefulWidget {
  final VoidCallback onInitializationComplete;
  const SplashPage({
    super.key,
    required this.onInitializationComplete,
  });

  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then((_) => _setup(context).then(
          (_) => widget.onInitializationComplete(),
        ));
  }

  // Future<void> _setup(BuildContext context) async {
  //   final getIt = GetIt.instance;
  //   final configFile = await rootBundle.loadString('assets/config/main.json');
  //   final configData = jsonDecode(configFile);
  //   getIt.registerSingleton<AppConfig>(
  //     AppConfig(
  //         baseAPIURL: configData['Base_Api_URL'],
  //         baseImageAPIURL: configData['BASE_IMAGE_API_URL'],
  //         apiKey: configData['API_KEY']),
  //   );
  // }
  Future<void> _setup(BuildContext context) async {
    print("Setting up...");
    try {
      final getIt = GetIt.instance;
      final configFile = await rootBundle.loadString('assets/config/main.json');
      print("Config File: $configFile");
      final configData = jsonDecode(configFile);
      print("Config Data: $configData");

      getIt.registerSingleton<AppConfig>(
        AppConfig(
          baseAPIURL: configData['Base_Api_URL'],
          baseImageAPIURL: configData['BASE_IMAGE_API_URL'],
          apiKey: configData['API_KEY'],
        ),
      );
      getIt.registerSingleton<HTTPService>(
        HTTPService(),
      );
      getIt.registerSingleton<MovieService>(
        MovieService(),
      );
      print("Setup completed.");
    } catch (e) {
      print("Error during setup: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CinéHolic',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Stack(
        fit: StackFit.expand, // Make the stack children fill the entire screen
        children: [
          Container(
            color: const Color.fromARGB(
                255, 80, 21, 91), // Set the background color to purple
          ),
          Center(
            child: Container(
              height: 400,
              width: 400,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage('assets/images/logo.png'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
