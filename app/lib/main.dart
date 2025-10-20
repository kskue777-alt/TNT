import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (_) => PushToTalkController(),
      child: const TntApp(),
    ),
  );
}

class TntApp extends StatefulWidget {
  const TntApp({super.key});

  @override
  State<TntApp> createState() => _TntAppState();
}

class _TntAppState extends State<TntApp> {
  late Future<void> _permissionsFuture;

  @override
  void initState() {
    super.initState();
    _permissionsFuture = _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    await [
      Permission.microphone,
      Permission.notification,
    ].request();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _permissionsFuture,
      builder: (context, _) {
        return MaterialApp(
          title: 'TNT',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
            useMaterial3: true,
          ),
          home: const HomeScreen(),
        );
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late final TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TNT'),
        bottom: TabBar(
          controller: _controller,
          tabs: const [
            Tab(text: '대화'),
            Tab(text: '친구'),
            Tab(text: '푸쉬앤토크'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: const [
          _PlaceholderTab(label: '대화 탭 준비 중'),
          _PlaceholderTab(label: '친구 탭 준비 중'),
          PushToTalkTab(),
        ],
      ),
    );
  }
}

class _PlaceholderTab extends StatelessWidget {
  const _PlaceholderTab({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        label,
        style: Theme.of(context).textTheme.titleLarge,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class PushToTalkTab extends StatelessWidget {
  const PushToTalkTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<PushToTalkController>();

    return Center(
      child: GestureDetector(
        onLongPressStart: (_) => controller.startRecording(),
        onLongPressEnd: (_) => controller.stopAndSend(),
        child: AnimatedScale(
          scale: controller.isRecording ? 1.05 : 1,
          duration: const Duration(milliseconds: 150),
          child: Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              color: controller.isRecording ? Colors.redAccent : Colors.deepOrange,
              borderRadius: BorderRadius.circular(110),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: const Text(
              'PUSH\n&\nTALK',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                fontSize: 32,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PushToTalkController extends ChangeNotifier {
  final MethodChannel _channel = const MethodChannel('ptt.service');
  bool _isRecording = false;

  bool get isRecording => _isRecording;

  Future<void> startRecording() async {
    if (_isRecording) return;
    _isRecording = true;
    notifyListeners();
    try {
      await _channel.invokeMethod('startRecording');
    } catch (_) {
      // TODO: handle integration errors when the native service is ready.
    }
  }

  Future<void> stopAndSend() async {
    if (!_isRecording) return;
    _isRecording = false;
    notifyListeners();
    try {
      await _channel.invokeMethod('stopAndSend');
    } catch (_) {
      // TODO: handle integration errors when the native service is ready.
    }
  }
}
