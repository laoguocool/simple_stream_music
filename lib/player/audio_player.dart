import 'package:dio/dio.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'dart:io';

class AudioPlayerManager {
  static late FlutterSoundPlayer player;
  static bool isAndroid44 = true;

  // 初始化播放器（兼容 Android 4.4）
  static Future<void> init() async {
    player = FlutterSoundPlayer();
    await player.openAudioSession(
      audioFocus: AudioFocus.requestFocusAndStopOthers,
      category: SessionCategory.playback,
      mode: SessionMode.modeDefault,
      device: AudioDevice.speaker,
    );

    // 配置网络请求（兼容 Android 4.4 TLS 1.2）
    _initDio();
  }

  // 初始化 Dio（网络请求）
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

  // 播放网络音频流
  static Future<void> playUrl(String url) async {
    try {
      await player.startPlayer(
        fromURI: url,
        codec: Codec.mp3,  // 适配主流音乐格式
        whenFinished: () {},
      );
    } catch (e) {
      debugPrint("播放失败：$e");
    }
  }

  // 暂停播放
  static Future<void> pause() async {
    await player.pausePlayer();
  }

  // 停止播放
  static Future<void> stop() async {
    await player.stopPlayer();
  }
}
