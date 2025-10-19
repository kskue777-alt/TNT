import 'package:flutter/material.dart';

void main() {
  runApp(const TntApp());
}

class TntApp extends StatelessWidget {
  const TntApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TNT',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const HelloTntScreen(),
    );
  }
}

class HelloTntScreen extends StatelessWidget {
  const HelloTntScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello TNT'),
      ),
      body: const Center(
        child: Text(
          'Hello TNT',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
