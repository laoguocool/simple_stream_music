import 'dart:io';
import 'package:just_audio/just_audio.dart';
import 'package:dio/dio.dart';

class AudioPlayerManager {
  static late AudioPlayer player;
  static bool isAndroid44 = true;

  static Future<void> init() async {
    player = AudioPlayer();
    if (isAndroid44) {
      await player.setAudioAttributes(
        const AudioAttributes(
          contentType: AudioContentType.music,
          flags: AudioFlags.none,
          usage: AudioUsage.media,
        ),
      );
      player.setHandleInterruptions(false);
    }
    _initDio();
  }

  static void _initDio() {
    final dio = Dio();
    if (isAndroid44) {
      dio.options.connectTimeout = const Duration(seconds: 10);
      dio.options.receiveTimeout = const Duration(seconds: 10);
      dio.httpClientAdapter = HttpClientAdapter(
        createHttpClient: () => HttpClient()
          ..badCertificateCallback = (cert, host, port) => true,
      );
    }
  }

  static Future<void> playUrl(String url) async {
    try {
      await player.setUrl(
        url,
        preload: false,
      );
      await player.play();
    } catch (e) {
      debugPrint("播放失败：$e");
    }
  }

  static Future<void> pause() async {
    await player.pause();
  }

  static Future<void> stop() async {
    await player.stop();
  }
}
