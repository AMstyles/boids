import 'dart:async';
import 'dart:math';

import 'package:boids/models/settings.dart';
import 'package:boids/pages/settings_screen.dart';
import 'package:boids/pages/simulation_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/boid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => BoidSettings()),
    ], child:MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  const Stack(
          children:[SimulationScreen(),
            SettingsScreen()
          ]
      ),
    ),
    );
  }
}

