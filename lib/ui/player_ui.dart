import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_stream_music/player/audio_player.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final TextEditingController _urlController = TextEditingController(
    text: "http://你的NAS地址/rest/stream.view?u=用户名&p=密码&v=1.16.1&c=SimpleStreamMusic&id=歌曲ID",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Simple Stream Music"),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 音频URL输入框
            TextField(
              controller: _urlController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "音乐流URL（Subsonic/Navidrome）",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            // 播放控制按钮
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.play_arrow, size: 40),
                  onPressed: () => AudioPlayerManager.playUrl(_urlController.text),
                  color: Colors.blue,
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: const Icon(Icons.pause, size: 40),
                  onPressed: AudioPlayerManager.pause,
                  color: Colors.blue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
