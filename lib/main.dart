import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'injection_container.dart' as di;
import 'src/features/home/presentation/pages/home_page.dart';


void main() async {
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokedex',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue
      ),
      home: const HomePage(),
    );
  }
}