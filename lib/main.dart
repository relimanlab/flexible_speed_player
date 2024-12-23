import 'package:flutter/material.dart';
import 'features/audio_player/presentation/screens/audio_player_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '音楽プレーヤー',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AudioPlayerScreen(),
    );
  }
}
