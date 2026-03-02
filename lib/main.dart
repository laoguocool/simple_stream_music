import 'package:flutter/material.dart';
import 'package:simple_stream_music/player/audio_player.dart';
import 'package:simple_stream_music/ui/player_ui.dart';

void main() {
  AudioPlayerManager.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SimpleStreamMusic',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      home: const PlayerScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
