import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PingTalk',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    HomeWidget.widgetClicked.listen((_) async {
      // 위젯에서 바로 녹음 시작은 불가 → 네이티브 PttActivity 호출은 위젯 쪽에서 처리
    });
    AudioService.notificationClickEventStream.listen((_) {});
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _testPlayback() async {
    try {
      await _player.setAsset('assets/test_tone.mp3');
      _player.play();
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('테스트 톤 파일이 아직 준비되지 않았습니다.')),
        );
      }
    }
  }

  Future<void> _requestMic() async {
    final ok = await Permission.microphone.request().isGranted;
    if (!ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('마이크 권한을 허용해 주세요')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PingTalk (MVP)')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            FilledButton(
              onPressed: _requestMic,
              child: const Text('마이크 권한 요청'),
            ),
            const SizedBox(height: 12),
            FilledButton.tonal(
              onPressed: _testPlayback,
              child: const Text('수신 자동 재생 테스트(앱 내)'),
            ),
            const SizedBox(height: 12),
            const Text('홈 위젯에서 "PTT" 탭 → 전면 PttActivity → CaptureService 시작(녹음 골격).'),
          ],
        ),
      ),
    );
  }
}
